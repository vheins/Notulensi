# Example Input: capacity-planning

### Example 1: Node.js + PostgreSQL + Redis — SaaS API on AWS
**Input:**
- `{{system_description}}`: "REST API serving a project management SaaS. Components: Node.js API servers, PostgreSQL database, Redis cache, S3 for file storage."
- `{{expected_load}}`: "5k DAU at launch, 50k DAU in 12 months. Peak: 200 req/s. 70% reads, 30% writes. Average response payload 5KB. 10GB new data/month."
- `{{tech_stack}}`: "Node.js + PostgreSQL + Redis + AWS ECS + RDS + S3"


### Example 2: Python + FastAPI + Celery — ML Inference Platform on GCP
**Input:**
- `{{system_description}}`: "ML inference API. Components: FastAPI inference server, Celery workers for async jobs, PostgreSQL for job results, Redis for job queue, GCS for model artifacts and input files."
- `{{expected_load}}`: "1k inference requests/hour at launch, 10k/hour in 6 months. Each inference takes 2–5 seconds. Average input file 2MB. Results stored 30 days."
- `{{tech_stack}}`: "Python + FastAPI + Celery + PostgreSQL + Redis + GCP Cloud Run + Cloud SQL + GCS"
