# Example Input: network-latency-diagnosis

### Example 1: Node.js + AWS + Datadog APM
**Input:**
- `{{tech_stack}}`: Node.js + Express + AWS ECS + Datadog APM
- `{{latency_symptoms}}`: p99 latency on /api/checkout is 3.2s; SLA is 500ms; issue started after moving to multi-region
- `{{trace_data}}`: Datadog trace shows: DNS 800ms, TCP 12ms, TLS 45ms, app processing 200ms, DB query 2.1s
- `{{context}}`: App servers in us-east-1; DB in us-west-2; no connection pooling configured; recent multi-region expansion


### Example 2: Go + Kubernetes + Jaeger
**Input:**
- `{{tech_stack}}`: Go + Kubernetes + Jaeger distributed tracing
- `{{latency_symptoms}}`: Inter-service calls between order-service and inventory-service average 450ms; direct DB calls are 5ms; issue is service-to-service only
- `{{trace_data}}`: Jaeger shows: order-service span 450ms total; inventory-service processing 8ms; network gap 442ms
- `{{context}}`: Both services in same Kubernetes cluster; different namespaces; NetworkPolicy recently applied
