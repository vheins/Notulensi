# Example Input: chaos-engineering-scenario

## Example 1: E-commerce order service

| Variable | Value |
|----------|-------|
| `{{system_description}}` | Microservices: order-service → payment-service (sync HTTP) + inventory-service (sync HTTP) + notification-service (async queue). All on Kubernetes. PostgreSQL for orders, Redis for sessions. |
| `{{tech_stack}}` | Node.js + Kubernetes + Istio + Prometheus |
| `{{steady_state}}` | Error rate <0.1%, P95 <300ms, >50 successful orders/min |
