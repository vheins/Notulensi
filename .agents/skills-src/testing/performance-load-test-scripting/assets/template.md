# Performance / Load Test Specification Template

> Fill in all fields before activating the `performance-load-test-scripting` skill.

---

## Target

**Endpoint / Flow:** `{{e.g. POST /api/checkout, full user registration flow}}`

**Base URL:** `{{e.g. https://staging.example.com}}`

**Tech Stack:** {{e.g. Node.js + Express + PostgreSQL}}

---

## Load Profile

| Phase | Duration | Virtual Users | Ramp |
|-------|----------|---------------|------|
| Warm-up | {{e.g. 1 min}} | {{e.g. 10}} | linear |
| Steady state | {{e.g. 10 min}} | {{e.g. 100}} | constant |
| Peak | {{e.g. 5 min}} | {{e.g. 500}} | spike |
| Cool-down | {{e.g. 2 min}} | {{e.g. 10}} | linear |

---

## Performance Targets (SLOs)

| Metric | Target |
|--------|--------|
| P50 response time | < {{e.g. 200ms}} |
| P95 response time | < {{e.g. 500ms}} |
| P99 response time | < {{e.g. 1s}} |
| Error rate | < {{e.g. 0.1%}} |
| Throughput | ≥ {{e.g. 200 req/s}} |

---

## Test Scenarios

| Scenario | Weight | Description |
|----------|--------|-------------|
| {{e.g. Browse products}} | {{e.g. 60%}} | {{GET /products, GET /products/:id}} |
| {{e.g. Add to cart}} | {{e.g. 25%}} | {{POST /cart/items}} |
| {{e.g. Checkout}} | {{e.g. 15%}} | {{POST /checkout}} |

---

## Test Data

**Auth:** {{e.g. pre-generated JWT tokens for 1000 test users}}

**Seed data:** {{e.g. 10k products, 1k test users}}

**Data variation:** {{e.g. randomize userId, productId per request}}

---

## Tool

**Load test tool:** {{k6 / Locust / JMeter / Artillery / Gatling}}

**Run command:** `{{e.g. k6 run scripts/load-test.js}}`

**Results output:** {{e.g. k6 Cloud, InfluxDB + Grafana, HTML report}}
