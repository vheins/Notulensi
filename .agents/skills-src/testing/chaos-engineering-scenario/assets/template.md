# Chaos Engineering Scenario Template

> Fill in all fields before activating the `chaos-engineering-scenario` skill.

---

## System Under Test

**Service / System:** `{{service-name}}`

**Architecture:** {{e.g. microservices, monolith, serverless}}

**Tech Stack:** {{e.g. Node.js + Kubernetes + PostgreSQL + Redis}}

---

## Hypothesis

> "When {{failure condition}}, the system will {{expected resilient behavior}} and users will experience {{acceptable degradation}}."

**Example:** "When the payment service is unavailable, the checkout flow will queue orders and users will see a 'processing' state instead of an error."

---

## Chaos Experiments

| Experiment | Target | Failure Type | Duration | Expected Behavior |
|------------|--------|-------------|----------|-------------------|
| {{e.g. Kill payment service}} | `payment-service` | {{pod kill / network partition}} | {{e.g. 5 min}} | {{e.g. orders queued, no data loss}} |
| {{e.g. DB latency injection}} | `postgres` | {{latency +500ms}} | {{e.g. 10 min}} | {{e.g. timeouts handled, circuit breaker opens}} |
| {{e.g. Redis unavailable}} | `redis` | {{connection refused}} | {{e.g. 5 min}} | {{e.g. fallback to DB, degraded performance}} |
| {{e.g. CPU stress}} | `api-service` | {{CPU 80%}} | {{e.g. 10 min}} | {{e.g. auto-scaling triggers}} |

---

## Steady State Definition

**System is healthy when:**
| Metric | Threshold |
|--------|-----------|
| Error rate | < {{e.g. 0.1%}} |
| P95 latency | < {{e.g. 500ms}} |
| Successful transactions/min | > {{e.g. 100}} |

---

## Blast Radius Control

**Environment:** {{staging only / production with safeguards}}

**Traffic affected:** {{e.g. 5% of users, internal only}}

**Kill switch:** {{how to stop the experiment immediately}}

**Rollback plan:** {{e.g. restart pods, restore from snapshot}}

---

## Tools

**Chaos tool:** {{e.g. Chaos Monkey, Litmus, Gremlin, Chaos Toolkit, manual}}

**Monitoring:** {{e.g. Datadog, Prometheus, CloudWatch}}
