# Example Input: rate-limiting

### Example 1: Node.js + Express + Redis
**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + Express + Redis (ioredis)
- `{{endpoint_description}}`: "Public API: general endpoints (100 req/min), auth endpoints (10 req/min), upload endpoints (5 req/min)"
- `{{rate_limit_requirements}}`: "Sliding window counter. Limit by IP for unauthenticated, by user ID for authenticated. Bypass for internal service header X-Internal-Secret."


### Example 2: Python + FastAPI + Redis
**Input:**
- `{{tech_stack}}`: Python + FastAPI + Redis (redis-py async)
- `{{endpoint_description}}`: "Public REST API: 60 req/min per IP. Authenticated users: 300 req/min per user ID."
- `{{rate_limit_requirements}}`: "Token bucket algorithm. Bypass for API keys with 'premium' tier. Return 429 with Retry-After."
