# CI/CD Pipeline Specification Template

> Fill in all fields before activating the `ci-cd-pipeline-scripting` skill.

---

## Application

**Tech Stack:** {{e.g. Node.js 20 + TypeScript + Docker}}

**Deployment Target:** {{e.g. AWS ECS Fargate, Kubernetes, Heroku, Vercel, VPS via SSH}}

**Container Registry:** {{e.g. AWS ECR, Docker Hub, GitHub Container Registry, none}}

---

## CI Platform

**Platform:** {{GitHub Actions / GitLab CI / CircleCI / Bitbucket Pipelines}}

**Trigger Strategy:**
| Branch/Event | Action |
|--------------|--------|
| Push to `main` | {{e.g. deploy to staging automatically}} |
| Push to `develop` | {{e.g. run tests only}} |
| Pull request | {{e.g. run tests + lint}} |
| Tag `v*` | {{e.g. deploy to production}} |

---

## Pipeline Stages

| Stage | Include? | Notes |
|-------|----------|-------|
| Lint | {{yes/no}} | {{e.g. ESLint, golangci-lint}} |
| Type check | {{yes/no}} | {{e.g. tsc --noEmit}} |
| Unit tests | {{yes/no}} | {{e.g. Jest, pytest}} |
| Integration tests | {{yes/no}} | {{e.g. requires DB}} |
| Security scan | {{yes/no}} | {{e.g. Trivy, Snyk}} |
| Docker build | {{yes/no}} | |
| Docker push | {{yes/no}} | |
| Deploy staging | {{yes/no}} | {{auto / manual approval}} |
| Deploy production | {{yes/no}} | {{auto / manual approval}} |

---

## Environments

| Environment | URL | Deploy Trigger | Approval |
|-------------|-----|----------------|----------|
| staging | `{{url}}` | {{e.g. push to main}} | {{none / required}} |
| production | `{{url}}` | {{e.g. tag v*}} | {{required}} |

---

## Secrets / Env Vars Needed

| Secret Name | Description |
|-------------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS credentials |
| `AWS_SECRET_ACCESS_KEY` | AWS credentials |
| `{{SECRET_NAME}}` | {{description}} |
