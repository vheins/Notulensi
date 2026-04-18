# Example Output: ci-cd-pipeline-scripting

### Example 1: Node.js + TypeScript → AWS ECS (GitHub Actions)

**Expected Output:**
```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  release:
    types: [published]

env:
  AWS_REGION: us-east-1
  ECR_REPOSITORY: my-app

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm test -- --coverage

      - name: Security audit
        run: npm audit --audit-level=high

  build-image:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/tags/')
    outputs:
      image-tag: ${{ steps.meta.outputs.tags }}
    steps:
      - uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}
      - uses: aws-actions/amazon-ecr-login@v2
      - name: Build and push
        run: |
          IMAGE_TAG=${{ github.sha }}
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG

  deploy-staging:
    needs: build-image
    runs-on: ubuntu-latest
    environment: staging
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to ECS staging
        run: aws ecs update-service --cluster staging --service my-app --force-new-deployment

  deploy-production:
    needs: build-image
    runs-on: ubuntu-latest
    environment: production  # Requires manual approval in GitHub Environments settings
    if: startsWith(github.ref, 'refs/tags/')
    steps:
      - name: Deploy to ECS production
        run: aws ecs update-service --cluster production --service my-app --force-new-deployment
```

Required Secrets: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (IAM user with ECR push + ECS update permissions)

---

### Example 2: Python + FastAPI → Kubernetes (GitLab CI)

**Expected Output:**
```yaml
# .gitlab-ci.yml
stages: [test, build, deploy-dev, deploy-prod]

variables:
  DOCKER_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

test:
  stage: test
  image: python:3.11-slim
  cache:
    paths: [.pip-cache/]
  script:
    - pip install --cache-dir .pip-cache -r requirements.txt
    - mypy app/
    - pytest --cov=app tests/
  coverage: '/TOTAL.*\s+(\d+%)$/'

build:
  stage: build
  image: docker:24
  services: [docker:24-dind]
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build -t $DOCKER_IMAGE .
    - docker push $DOCKER_IMAGE
  only: [main, /^feature\/.*/]

deploy-dev:
  stage: deploy-dev
  script:
    - helm upgrade --install my-app ./helm --set image.tag=$CI_COMMIT_SHA --namespace dev
  environment: { name: dev, url: https://dev.myapp.com }
  only: [/^feature\/.*/]

deploy-prod:
  stage: deploy-prod
  script:
    - helm upgrade --install my-app ./helm --set image.tag=$CI_COMMIT_SHA --namespace prod
  environment: { name: production, url: https://myapp.com }
  when: manual
  only: [main]
```

Required Variables: CI_REGISTRY_USER, CI_REGISTRY_PASSWORD (GitLab built-in), KUBECONFIG (base64-encoded kubeconfig)
