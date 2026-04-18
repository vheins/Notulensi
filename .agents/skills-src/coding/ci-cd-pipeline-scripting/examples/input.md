# Example Input: ci-cd-pipeline-scripting

### Example 1: Node.js + TypeScript → AWS ECS (GitHub Actions)

**Input:**
- `{{tech_stack}}`: Node.js 20 + TypeScript + Express + Docker
- `{{deployment_target}}`: AWS ECS (Fargate) with ECR for container registry
- `{{pipeline_requirements}}`: "GitHub Actions, environments: staging (auto on main) + production (manual approval), Jest tests, ESLint, Docker build"

---

### Example 2: Python + FastAPI → Kubernetes (GitLab CI)

**Input:**
- `{{tech_stack}}`: Python 3.11 + FastAPI + Docker
- `{{deployment_target}}`: Kubernetes cluster via kubectl + Helm
- `{{pipeline_requirements}}`: "GitLab CI, environments: dev (auto on feature branches) + prod (manual on main), pytest, mypy, Docker build, Helm deploy"
