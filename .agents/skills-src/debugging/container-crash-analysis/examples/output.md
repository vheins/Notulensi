# Example Output: container-crash-analysis

**Expected Output Shape:**
```
1. Crash Type Identification
OOMKilled — container exceeded the 256Mi memory limit. Exit code 137 confirms kernel OOM killer terminated the process.

2. Root Cause Analysis
The batch job loads all 50,000 records into memory simultaneously. At ~5KB per record, this requires ~250MB — just under the limit. Any additional overhead (Node.js heap, buffers) pushes it over 256Mi.

3. Fix
Option A: Increase memory limit (short-term):
  resources:
    requests:
      memory: "256Mi"
    limits:
      memory: "512Mi"

Option B: Process records in chunks (recommended):
  // Instead of: const records = await db.findAll()
  // Use streaming/pagination:
  for await (const batch of db.findInBatches({ batchSize: 1000 })) {
    await processBatch(batch);
  }

4. Resource Tuning
Run kubectl top pod during normal operation to measure baseline memory.
Set requests = actual baseline usage, limits = 2x requests.
Consider VPA for automatic right-sizing: kubectl apply -f vpa.yaml

5. Monitoring Setup
Alert rule (Prometheus):
  kube_pod_container_status_last_terminated_reason{reason="OOMKilled"} > 0
  → Alert: "Pod OOMKilled in namespace {{namespace}}"
```


**Expected Output Shape:**
```
1. Crash Type Identification
Startup failure — application crashes immediately because the database is not yet accepting connections when the app starts. Docker Compose starts containers in parallel by default.

2. Root Cause Analysis
The app container starts and immediately tries to connect to PostgreSQL. The db container is still initializing (PostgreSQL takes 2-5 seconds to be ready). The connection is refused → app exits with code 1 → Docker Compose restarts it → same failure.

3. Fix
Add a healthcheck and depends_on condition in docker-compose.yml:

services:
  db:
    image: postgres:15
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

  app:
    build: .
    depends_on:
      db:
        condition: service_healthy  # wait for DB healthcheck to pass

Alternative: Add retry logic in the application:
  import time
  for attempt in range(10):
    try: connect_to_db(); break
    except: time.sleep(2 ** attempt)  # exponential backoff

4. Resource Tuning
Not applicable — this is a startup ordering issue, not a resource issue.

5. Monitoring Setup
Add a startup probe in production Kubernetes:
  startupProbe:
    httpGet: { path: /health, port: 8000 }
    failureThreshold: 30
    periodSeconds: 10  # allow 5 minutes for startup
```
