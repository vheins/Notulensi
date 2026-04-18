# Example Input: sla-slo-definition

### Example 1: Node.js + PostgreSQL + Datadog — E-commerce Checkout API
**Input:**
- `{{service_description}}`: "REST API handling the checkout flow: cart validation, payment processing, order creation. Critical path for revenue. Used by 10k DAU."
- `{{tech_stack}}`: "Node.js + Express + PostgreSQL + Stripe + Datadog + PagerDuty"
- `{{business_requirements}}`: "99.9% availability, p95 latency < 500ms, max 0.1% payment errors, 4 hours downtime/year acceptable"


### Example 2: Python + FastAPI + Prometheus + Grafana — Internal Data API
**Input:**
- `{{service_description}}`: "Internal REST API serving analytics data to the frontend dashboard. Used by 500 internal users. Not customer-facing but business-critical for daily reporting."
- `{{tech_stack}}`: "Python + FastAPI + PostgreSQL + Prometheus + Grafana + OpsGenie"
- `{{business_requirements}}`: "99.5% availability during business hours (9am–6pm), p95 < 2 seconds, acceptable to have degraded service outside business hours"
