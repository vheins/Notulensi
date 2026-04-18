# Example Input: background-job-queue-worker

### Example 1: Node.js + BullMQ + Redis

**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + BullMQ + Redis
- `{{job_description}}`: "Email sending jobs (welcome email, password reset, order confirmation). Payload: { to: string, template: string, data: object }. ~1000 jobs/hour."
- `{{queue_requirements}}`: "Max 3 retries, exponential backoff starting at 5s, 30s job timeout, 5 concurrent workers, failed jobs to dead letter queue."

---

### Example 2: Python + Celery + RabbitMQ

**Input:**
- `{{tech_stack}}`: Python + FastAPI + Celery + RabbitMQ + Redis (result backend)
- `{{job_description}}`: "Report generation jobs. Payload: { report_type: str, user_id: str, date_range: dict }. Long-running: 30s–5min per job."
- `{{queue_requirements}}`: "Max 2 retries, 10s initial backoff, 10min job timeout, 2 concurrent workers, priority queue (high/normal)."
