# Security / Penetration Test Case Template

> Fill in all fields before activating the `security-penetration-test-case-writing` skill.

---

## Target

**Application:** `{{app-name}}`

**Scope:** {{e.g. REST API only, web frontend + API, specific endpoints}}

**Base URL:** `{{e.g. https://staging.example.com/api/v1}}`

**Tech Stack:** {{e.g. Node.js + Express + PostgreSQL, Python + FastAPI}}

---

## Authentication

**Auth Type:** {{JWT Bearer / API Key / Session Cookie / OAuth2}}

**Test accounts:**
| Role | Credentials |
|------|-------------|
| Admin | `{{email}} / {{password}}` |
| Regular user | `{{email}} / {{password}}` |
| Unauthenticated | — |

---

## Endpoints in Scope

| Method | Path | Auth Required | Sensitivity |
|--------|------|---------------|-------------|
| `POST` | `/auth/login` | no | high |
| `GET` | `/users/:id` | yes | high |
| `POST` | `/{{resource}}` | yes | medium |
| `DELETE` | `/{{resource}}/:id` | yes (admin) | high |

---

## Test Categories

| Category | Test Cases |
|----------|------------|
| **Injection** | SQL injection, NoSQL injection, command injection in inputs |
| **Broken Auth** | Brute force login, weak JWT secret, token not invalidated on logout |
| **IDOR** | Access other user's resources by changing ID in URL/body |
| **BOLA/BFLA** | Horizontal privilege escalation, vertical privilege escalation |
| **Input Validation** | XSS in string fields, oversized payloads, negative numbers |
| **Rate Limiting** | No rate limit on login, password reset, OTP endpoints |
| **Sensitive Data** | Passwords in logs, tokens in URLs, PII in error messages |
| **CORS** | Misconfigured CORS allowing arbitrary origins |
| **Security Headers** | Missing CSP, X-Frame-Options, HSTS |

---

## Out of Scope

- {{e.g. DoS/DDoS attacks}}
- {{e.g. social engineering}}
- {{e.g. production environment}}
