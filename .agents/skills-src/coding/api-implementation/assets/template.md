# API Endpoint Specification Template

> Fill in all fields before activating the `api-implementation` skill.

---

## Endpoint Spec

**Method + Path:** `{{METHOD}} /{{path}}`

**Description:** {{what this endpoint does}}

### Request

**Headers:**
```
Authorization: Bearer {{token}}   # if auth required
Content-Type: application/json
```

**Path Params:**
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `{{param}}` | string | yes | {{description}} |

**Query Params:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| `{{param}}` | string | — | {{description}} |

**Body:**
```json
{
  "{{field}}": "{{type — e.g. string, required}}",
  "{{field}}": "{{type}}"
}
```

### Response

**Success `{{2xx}}`:**
```json
{
  "{{field}}": "{{value}}"
}
```

**Error Cases:**
| Status | Condition |
|--------|-----------|
| 400 | Validation failure |
| 401 | Missing/invalid token |
| 404 | Resource not found |
| 409 | Conflict (duplicate, state violation) |
| 422 | Business rule violation |

### Business Rules
- {{rule 1}}
- {{rule 2}}

---

## Project Context

**Tech Stack:** {{e.g. Node.js + Express + Zod + Prisma}}

**Auth Middleware:** {{e.g. req.user set by jwtMiddleware}}

**Error Format:** `{ "error": "string", "details"?: object }`

**Relevant Models:**
```
{{ModelName}}: { {{field}}: {{type}}, ... }
```

**Conventions:** {{e.g. thin controllers, service layer, repository pattern}}
