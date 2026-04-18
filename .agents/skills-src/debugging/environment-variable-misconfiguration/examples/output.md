# Example Output: environment-variable-misconfiguration

**Expected Output Shape:**
```
1. Misconfiguration Identification
Missing required variable — DATABASE_URL is commented out in .env (line starts with #). dotenv skips commented lines.

2. Diagnostic Checklist
✅ Variable name is correct (DATABASE_URL)
❌ Variable is commented out in .env
✅ dotenv is loaded before database connection
✅ .env file exists in project root

3. Fix
.env before:
  # DATABASE_URL=postgres://...  ← commented out

.env after:
  DATABASE_URL=postgres://localhost:5432/myapp_dev

Code: add startup validation in app.js:
  require('dotenv').config();
  const required = ['DATABASE_URL', 'JWT_SECRET', 'PORT'];
  const missing = required.filter(k => !process.env[k]);
  if (missing.length) { console.error('Missing env vars:', missing); process.exit(1); }

4. Startup Validation
The startup validation above will print a clear error and exit immediately if any required variable is missing, preventing cryptic downstream errors.

5. Best Practices
- Add .env.example with: DATABASE_URL=postgres://localhost:5432/yourdb
- Add .env to .gitignore (verify: git check-ignore -v .env)
- Use envalid package for type-safe validation: cleanEnv(process.env, { DATABASE_URL: url() })
```


**Expected Output Shape:**
```
1. Misconfiguration Identification
Deployment gap — REDIS_URL is required by the application (added to pydantic Settings model) but was not added to the Docker Compose environment section. The variable exists in the developer's local .env but is not injected into the container.

2. Diagnostic Checklist
❌ REDIS_URL not in docker-compose.yml environment section
✅ REDIS_URL defined in local .env
✅ Variable name matches Settings model field
✅ pydantic-settings is loading from environment

3. Fix
docker-compose.yml before:
  environment:
    - DATABASE_URL=${DATABASE_URL}
    - SECRET_KEY=${SECRET_KEY}

docker-compose.yml after:
  environment:
    - DATABASE_URL=${DATABASE_URL}
    - SECRET_KEY=${SECRET_KEY}
    - REDIS_URL=${REDIS_URL}  ← added

.env (add):
  REDIS_URL=redis://localhost:6379/0

4. Startup Validation
pydantic-settings already provides validation — the SettingsError is the validation. Ensure all required fields in the Settings class have no default value so they fail fast if missing.

5. Best Practices
- Maintain a .env.example that mirrors all variables in docker-compose.yml
- Add a pre-deploy check script: diff <(grep -E '^[A-Z_]+=' .env.example) <(grep -E '^\s+- [A-Z_]+=' docker-compose.yml)
- Use Docker secrets for production sensitive values instead of environment variables
```
