# Error Handling Specification Template

> Fill in all fields before activating the `error-handling-patterns` skill.

---

## Application Context

**Tech Stack:** {{e.g. Node.js + Express + TypeScript, Python + FastAPI, Go + Gin}}

**Current Error Handling:** {{describe what exists — e.g. "try/catch in each route, no centralized handler", "errors bubble up unhandled"}}

---

## Error Categories to Handle

| Category | HTTP Status | Example | Current Handling |
|----------|-------------|---------|-----------------|
| Validation error | 400 | Invalid input fields | {{e.g. none / Zod throws}} |
| Authentication | 401 | Missing/expired token | {{e.g. middleware returns 401}} |
| Authorization | 403 | Insufficient permissions | {{e.g. none}} |
| Not found | 404 | Resource doesn't exist | {{e.g. returns 500 accidentally}} |
| Conflict | 409 | Duplicate entry | {{e.g. DB error leaks to client}} |
| Business rule | 422 | Insufficient stock | {{e.g. none}} |
| Rate limit | 429 | Too many requests | {{e.g. none}} |
| Internal error | 500 | Unexpected exception | {{e.g. stack trace exposed}} |

---

## Error Response Format

**Desired format:**
```json
{
  "error": "{{human-readable message}}",
  "code": "{{machine-readable code — e.g. VALIDATION_ERROR}}",
  "details": {}
}
```

**Current format (if any):**
```json
{{paste current error response shape}}
```

---

## Requirements

| Requirement | Include? |
|-------------|----------|
| Centralized error handler / middleware | {{yes/no}} |
| Custom error classes (typed errors) | {{yes/no}} |
| Error logging (with context) | {{yes/no}} |
| Hide internal details from client | {{yes/no}} |
| Validation error field-level details | {{yes/no}} |
| Async error propagation | {{yes/no}} |

---

## Logging

**Logger:** {{e.g. pino, winston, structlog, zerolog, none}}

**Log fields to include:** {{e.g. requestId, userId, path, method, statusCode, duration}}
