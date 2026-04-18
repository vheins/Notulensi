# Example Input: api-timeout-debugging

### Example 1: Node.js + Axios + Express — External API Timeout
**Input:**
- `{{tech_stack}}`: Node.js + Express + Axios
- `{{timeout_symptoms}}`: POST /api/checkout times out after 30s; affects 5% of requests; started after payment provider announced maintenance windows
- `{{trace_data}}`: Express span: 30s total; Axios call to payment-api.example.com: 30s (timeout); DB query: 45ms
- `{{context}}`: Checkout calls a third-party payment API synchronously; no timeout configured on Axios; no retry logic; no circuit breaker


### Example 2: Python + httpx + FastAPI — Internal Service Timeout
**Input:**
- `{{tech_stack}}`: Python + FastAPI + httpx
- `{{timeout_symptoms}}`: GET /api/recommendations times out after 10s; affects all users; started after inventory-service was scaled down
- `{{trace_data}}`: FastAPI span: 10s total; httpx call to inventory-service: 10s (timeout); recommendation-engine: 200ms
- `{{context}}`: Recommendations endpoint calls inventory-service to check stock; inventory-service has 2 replicas (down from 10); no timeout on httpx client
