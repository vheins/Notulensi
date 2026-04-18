# Infrastructure as Code Specification Template

> Fill in all fields before activating the `infrastructure-as-code` skill.

---

## Infrastructure Overview

**Cloud Provider:** {{AWS / GCP / Azure / DigitalOcean / Hetzner}}

**IaC Tool:** {{Terraform / Pulumi / CDK / Bicep / CloudFormation}}

**Environment:** {{dev / staging / production / all}}

---

## Resources to Provision

### Compute

| Resource | Type | Size / Config | Count |
|----------|------|---------------|-------|
| {{e.g. App Server}} | {{e.g. EC2, Cloud Run, ECS}} | {{e.g. t3.medium, 1 vCPU 512MB}} | {{e.g. 2}} |

### Database

| Resource | Engine | Size | HA? |
|----------|--------|------|-----|
| {{e.g. Primary DB}} | {{e.g. PostgreSQL 15}} | {{e.g. db.t3.medium}} | {{yes/no}} |

### Networking

| Resource | Config |
|----------|--------|
| VPC | {{e.g. 10.0.0.0/16, 2 AZs}} |
| Subnets | {{e.g. 2 public, 2 private}} |
| Load Balancer | {{e.g. ALB, HTTPS only}} |
| DNS | {{e.g. Route53, Cloudflare}} |

### Storage

| Resource | Type | Size | Access |
|----------|------|------|--------|
| {{e.g. File uploads}} | {{e.g. S3, GCS}} | {{e.g. unlimited}} | {{private / public}} |

---

## Security Requirements

| Requirement | Config |
|-------------|--------|
| HTTPS only | {{yes/no}} |
| DB not publicly accessible | {{yes/no}} |
| Secrets management | {{e.g. AWS SSM, Vault, env vars}} |
| IAM / service accounts | {{describe permissions needed}} |

---

## State Management

**Terraform state backend:** {{e.g. S3 + DynamoDB lock, Terraform Cloud, local}}

**State file location:** `{{e.g. s3://my-bucket/terraform/state.tfstate}}`
