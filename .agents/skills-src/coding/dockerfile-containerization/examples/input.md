# Example Input: dockerfile-containerization

### Example 1: Node.js + TypeScript API
**Input:**
- `{{tech_stack}}`: Node.js 20 + TypeScript + Express
- `{{app_description}}`: "REST API server. Entry point: dist/index.js after TypeScript compilation. Listens on PORT env var (default 3000). Requires PostgreSQL and Redis."
- `{{deployment_target}}`: "AWS ECS Fargate"


### Example 2: Python + FastAPI
**Input:**
- `{{tech_stack}}`: Python 3.11 + FastAPI + Uvicorn
- `{{app_description}}`: "Async REST API. Entry: uvicorn app.main:app. Port 8000. Requires PostgreSQL."
- `{{deployment_target}}`: "Kubernetes (GKE)"
