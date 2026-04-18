# Example Input: configuration-management

### Example 1: Node.js + TypeScript

**Input:**
- `{{tech_stack}}`: Node.js + TypeScript
- `{{config_requirements}}`: "DATABASE_URL (required), REDIS_URL (required), JWT_SECRET (required, secret), PORT (optional, default 3000), LOG_LEVEL (optional, default info), STRIPE_API_KEY (required in prod, optional in dev), FEATURE_NEW_CHECKOUT (boolean flag)"
- `{{environments}}`: "development, staging, production"

---

### Example 2: Python + FastAPI

**Input:**
- `{{tech_stack}}`: Python + FastAPI + Pydantic
- `{{config_requirements}}`: "DATABASE_URL (required), SECRET_KEY (required, secret), ALLOWED_ORIGINS (list, required), SMTP_HOST/PORT/USER/PASS (required), DEBUG (boolean, default false), MAX_UPLOAD_SIZE_MB (int, default 10)"
- `{{environments}}`: "local, staging, production"
