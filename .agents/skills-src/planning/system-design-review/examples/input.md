# Example Input: system-design-review

### Example 1: Node.js + PostgreSQL — SaaS API (Early Stage)
**Input:**
- `{{system_description}}`: "Single Node.js Express server handling all API requests. PostgreSQL database on the same VM. No caching. File uploads stored on local disk. JWT auth with 30-day expiry. No logging infrastructure. Deployed manually via SSH."
- `{{tech_stack}}`: "Node.js + Express + PostgreSQL + local disk storage"
- `{{scale_requirements}}`: "500 users now, targeting 10k users in 6 months"


### Example 2: Python + FastAPI + Microservices — Growing Platform
**Input:**
- `{{system_description}}`: "5 microservices communicating via synchronous HTTP calls. Shared PostgreSQL database across all services. No service mesh. Redis for session storage. Services deployed on Kubernetes. No distributed tracing. Each service has its own deployment pipeline."
- `{{tech_stack}}`: "Python + FastAPI + PostgreSQL (shared) + Redis + Kubernetes"
- `{{scale_requirements}}`: "20k DAU, targeting 200k DAU in 18 months"
