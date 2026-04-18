# Example Output: performance-bottleneck-analysis

**Expected Output Shape:**
```
1. Bottleneck Inventory
- json.Marshal: CPU-bound, 65% of CPU time, ~290ms per request at p99
- No caching: I/O-bound, every request hits DB, 2ms × 500 RPS = 1000 DB queries/sec
- DB connection pool: potential lock contention under higher load

2. Priority Matrix
| Bottleneck       | Impact | Effort | Priority |
|-----------------|--------|--------|----------|
| JSON serialization | High  | Medium | 1        |
| Missing cache    | High   | Medium | 2        |
| Connection pool  | Low    | Low    | 3        |

3. Top 3 Optimizations
#1 Replace encoding/json with sonic or protobuf for serialization — expected 60-70% CPU reduction
#2 Add Redis cache with 60s TTL for user objects — expected 80% DB load reduction
#3 Increase connection pool from default 10 to 50 — prevents future contention

4. Quick Wins
- Enable gzip compression on gRPC responses (1 line config change)
- Add DB index on users.id if not already present

5. Measurement Plan
Baseline: p99=450ms, CPU=65% json.Marshal
Target: p99<100ms, CPU<20% json.Marshal
Measure with: pprof after each change, wrk load test at 500 RPS
```


**Expected Output Shape:**
```
1. Bottleneck Inventory
- N+1 query: I/O-bound, 46 extra queries per request (1 for posts + 1 per author), 78% of request time
- No query result caching: every request re-executes the same query
- Synchronous rendering: no async processing for non-critical data

2. Priority Matrix
| Bottleneck    | Impact | Effort | Priority |
|--------------|--------|--------|----------|
| N+1 query    | High   | Low    | 1        |
| No caching   | High   | Medium | 2        |
| Sync render  | Medium | High   | 3        |

3. Top 3 Optimizations
#1 Add select_related('author') to eliminate N+1 — reduces 47 queries to 1, expected 70% latency reduction
Before: Post.objects.filter(published=True)
After:  Post.objects.filter(published=True).select_related('author')

#2 Cache query result in Redis with 30s TTL using django-cache-machine
#3 Move non-critical data (view counts, related posts) to async Celery tasks

4. Quick Wins
- Add select_related('author') — 5 minute change, immediate 70% improvement
- Add DB index on posts.published if missing

5. Measurement Plan
Baseline: 47 queries/request, p99=800ms
Target: 1 query/request, p99<100ms
Measure with: Django Debug Toolbar query count, New Relic after deploy
```
