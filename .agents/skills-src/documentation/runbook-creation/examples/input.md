# Example Input: runbook-creation

### Example 1: Node.js Payment API on AWS ECS
**Input:**
- `{{service_name}}`: "payments-api"
- `{{tech_stack}}`: "Node.js 20, Express 4, PostgreSQL 15, Redis 7, SQS"
- `{{deployment_platform}}`: "AWS ECS (Fargate)"
- `{{on_call_team}}`: "Platform Engineering"
- `{{slo_targets}}`: "99.95% uptime, p99 latency < 300ms, error rate < 0.05%"


### Example 2: Redis Cache — Eviction and Memory Pressure Runbook
**Input:**
- `{{service_name}}`: "session-cache"
- `{{tech_stack}}`: Redis 7 + Kubernetes
- `{{runbook_type}}`: "memory pressure and eviction incident response"
