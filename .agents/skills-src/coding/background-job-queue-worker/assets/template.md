# Background Job Specification Template

> Fill in all fields before activating the `background-job-queue-worker` skill.

---

## Job Definition

**Job Name:** `{{job-name}}` *(e.g. send-welcome-email)*

**Trigger:** {{what triggers this job — e.g. user registration, order placed, scheduled cron}}

**Payload:**
```json
{
  "{{field}}": "{{type}}",
  "{{field}}": "{{type}}"
}
```

**Processing Logic:** {{what the worker does with the payload}}

**Expected Volume:** {{e.g. ~500 jobs/hour, burst up to 2000}}

---

## Queue Requirements

| Setting | Value |
|---------|-------|
| Max retries | {{e.g. 3}} |
| Retry strategy | {{e.g. exponential backoff starting at 5s}} |
| Job timeout | {{e.g. 30s}} |
| Concurrency | {{e.g. 5 workers}} |
| Priority levels | {{e.g. high / normal / low}} |
| Dead letter queue | {{yes / no}} |
| Delay on first run | {{e.g. none, 10s}} |

---

## Tech Stack

**Stack:** {{e.g. Node.js + BullMQ + Redis, Python + Celery + RabbitMQ}}

**Queue Technology:** {{e.g. Redis 7, RabbitMQ 3.12}}

**Existing Infrastructure:** {{e.g. Redis already used for caching, connection string in REDIS_URL}}

---

## Additional Jobs (if multiple)

| Job Name | Trigger | Payload Fields | Volume |
|----------|---------|----------------|--------|
| `{{job-name}}` | {{trigger}} | {{fields}} | {{volume}} |
