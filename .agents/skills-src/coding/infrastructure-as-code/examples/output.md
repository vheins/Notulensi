# Example Output: infrastructure-as-code

**Expected Output Shape:**
```hcl
# variables.tf
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
  default     = "my-api"
}

variable "db_password" {
  description = "RDS master password — provide via TF_VAR_db_password env var, never hardcode"
  type        = string
  sensitive   = true
}

# main.tf — VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  name    = "${var.app_name}-${var.environment}"
  cidr    = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  tags = { Environment = var.environment, ManagedBy = "terraform" }
}

# RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  identifier        = "${var.app_name}-${var.environment}"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = var.environment == "prod" ? "db.t3.medium" : "db.t3.micro"
  multi_az          = var.environment == "prod"
  storage_encrypted = true
  password          = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = var.environment != "prod"
  tags = { Environment = var.environment }
}

# outputs.tf
output "alb_dns_name" {
  description = "ALB DNS name for DNS configuration"
  value       = aws_lb.main.dns_name
}

output "ecr_repository_url" {
  description = "ECR URL for pushing Docker images"
  value       = aws_ecr_repository.app.repository_url
}
```

State Management:
```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "my-api/${var.environment}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

Usage:
```bash
terraform init -backend-config="environment=prod"
terraform plan -var="environment=prod" -var-file="prod.tfvars"
terraform apply -var="environment=prod" -var-file="prod.tfvars"
```


**Expected Output Shape:**
```typescript
// lib/api-stack.ts
import * as cdk from 'aws-cdk-lib';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';

export class ApiStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props: cdk.StackProps & { environment: string }) {
    super(scope, id, props);

    // DynamoDB table with encryption and point-in-time recovery
    const table = new dynamodb.Table(this, 'ItemsTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING },
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
      encryption: dynamodb.TableEncryption.AWS_MANAGED,
      pointInTimeRecovery: props.environment === 'prod',
      removalPolicy: props.environment === 'prod'
        ? cdk.RemovalPolicy.RETAIN
        : cdk.RemovalPolicy.DESTROY,
    });

    // Lambda with least-privilege permissions
    const handler = new lambda.Function(this, 'ApiHandler', {
      runtime: lambda.Runtime.NODEJS_20_X,
      code: lambda.Code.fromAsset('dist'),
      handler: 'index.handler',
      environment: { TABLE_NAME: table.tableName, ENVIRONMENT: props.environment },
    });

    // Grant only the permissions the Lambda needs
    table.grantReadWriteData(handler);

    // API Gateway
    const api = new apigateway.RestApi(this, 'Api', {
      restApiName: `my-api-${props.environment}`,
      deployOptions: { stageName: props.environment },
    });
    api.root.addProxy({ defaultIntegration: new apigateway.LambdaIntegration(handler) });

    new cdk.CfnOutput(this, 'ApiUrl', { value: api.url });
  }
}
```

Usage:
```bash
cdk bootstrap aws://ACCOUNT_ID/us-east-1
cdk deploy ApiStack --context environment=prod
```
