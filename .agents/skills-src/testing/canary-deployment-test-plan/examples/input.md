# Example Input: canary-deployment-test-plan

## Example 1: New checkout flow deployment

| Variable | Value |
|----------|-------|
| `{{deployment_description}}` | Deploying v2.1.0 of checkout-service — rewrites payment processing to use async queue instead of synchronous Stripe call. High risk: revenue-critical path. |
| `{{tech_stack}}` | Node.js + Kubernetes + Datadog |
| `{{baseline_metrics}}` | Error rate: 0.05%, P95: 180ms, throughput: 200 req/s |
