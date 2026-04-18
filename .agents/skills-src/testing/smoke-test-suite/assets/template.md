# Smoke Test Suite Specification Template

> Fill in all fields before activating the `smoke-test-suite` skill.

---

## Application Info

**App Name:** `{{app-name}}`

**Base URL:** `{{e.g. https://staging.example.com}}`

**Tech Stack:** {{e.g. Node.js + Express + PostgreSQL}}

---

## Critical Paths (must pass for deployment to proceed)

| # | Path | Method | Expected |
|---|------|--------|----------|
| 1 | `/health` | GET | 200 OK, `{ "status": "ok" }` |
| 2 | `/api/v1/auth/login` | POST | 200 with JWT token |
| 3 | `/api/v1/{{core-resource}}` | GET | 200 with data |
| 4 | `{{critical endpoint}}` | {{method}} | {{expected}} |

---

## Smoke Test Scenarios

| Scenario | Steps | Pass Criteria |
|----------|-------|---------------|
| Service is up | GET /health | 200, response < 500ms |
| Auth works | POST /auth/login with valid creds | 200 + token returned |
| DB connected | GET /{{resource}} (requires DB) | 200, not 500 |
| {{core feature}} | {{steps}} | {{criteria}} |

---

## Test Data

**Test credentials:**
```
email: smoke-test@example.com
password: SmokeTest123!
```

**Pre-conditions:** {{e.g. test user must exist in DB, seed data required}}

---

## Execution

**When to run:** {{e.g. after every deployment, before promoting to production}}

**Tool:** {{e.g. curl, Postman collection, k6, Playwright, custom script}}

**Run command:** `{{e.g. npm run test:smoke, bash scripts/smoke-test.sh}}`

**Max duration:** {{e.g. < 2 minutes}}

**On failure:** {{e.g. block deployment, alert #deployments Slack channel}}
