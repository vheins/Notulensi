# Configuration Management Specification Template

> Fill in all fields before activating the `configuration-management` skill.

---

## Application Info

**App Name:** `{{app-name}}`

**Tech Stack:** {{e.g. Node.js + TypeScript, Python + FastAPI, Go + Gin}}

**Deployment Targets:** {{e.g. local dev, staging (Docker), production (Kubernetes)}}

---

## Configuration Variables

| Variable | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `APP_ENV` | string | yes | `development` | Environment name |
| `PORT` | number | yes | `3000` | HTTP server port |
| `DATABASE_URL` | string | yes | — | DB connection string |
| `LOG_LEVEL` | string | no | `info` | Logging verbosity |
| `{{VAR_NAME}}` | {{type}} | {{yes/no}} | {{default}} | {{description}} |

---

## Secrets (never committed)

| Secret | Source | Description |
|--------|--------|-------------|
| `JWT_SECRET` | env / vault | JWT signing key |
| `{{SECRET}}` | {{env / AWS SSM / Vault / K8s secret}} | {{description}} |

---

## Environment-Specific Overrides

| Variable | development | staging | production |
|----------|-------------|---------|------------|
| `LOG_LEVEL` | `debug` | `info` | `warn` |
| `DATABASE_URL` | `localhost:5432/...` | `staging-db:5432/...` | `prod-db:5432/...` |
| `{{VAR}}` | `{{dev}}` | `{{staging}}` | `{{prod}}` |

---

## Config Loading Approach

**Preferred method:** {{e.g. dotenv + validation (Zod/Joi), OS env only, config file per env}}

**Validation on startup:** {{yes/no — fail fast if required vars missing}}

**Config file format:** {{.env / YAML / TOML / JSON / none}}
