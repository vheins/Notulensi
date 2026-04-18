# Example Input: container-crash-analysis

### Example 1: Kubernetes — OOMKilled Node.js Application
**Input:**
- `{{tech_stack}}`: Node.js + Kubernetes (GKE)
- `{{container_logs}}`: `[2025-01-15 14:23:01] INFO Server started on port 3000\n[2025-01-15 14:23:45] INFO Processing batch job: 50000 records\n[2025-01-15 14:24:12] INFO Loading all records into memory...\nKilled`
- `{{pod_description}}`: `Last State: Terminated\n  Reason: OOMKilled\n  Exit Code: 137\nLimits: memory: 256Mi\nRequests: memory: 128Mi`
- `{{context}}`: Batch processing job that loads records into memory; memory limit is 256Mi; crashes during large batch runs


### Example 2: Docker Compose — CrashLoopBackOff on Startup
**Input:**
- `{{tech_stack}}`: Python + FastAPI + Docker Compose
- `{{container_logs}}`: `Starting application...\nConnecting to database...\npsycopg2.OperationalError: could not connect to server: Connection refused\n\tIs the server running on host "db" (172.20.0.2) and accepting\n\tTCP/IP connections on port 5432?\nProcess finished with exit code 1`
- `{{pod_description}}`: Not applicable (Docker Compose)
- `{{context}}`: FastAPI app depends on PostgreSQL; app container starts before DB is ready; crashes immediately on startup
