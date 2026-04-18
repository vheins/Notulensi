# Example Input: architecture-planning

### Example 1: Node.js + PostgreSQL + Redis — SaaS API Platform
**Input:**
- `{{project_description}}`: "A multi-tenant SaaS API platform for project management. Teams create projects, assign tasks, and track progress. Supports webhooks for third-party integrations."
- `{{tech_stack}}`: Node.js + Express + PostgreSQL + Redis + BullMQ
- `{{scale_requirements}}`: "50k DAU, 500 req/s peak, 99.9% uptime, sub-300ms API response at p95"


### Example 2: Python + FastAPI + Celery — ML Inference Platform
**Input:**
- `{{project_description}}`: "An ML inference platform that accepts image uploads, runs object detection models, and returns structured JSON results. Supports async processing for large batches."
- `{{tech_stack}}`: Python + FastAPI + Celery + Redis + PostgreSQL + S3
- `{{scale_requirements}}`: "1k inference requests/hour, async batch up to 500 images, results stored 30 days"
