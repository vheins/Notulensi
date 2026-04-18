# Rate Limiting Specification Template

> Fill in all fields before activating the `rate-limiting` skill.

---

## Application Context

**Tech Stack:** {{e.g. Node.js + Express, Python + FastAPI, Go + Gin}}

**Infrastructure:** {{e.g. single server, multiple instances behind load balancer}}

---

## Rate Limit Rules

| Endpoint / Scope | Limit | Window | Key By | Action on Exceed |
|-----------------|-------|--------|--------|-----------------|
| `POST /auth/login` | {{e.g. 5}} | {{e.g. 15 min}} | {{IP}} | {{429 + lockout}} |
| `POST /api/{{resource}}` | {{e.g. 100}} | {{e.g. 1 min}} | {{userId}} | {{429}} |
| Global (all endpoints) | {{e.g. 1000}} | {{e.g. 1 min}} | {{IP}} | {{429}} |
| `{{endpoint}}` | {{limit}} | {{window}} | {{key}} | {{action}} |

---

## Rate Limit Storage

**Backend:** {{Redis / in-memory (single instance only) / database}}

**Redis connection:** {{e.g. REDIS_URL env var, already configured}}

---

## Response on Limit Exceeded

**HTTP Status:** `429 Too Many Requests`

**Headers to include:**
```
Retry-After: {{seconds}}
X-RateLimit-Limit: {{limit}}
X-RateLimit-Remaining: {{remaining}}
X-RateLimit-Reset: {{unix timestamp}}
```

**Response body:**
```json
{
  "error": "Too many requests",
  "retryAfter": {{seconds}}
}
```

---

## Exemptions

| Who | Exemption |
|-----|-----------|
| {{e.g. internal service IPs}} | {{e.g. bypass all limits}} |
| {{e.g. admin users}} | {{e.g. 10x higher limit}} |
| {{e.g. health check endpoint}} | {{e.g. no limit}} |
