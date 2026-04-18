# Canary Deployment Test Plan Template

> Fill in all fields before activating the `canary-deployment-test-plan` skill.

---

## Deployment Info

**Service:** `{{service-name}}`

**Current Version:** `{{e.g. v1.2.3}}`

**Canary Version:** `{{e.g. v1.3.0}}`

**Change Summary:** {{what changed — e.g. new checkout flow, DB schema migration, dependency upgrade}}

---

## Canary Rollout Plan

| Phase | Traffic % | Duration | Success Criteria |
|-------|-----------|----------|-----------------|
| Phase 1 | {{e.g. 5%}} | {{e.g. 30 min}} | {{e.g. error rate <0.1%, p95 <500ms}} |
| Phase 2 | {{e.g. 25%}} | {{e.g. 1 hour}} | {{e.g. same + no alerts fired}} |
| Phase 3 | {{e.g. 50%}} | {{e.g. 2 hours}} | {{e.g. same}} |
| Full rollout | 100% | — | {{e.g. 24h stable}} |

---

## Metrics to Monitor

| Metric | Baseline | Alert Threshold | Rollback Threshold |
|--------|----------|-----------------|-------------------|
| Error rate | {{e.g. 0.05%}} | {{e.g. >0.5%}} | {{e.g. >1%}} |
| P95 latency | {{e.g. 200ms}} | {{e.g. >500ms}} | {{e.g. >1s}} |
| P99 latency | {{e.g. 500ms}} | {{e.g. >1s}} | {{e.g. >2s}} |
| CPU usage | {{e.g. 30%}} | {{e.g. >70%}} | {{e.g. >90%}} |
| {{custom metric}} | {{baseline}} | {{alert}} | {{rollback}} |

---

## Rollback Criteria

**Auto-rollback triggers:**
- Error rate exceeds {{threshold}} for {{duration}}
- P95 latency exceeds {{threshold}} for {{duration}}
- {{custom condition}}

**Manual rollback command:**
```bash
{{e.g. kubectl rollout undo deployment/{{service-name}}}}
```

---

## Test Scenarios During Canary

| Scenario | Method | Expected Result |
|----------|--------|-----------------|
| {{e.g. Happy path checkout}} | {{synthetic monitor}} | {{200 OK, <300ms}} |
| {{e.g. Payment failure handling}} | {{manual test}} | {{graceful error}} |
| {{e.g. DB migration compatibility}} | {{automated}} | {{no errors}} |

---

## Infrastructure

**Deployment platform:** {{e.g. Kubernetes, AWS ECS, Heroku}}

**Traffic splitting:** {{e.g. Istio, ALB weighted target groups, feature flag}}

**Monitoring:** {{e.g. Datadog, Prometheus + Grafana, CloudWatch}}
