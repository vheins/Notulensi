# Example Input: environment-variable-misconfiguration

### Example 1: Node.js + dotenv + Express
**Input:**
- `{{tech_stack}}`: Node.js + Express + dotenv
- `{{error_message}}`: `Error: DATABASE_URL is not defined. Cannot connect to database.`
- `{{env_file}}`: `PORT=3000\nJWT_SECRET=mysecret\n# DATABASE_URL=postgres://...  (commented out)`
- `{{context}}`: Local development; dotenv loaded in app.js; DATABASE_URL was accidentally commented out during a merge conflict


### Example 2: Python + FastAPI + Docker Compose
**Input:**
- `{{tech_stack}}`: Python + FastAPI + Docker Compose
- `{{error_message}}`: `pydantic_settings.SettingsError: REDIS_URL field required`
- `{{env_file}}`: `DATABASE_URL=postgresql://db:5432/app\nSECRET_KEY=abc123`
- `{{context}}`: Docker Compose deployment; REDIS_URL was added to the app but not added to docker-compose.yml environment section
