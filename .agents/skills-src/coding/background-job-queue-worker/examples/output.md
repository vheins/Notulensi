# Example Output: background-job-queue-worker

### Example 1: Node.js + BullMQ + Redis

**Expected Output:**
```typescript
import { Queue, Worker, QueueEvents, Job } from 'bullmq';
import Redis from 'ioredis';

const connection = new Redis(process.env.REDIS_URL, { maxRetriesPerRequest: null });

// Job type definitions
interface EmailJobPayload {
  to: string;
  template: 'welcome' | 'password_reset' | 'order_confirmation';
  data: Record<string, unknown>;
}

// Producer
const emailQueue = new Queue<EmailJobPayload>('email', {
  connection,
  defaultJobOptions: {
    attempts: 3,
    backoff: { type: 'exponential', delay: 5000 }, // 5s, 10s, 20s
    removeOnComplete: { count: 1000 },
    removeOnFail: false, // Keep failed jobs for inspection
  },
});

export async function enqueueEmail(payload: EmailJobPayload, options?: { delay?: number }) {
  const job = await emailQueue.add('send-email', payload, {
    delay: options?.delay,
    // Deduplication: prevent duplicate emails for same recipient+template within 1 hour
    jobId: `email:${payload.to}:${payload.template}:${Math.floor(Date.now() / 3600000)}`,
  });
  logger.info({ jobId: job.id, to: payload.to, template: payload.template }, 'Email job enqueued');
  return job.id;
}

// Worker
const emailWorker = new Worker<EmailJobPayload>(
  'email',
  async (job: Job<EmailJobPayload>) => {
    const { to, template, data } = job.data;
    logger.info({ jobId: job.id, attempt: job.attemptsMade + 1, to, template }, 'Processing email job');

    await emailService.send({ to, template, data });

    logger.info({ jobId: job.id, to, template }, 'Email sent successfully');
  },
  {
    connection,
    concurrency: 5,
    limiter: { max: 100, duration: 60000 }, // 100 emails/minute rate limit
  }
);

// Dead letter queue handling
emailWorker.on('failed', async (job, err) => {
  if (job && job.attemptsMade >= job.opts.attempts!) {
    logger.error({ jobId: job.id, payload: job.data, err: err.message }, 'Job moved to dead letter');
    await db.query(
      'INSERT INTO dead_letter_jobs (queue, job_id, payload, error, failed_at) VALUES ($1,$2,$3,$4,NOW())',
      ['email', job.id, JSON.stringify(job.data), err.message]
    );
  }
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  await emailWorker.close();
  await emailQueue.close();
});
```

---

### Example 2: Python + Celery + RabbitMQ

**Expected Output:**
```python
# celery_app.py
from celery import Celery
from celery.utils.log import get_task_logger

app = Celery('reports',
    broker=os.environ['RABBITMQ_URL'],
    backend=os.environ['REDIS_URL'],
)

app.conf.update(
    task_serializer='json',
    result_expires=3600,
    worker_concurrency=2,
    task_time_limit=600,  # 10 minute hard timeout
    task_soft_time_limit=540,  # 9 minute soft timeout (raises SoftTimeLimitExceeded)
    task_acks_late=True,  # Acknowledge after processing (not before) for reliability
    task_reject_on_worker_lost=True,
)

logger = get_task_logger(__name__)

@app.task(
    bind=True,
    max_retries=2,
    default_retry_delay=10,
    queue='reports',
    name='generate_report',
)
def generate_report(self, report_type: str, user_id: str, date_range: dict):
    logger.info(f"Processing report job {self.request.id}, attempt {self.request.retries + 1}")
    try:
        result = report_service.generate(report_type, user_id, date_range)
        logger.info(f"Report generated: {self.request.id}")
        return {"status": "completed", "report_url": result.url}
    except TransientError as exc:
        # Retryable: exponential backoff
        raise self.retry(exc=exc, countdown=10 * (2 ** self.request.retries))
    except PermanentError as exc:
        # Non-retryable: log and move to dead letter
        logger.error(f"Permanent failure for job {self.request.id}: {exc}")
        dead_letter_service.save(self.request.id, report_type, user_id, str(exc))
        raise  # Don't retry

# Producer (FastAPI endpoint)
@router.post("/reports")
async def request_report(body: ReportRequest, user=Depends(get_current_user)):
    task = generate_report.apply_async(
        args=[body.report_type, user.id, body.date_range],
        priority=9 if user.is_premium else 5,  # Higher priority for premium users
    )
    return {"job_id": task.id, "status": "queued"}
```
