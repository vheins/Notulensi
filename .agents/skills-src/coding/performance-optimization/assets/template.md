# Performance Optimization Specification Template

> Fill in all fields before activating the `performance-optimization` skill.

---

## Performance Problem

**Symptom:** {{e.g. "API response time P95 > 3s", "page load > 5s", "CPU spikes to 100% under load"}}

**Affected endpoint / component:** `{{e.g. GET /api/dashboard, checkout flow}}`

**When it occurs:** {{e.g. always, under load >100 req/s, after 1h uptime}}

---

## Current Metrics

| Metric | Current | Target |
|--------|---------|--------|
| P50 response time | {{e.g. 800ms}} | {{e.g. <200ms}} |
| P95 response time | {{e.g. 3.2s}} | {{e.g. <500ms}} |
| Throughput | {{e.g. 50 req/s}} | {{e.g. 500 req/s}} |
| CPU usage | {{e.g. 80%}} | {{e.g. <40%}} |
| Memory usage | {{e.g. 1.2GB}} | {{e.g. <512MB}} |
| DB query time | {{e.g. 1.8s}} | {{e.g. <100ms}} |

---

## Profiling Data

**Profiler used:** {{e.g. clinic.js, py-spy, pprof, none yet}}

**Bottleneck identified:** {{e.g. N+1 queries, missing index, no caching, synchronous blocking call}}

**Flame graph / trace:**
```
{{paste profiling output or describe hotspot}}
```

---

## Tech Stack

**Stack:** {{e.g. Node.js + Express + PostgreSQL + Redis}}

**Current infrastructure:** {{e.g. 2x t3.medium, RDS db.t3.medium}}

---

## Constraints

| Constraint | Detail |
|------------|--------|
| Cannot change DB schema | {{yes/no}} |
| Cannot add new infrastructure | {{yes/no}} |
| Must maintain API contract | {{yes/no}} |
| Budget for infra changes | {{e.g. none, up to $200/mo}} |
