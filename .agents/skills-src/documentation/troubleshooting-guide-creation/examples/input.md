# Example Input: troubleshooting-guide-creation

### Example 1: Node.js API Service
**Input:**
- `{{system_name}}`: "payments-api"
- `{{tech_stack}}`: "Node.js 20, Express 4, PostgreSQL 15, Redis 7, Docker Compose"
- `{{known_issues}}`: "database connection refused on startup, Redis cache miss causing slow responses, JWT token validation failures, out-of-memory crashes under load"
- `{{target_audience}}`: "developers"


### Issue: Database Connection Refused on Startup

- **Symptom**: The API process exits immediately after starting with a non-zero exit code. No HTTP traffic is served.
- **Error Message**: `Error: connect ECONNREFUSED 127.0.0.1:5432`
- **Root Cause**: The API attempts to connect to PostgreSQL at startup before the database container or service is ready to accept connections.
- **Diagnostic Steps**:
  1. Check if PostgreSQL is running: `docker compose ps db`
  2. Attempt a manual connection: `psql $DATABASE_URL -c "SELECT 1;"`
  3. Inspect container logs: `docker compose logs db --tail=50`
- **Resolution**:
  1. If using Docker Compose, add a `healthcheck` and `depends_on` condition to the API service so it waits for the DB to be healthy before starting.
  2. If running locally without Docker, start PostgreSQL: `brew services start postgresql@15` (macOS) or `sudo systemctl start postgresql` (Linux).
  3. Verify `DATABASE_URL` in `.env` matches the running instance's host, port, and credentials.
- **Prevention**: Add a startup readiness check in the application that retries the DB connection up to 5 times with exponential backoff before exiting. Add a Datadog or Prometheus alert for connection pool exhaustion.

---


### Issue: JWT Token Validation Failures

- **Symptom**: Authenticated API requests return 401 responses. Users are logged out unexpectedly or cannot log in.
- **Error Message**: `JsonWebTokenError: invalid signature`
- **Root Cause**: The `JWT_SECRET` environment variable differs between the service that issued the token and the service validating it, causing signature mismatch.
- **Diagnostic Steps**:
  1. Compare `JWT_SECRET` values across all running instances: `printenv JWT_SECRET`
  2. Decode the token payload (without verification) to check the `iss` claim: `echo "<token>" | cut -d. -f2 | base64 -d`
  3. Check for recent deployments that may have rotated the secret.
- **Resolution**:
  1. Ensure all instances share the same `JWT_SECRET` value via a secrets manager (AWS Secrets Manager, Vault, etc.).
  2. If the secret was rotated, issue new tokens to affected users by invalidating existing sessions.
  3. Redeploy all instances with the correct secret value.
- **Prevention**: Store `JWT_SECRET` in a centralized secrets manager and inject it at deploy time. Never hardcode or commit secrets to version control. Add an integration test that validates token round-trips across service boundaries.
```


### Example 2: Python ML Pipeline
**Input:**
- `{{system_name}}`: "ml-training-pipeline"
- `{{tech_stack}}`: "Python 3.11, PyTorch 2.2, Ray 2.9, S3, CUDA 12.1"
- `{{known_issues}}`: "CUDA out of memory during training, Ray worker crashes on large datasets, S3 read timeouts, model checkpoint corruption"
- `{{target_audience}}`: "ops team"


### Issue: CUDA Out of Memory During Training

- **Symptom**: Training job terminates mid-epoch. GPU utilization drops to 0% and the process exits.
- **Error Message**: `torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 2.50 GiB (GPU 0; 23.69 GiB total capacity; 20.12 GiB already allocated)`
- **Root Cause**: The batch size or model size exceeds available GPU VRAM. This often occurs after a model architecture change or when running on a smaller GPU instance than the one used during development.
- **Diagnostic Steps**:
  1. Check current GPU memory usage: `nvidia-smi`
  2. Log peak memory allocation during a single forward pass: add `print(torch.cuda.max_memory_allocated())` after the first batch.
  3. Compare the GPU instance type in the job config against the minimum VRAM requirement in `configs/training.yaml`.
- **Resolution**:
  1. Reduce `batch_size` in `configs/training.yaml` by 50% and relaunch the job.
  2. Enable gradient checkpointing: set `model.gradient_checkpointing_enable()` before the training loop.
  3. If VRAM is consistently insufficient, upgrade the instance type to one with more VRAM (e.g., A100 80 GB instead of A10G 24 GB).
- **Prevention**: Add a pre-flight VRAM check script that estimates memory requirements based on model size and batch size before launching a job. Set a CloudWatch alarm on GPU memory utilization > 90%.

---


### Issue: S3 Read Timeouts During Data Loading

- **Symptom**: Training jobs stall during the data loading phase. Workers appear idle but the job does not fail immediately.
- **Error Message**: `botocore.exceptions.ReadTimeoutError: Read timeout on endpoint URL`
- **Root Cause**: High-throughput parallel data loading from S3 exceeds the default boto3 read timeout, especially when loading many small files concurrently across Ray workers.
- **Diagnostic Steps**:
  1. Check Ray dashboard for worker status and task queue depth.
  2. Inspect S3 request metrics in the AWS Console for throttling (HTTP 503 errors).
  3. Run a single-worker data load test: `python scripts/test_s3_loader.py --workers=1`
- **Resolution**:
  1. Increase the boto3 read timeout in the data loader config: set `read_timeout=120` in the `Config` object passed to the S3 client.
  2. Reduce the number of concurrent S3 readers by lowering `num_workers` in the Ray dataset config.
  3. If using many small files, pre-aggregate them into larger shards (target 128–512 MB per file) using `scripts/reshard_dataset.py`.
- **Prevention**: Use S3 Transfer Acceleration for cross-region jobs. Add retry logic with exponential backoff to the data loader. Monitor S3 request error rates with a CloudWatch metric filter.
```
