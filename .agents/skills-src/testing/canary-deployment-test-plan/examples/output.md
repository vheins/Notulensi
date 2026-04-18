# Example Output: canary-deployment-test-plan

## Example 1: New checkout flow deployment

**Canary Rollout Plan**

| Phase | Traffic | Duration | Auto-rollback Trigger |
|-------|---------|----------|-----------------------|
| Phase 1 | 5% | 30 min | error rate >0.5% OR P95 >500ms |
| Phase 2 | 25% | 1 hour | error rate >0.3% OR P95 >400ms |
| Phase 3 | 50% | 2 hours | error rate >0.2% OR P95 >350ms |
| Full rollout | 100% | — | monitor 24h |

**Key Metrics to Monitor (Datadog)**

| Metric | Baseline | Alert | Rollback |
|--------|----------|-------|----------|
| Error rate | 0.05% | >0.3% | >0.5% |
| P95 latency | 180ms | >350ms | >500ms |
| Payment success rate | 99.95% | <99.5% | <99% |
| Queue depth | 0 | >100 | >500 |
| Queue processing lag | — | >5s | >30s |

**Synthetic Tests During Canary**
- Run checkout smoke test every 2 minutes against canary pods
- Verify: order created → payment queued → status webhook received within 10s
- Alert on any failure

**Rollback Command**
```bash
kubectl rollout undo deployment/checkout-service
# Verify rollback complete:
kubectl rollout status deployment/checkout-service
```

**Go/No-Go Checklist Before Phase 2**
- [ ] Error rate stable at <0.1% for 30 min
- [ ] No payment failures in Stripe dashboard
- [ ] Queue depth at 0 (no backlog)
- [ ] No alerts fired in Datadog
