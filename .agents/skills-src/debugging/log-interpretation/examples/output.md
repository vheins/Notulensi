# Example Output: log-interpretation

**Expected Output Shape:**
```
1. Log Summary
6 entries over 90 seconds. Mix of INFO, WARN, ERROR, FATAL. Health signal: degraded — error storm beginning at 14:02:45.

2. Anomaly Detection
- Error storm: DB query timeout repeated at 14:02:45 (2 identical entries in <1s)
- Latency outlier: GET /api/orders jumped from 45ms to 5023ms
- Connection pool exhaustion at 14:03:01 — critical signal

3. Timeline of Events
[14:02:31] INFO  Normal request — 45ms response
[14:02:45] ERROR DB timeout begins — new query likely causing full table scan
[14:02:46] WARN  Retry logic triggered
[14:03:01] FATAL Pool exhausted — all connections blocked by slow query
[14:03:01] ERROR User-facing 500 error

4. Error Pattern Analysis
DB query timeout: 2 occurrences, first at 14:02:45, triggered immediately after deployment

5. Root Cause Hypothesis (High confidence)
The new order aggregation query deployed at 14:00 UTC is performing a full table scan, causing 5s+ timeouts that exhaust the connection pool and produce cascading 500 errors.

6. Next Steps
1. Run EXPLAIN on the new aggregation query
2. Check slow query log for queries >1s since 14:00 UTC
3. Roll back the deployment to confirm hypothesis
```


**Expected Output Shape:**
```
1. Log Summary
5 entries over 2 minutes. CRITICAL worker timeout followed by worker restart. Health signal: degraded — workers crashing due to external dependency failure.

2. Anomaly Detection
- Connection refused errors at 09:15:45 — external service unreachable
- Worker timeout at 09:16:00 — Gunicorn worker killed after hanging on connection attempt
- Worker restart cycle — indicates recurring crash, not one-time event

3. Timeline of Events
[09:14:00] (external) Redis restarted for maintenance
[09:15:02] INFO  Gunicorn worker started normally
[09:15:45] ERROR Connection refused — worker attempts to reach Redis, fails
[09:16:00] CRITICAL Worker timeout — Gunicorn kills hung worker
[09:16:00] INFO  New worker spawned — cycle will repeat

4. Error Pattern Analysis
Connection refused: 2 occurrences at 09:15:45, triggered by Redis restart at 09:14

5. Root Cause Hypothesis (High confidence)
Redis restart at 09:14 caused connection refused errors. Django's cache backend has no retry or circuit breaker, causing Gunicorn workers to hang until timeout.

6. Next Steps
1. Add Redis connection retry with exponential backoff in Django cache settings
2. Implement a circuit breaker for cache operations
3. Add a health check that degrades gracefully when Redis is unavailable
```
