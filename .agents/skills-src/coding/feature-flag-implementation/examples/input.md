# Example Input: feature-flag-implementation

### Example 1: TypeScript + Node.js + Redis
**Input:**
- `{{tech_stack}}`: TypeScript + Node.js + Express + Redis
- `{{feature_description}}`: "New checkout flow. Roll out to 10% of users initially, then 50%, then 100% over 2 weeks. Specific beta users should always see it."
- `{{flag_requirements}}`: "Percentage rollout + user allowlist. Redis storage. Evaluate per request with user context. Default: false (old checkout)."


### Example 2: Python + FastAPI + PostgreSQL
**Input:**
- `{{tech_stack}}`: Python + FastAPI + SQLAlchemy + PostgreSQL
- `{{feature_description}}`: "AI-powered product recommendations. Enable for premium users only initially, then all users."
- `{{flag_requirements}}`: "User attribute targeting (subscription_tier = 'premium'). PostgreSQL storage. Evaluate at request time."
