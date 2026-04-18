# Example Output: architecture-planning

**Expected Output Shape:**
```
1. Component Overview
- API Gateway: Routes requests, handles auth middleware. Technology: Express.js. Exposes: REST endpoints.
- Auth Service: Issues and validates JWT tokens. Technology: Node.js + Redis (token blacklist). Exposes: /auth/* endpoints.
- Task Service: CRUD for tasks and projects. Technology: Node.js + Prisma. Consumes: PostgreSQL.
- Webhook Dispatcher: Sends outbound webhooks on events. Technology: BullMQ + Node.js worker. Consumes: Redis queue.
- Cache Layer: Reduces DB load for read-heavy endpoints. Technology: Redis. Consumed by: API Gateway.

2. Data Flow Description
Critical Journey 1 — Create Task:
1. Client → POST /tasks → API Gateway
2. API Gateway validates JWT → Auth Service confirms token
3. API Gateway → Task Service → writes to PostgreSQL
4. Task Service emits "task.created" event → Redis queue
5. Webhook Dispatcher dequeues event → sends HTTP POST to registered webhook URLs

3. Technology Decisions
- PostgreSQL: Chosen for ACID compliance and multi-tenant row-level security. Rejected: MongoDB (schema flexibility not needed; joins required for reporting).
- Redis: Chosen for sub-millisecond cache reads and BullMQ job queue. Rejected: RabbitMQ (operational overhead; Redis sufficient at this scale).

4. Scalability Considerations
- API Gateway and Task Service are stateless → horizontal scaling via load balancer.
- PostgreSQL is the primary bottleneck → connection pooling via PgBouncer; read replicas for reporting queries.
- Redis cache for GET /projects and GET /tasks with 60s TTL reduces DB load by ~70% at peak.

5. Architecture Diagram
┌─────────────┐     HTTP      ┌─────────────────┐     SQL      ┌──────────────┐
│   Client    │ ──────────── ▶│   API Gateway   │ ──────────── ▶│  PostgreSQL  │
└─────────────┘               └────────┬────────┘               └──────────────┘
                                        │ Redis GET/SET
                               ┌────────▼────────┐
                               │   Redis Cache   │
                               └────────┬────────┘
                                        │ BullMQ enqueue
                               ┌────────▼────────────┐
                               │  Webhook Dispatcher  │ ──── HTTP ──▶ External
                               └─────────────────────┘
```


**Expected Output Shape:**
```
1. Component Overview
- Inference API: Accepts image uploads, returns job IDs for async tasks. Technology: FastAPI. Exposes: REST endpoints.
- Job Queue: Manages inference task queue. Technology: Celery + Redis broker.
- ML Worker: Runs object detection model. Technology: Python + PyTorch. Consumes: S3 for images.
- Result Store: Persists inference results. Technology: PostgreSQL.
- Object Storage: Stores uploaded images. Technology: AWS S3.

2. Data Flow Description
Critical Journey — Async Batch Inference:
1. Client → POST /infer/batch (multipart images) → Inference API
2. Inference API uploads images to S3 → returns job_id
3. Inference API enqueues Celery task with S3 keys
4. ML Worker dequeues task → downloads images from S3 → runs model
5. ML Worker writes results to PostgreSQL → updates job status to "complete"
6. Client polls GET /jobs/{job_id} → receives results when status is "complete"

3. Technology Decisions
- Celery + Redis: Chosen for mature Python async task processing. Rejected: AWS SQS (vendor lock-in; Redis already in stack).
- S3 for image storage: Chosen for durability and cost at scale. Rejected: local disk (not horizontally scalable).

4. Scalability Considerations
- ML Workers are stateless → scale horizontally by adding Celery worker instances.
- GPU workers isolated from CPU API workers to optimize resource allocation.
- S3 lifecycle policy auto-deletes images after 30 days to control storage costs.

5. Architecture Diagram
┌──────────┐  HTTP   ┌──────────────┐  S3 PUT  ┌──────┐
│  Client  │ ──────▶ │ Inference API│ ────────▶│  S3  │
└──────────┘         └──────┬───────┘          └──────┘
                             │ Celery enqueue
                    ┌────────▼────────┐  S3 GET  ┌──────┐
                    │   Redis Broker  │          │  S3  │
                    └────────┬────────┘          └──────┘
                             │ dequeue
                    ┌────────▼────────┐  SQL  ┌────────────┐
                    │   ML Worker     │ ─────▶│ PostgreSQL │
                    └─────────────────┘       └────────────┘
```
