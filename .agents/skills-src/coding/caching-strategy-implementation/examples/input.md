# Example Input: caching-strategy-implementation

### Example 1: Node.js + Redis — User Profile Cache

**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + Redis (ioredis) + PostgreSQL
- `{{data_description}}`: "User profile data (name, email, preferences, subscription tier). Read on every API request. Written rarely (user updates profile ~once/week). 100k active users."
- `{{cache_requirements}}`: "TTL: 1 hour. Invalidate on profile update. Cache stampede protection for popular users. Graceful degradation if Redis is down."

---

### Example 2: Python + Redis — API Response Cache

**Input:**
- `{{tech_stack}}`: Python + FastAPI + Redis (redis-py) + external REST API
- `{{data_description}}`: "Exchange rate data from external API. Fetched on every price calculation. External API has rate limits (100 req/min). Data changes every 5 minutes."
- `{{cache_requirements}}`: "TTL: 5 minutes. No invalidation needed (TTL-based expiry sufficient). Stale-while-revalidate to avoid latency spikes on TTL expiry."
