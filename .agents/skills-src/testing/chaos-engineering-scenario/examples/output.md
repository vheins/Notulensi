# Example Output: chaos-engineering-scenario

## Example 1: E-commerce order service

**Steady State Baseline**
- Error rate: <0.1% | P95: <300ms | Successful orders: >50/min
- Verify with: `kubectl top pods -n production`

---

**Experiment 1: Payment service unavailable**

Hypothesis: When payment-service is down, order-service returns a graceful 503 (not 500), queues the order for retry, and no data is lost.

```bash
# Inject: scale payment-service to 0 replicas
kubectl scale deployment payment-service --replicas=0 -n production
# Duration: 5 minutes
# Restore: kubectl scale deployment payment-service --replicas=3 -n production
```

Expected: order-service returns `{ "error": "Payment service unavailable, order queued" }` with 503. Queue depth increases. No orders lost. Auto-retry processes queue within 60s of restore.

Abort if: error rate >5% OR any orders show corrupted state in DB.

---

**Experiment 2: Inventory service latency injection (Istio)**

Hypothesis: When inventory-service has 2s latency, order-service times out gracefully within 1s and returns 504, not hanging indefinitely.

```yaml
# Istio VirtualService fault injection
fault:
  delay:
    percentage: { value: 100 }
    fixedDelay: 2s
```

Expected: order-service timeout fires at 1s, returns 504. Circuit breaker opens after 5 consecutive failures. P95 stays below 1.5s (timeout + overhead).

---

**Experiment 3: Redis unavailable**

Hypothesis: When Redis is down, session validation falls back to JWT verification and orders still process (degraded but functional).

```bash
kubectl scale deployment redis --replicas=0 -n production
```

Expected: Login still works (JWT fallback), orders process, error rate <1%. No 500s from session lookup failures.
