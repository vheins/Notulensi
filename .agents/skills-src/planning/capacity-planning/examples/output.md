# Example Output: capacity-planning

**Expected Output Shape:**
```
1. Load Analysis
- Peak RPS: 200 req/s; Average RPS: ~60 req/s (assuming 8-hour active window)
- Read/write ratio: 70/30
- Data ingestion: 10GB/month = ~330MB/day
- Concurrent users at peak: ~500 (assuming 2.5s avg session request rate)
- Assumption: No major seasonal spikes; traffic grows linearly

2. Resource Requirements
| Component | CPU (vCPUs) | Memory (GB) | Storage | Bandwidth |
|-----------|-------------|-------------|---------|-----------|
| API Server (ECS) | 2 vCPU × 3 tasks | 2GB × 3 tasks | N/A | 50GB/month egress |
| PostgreSQL (RDS) | db.t3.medium (2 vCPU) | 4GB | 100GB SSD | Internal |
| Redis (ElastiCache) | cache.t3.small | 1.5GB | N/A | Internal |
| S3 | N/A | N/A | 120GB year 1 | 20GB/month egress |

3. Scaling Strategy
- API Servers: Horizontal; scale out when CPU > 70% for 5 min; max 10 tasks before DB becomes bottleneck
- PostgreSQL: Vertical first (t3.medium → t3.large); add read replica at 30k DAU
- Redis: Vertical; upgrade instance size at 80% memory utilization

4. Cost Estimate (AWS, us-east-1, approximate)
- ECS (3 × t3.small): ~$45/month at launch
- RDS PostgreSQL (db.t3.medium): ~$60/month
- ElastiCache (cache.t3.small): ~$25/month
- S3 (120GB + egress): ~$15/month
- Total at launch: ~$145/month
- Total at 50k DAU (12 months): ~$600–800/month (estimated with read replica + larger instances)

5. Bottlenecks
1. PostgreSQL connection pool — bottlenecks at ~20k DAU; mitigate with PgBouncer connection pooler
2. API server memory — bottlenecks at 150 req/s sustained; mitigate with horizontal scaling trigger at 70% CPU
3. S3 egress cost — not a performance bottleneck but cost bottleneck at 1TB+; mitigate with CloudFront CDN
```


**Expected Output Shape:**
```
1. Load Analysis
- Peak RPS: ~2.8 req/s (10k/hour); Average: ~0.28 req/s (1k/hour)
- Each job: 2–5s CPU-bound processing
- Data ingestion: 10k × 2MB = 20GB input/day at peak; results ~1KB each
- Concurrent workers needed at peak: 10k/hour ÷ 3600s × 3.5s avg = ~10 concurrent workers
- Storage: 20GB/day × 30 days = 600GB GCS at steady state

2. Resource Requirements
| Component | CPU (vCPUs) | Memory (GB) | Storage | Bandwidth |
|-----------|-------------|-------------|---------|-----------|
| FastAPI (Cloud Run) | 1 vCPU × 5 instances | 2GB × 5 | N/A | 5GB/month |
| Celery Workers | 2 vCPU × 10 workers | 4GB × 10 | N/A | Internal |
| PostgreSQL (Cloud SQL) | 2 vCPU | 8GB | 50GB SSD | Internal |
| Redis | 1 vCPU | 2GB | N/A | Internal |
| GCS | N/A | N/A | 600GB | 30GB/month egress |

3. Scaling Strategy
- Celery Workers: Horizontal; scale based on Redis queue depth > 50 jobs; max 50 workers
- FastAPI: Cloud Run auto-scales to 0; set min instances = 2 to avoid cold starts
- PostgreSQL: Vertical; upgrade at 80% CPU sustained

4. Cost Estimate (GCP, approximate)
- Cloud Run (5 instances): ~$80/month
- Celery Workers (10 × n1-standard-2): ~$200/month
- Cloud SQL (db-n1-standard-2): ~$120/month
- GCS (600GB + egress): ~$25/month
- Total at launch: ~$150/month; at 10k/hour: ~$425/month

5. Bottlenecks
1. Celery worker count — bottlenecks at 5k/hour; mitigate with auto-scaling on queue depth
2. GCS egress cost — 600GB/month egress becomes expensive; mitigate with 30-day lifecycle deletion policy
3. PostgreSQL write throughput — 10k result writes/hour is manageable but monitor at 50k/hour
```
