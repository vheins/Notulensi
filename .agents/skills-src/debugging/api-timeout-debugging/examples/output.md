# Example Output: api-timeout-debugging

**Expected Output Shape:**
```
1. Timeout Classification
Client-side timeout — Axios has no timeout configured, so it waits indefinitely. Express's default 30s timeout kills the request.

2. Slow Component Identification
External payment API: 30s (100% of request time). DB query: 45ms (negligible).

3. Root Cause Analysis
The payment API is slow during maintenance windows. Axios has no timeout, so it waits for the full 30s before Express kills the connection. No retry or circuit breaker means every affected request fails completely.

4. Fix
Before:
  const result = await axios.post('https://payment-api.example.com/charge', payload);

After (timeout + retry + circuit breaker):
  const axiosInstance = axios.create({ timeout: 5000 });  // 5s timeout

  // Retry with exponential backoff (using axios-retry):
  axiosRetry(axiosInstance, {
    retries: 3,
    retryDelay: axiosRetry.exponentialDelay,
    retryCondition: (err) => err.code === 'ECONNABORTED' || err.response?.status >= 500,
  });

  // Circuit breaker (using opossum):
  const breaker = new CircuitBreaker(chargePayment, { timeout: 5000, errorThresholdPercentage: 50 });
  const result = await breaker.fire(payload);

5. Monitoring
Alert: payment API p99 > 3s for 2 consecutive minutes
Alert: checkout timeout rate > 2%
Dashboard: payment API latency histogram, circuit breaker state (open/closed/half-open)
```


**Expected Output Shape:**
```
1. Timeout Classification
Downstream timeout — inventory-service is overloaded (scaled down from 10 to 2 replicas). httpx has no timeout, waits until FastAPI's 10s limit kills the request.

2. Slow Component Identification
inventory-service: 10s (100% of request time). recommendation-engine: 200ms (negligible).

3. Root Cause Analysis
inventory-service is under-provisioned (2 replicas handling load previously served by 10). Requests queue up, causing timeouts. No timeout on httpx means the caller waits indefinitely.

4. Fix
Before:
  async with httpx.AsyncClient() as client:
    response = await client.get('http://inventory-service/stock')

After (timeout + fallback):
  async with httpx.AsyncClient(timeout=httpx.Timeout(2.0)) as client:
    try:
      response = await client.get('http://inventory-service/stock')
      stock_data = response.json()
    except httpx.TimeoutException:
      # Graceful degradation: return recommendations without stock filter
      stock_data = None  # or use cached data

  # Scale inventory-service back to 10 replicas:
  kubectl scale deployment inventory-service --replicas=10

5. Monitoring
Alert: inventory-service p99 > 1s
Alert: recommendations timeout rate > 0.5%
Add: httpx timeout metrics via OpenTelemetry instrumentation
```
