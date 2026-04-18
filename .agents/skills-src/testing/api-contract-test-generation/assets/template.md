# API Contract Test Specification Template

> Fill in all fields before activating the `api-contract-test-generation` skill.

---

## API Info

**API Name:** `{{e.g. Orders API, User Service}}`

**Base URL:** `{{e.g. http://localhost:3000/api/v1}}`

**Tech Stack:** {{e.g. Node.js + Express, Python + FastAPI}}

**Contract Format:** {{OpenAPI 3.x / Pact / manual}}

---

## Endpoints to Test

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/{{resource}}` | List {{resource}} |
| `GET` | `/{{resource}}/:id` | Get single {{resource}} |
| `POST` | `/{{resource}}` | Create {{resource}} |
| `PUT` | `/{{resource}}/:id` | Update {{resource}} |
| `DELETE` | `/{{resource}}/:id` | Delete {{resource}} |

---

## Contract Rules per Endpoint

### `POST /{{resource}}`

**Request contract:**
```json
{
  "{{field}}": "string (required)",
  "{{field}}": "number (required, min: 1)"
}
```

**Response contract (201):**
```json
{
  "id": "uuid",
  "{{field}}": "string",
  "createdAt": "ISO 8601 string"
}
```

**Error contracts:**
| Status | Body Shape |
|--------|------------|
| 400 | `{ "error": "string", "details": object }` |
| 404 | `{ "error": "string" }` |

---

## Test Framework

**Framework:** {{e.g. Jest + supertest, pytest + httpx, Pact}}

**Test DB:** {{e.g. in-memory SQLite, test PostgreSQL, mocked}}

**Auth in tests:** {{e.g. generate test JWT, mock auth middleware}}
