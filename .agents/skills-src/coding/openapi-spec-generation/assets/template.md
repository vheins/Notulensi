# OpenAPI Specification Template

> Fill in all fields before activating the `openapi-spec-generation` skill.

---

## API Overview

**API Title:** `{{API Name}}`

**Version:** `{{e.g. 1.0.0}}`

**Base URL:** `{{e.g. https://api.example.com/v1}}`

**Description:** {{brief description of what this API does}}

---

## Authentication

**Type:** {{Bearer JWT / API Key / OAuth2 / Basic / None}}

**Header:** `{{e.g. Authorization: Bearer <token>}}`

---

## Endpoints

### `{{METHOD}} /{{path}}`

**Summary:** {{one-line description}}

**Tags:** `[{{tag}}]`

**Auth required:** {{yes/no}}

**Path Params:**
| Param | Type | Description |
|-------|------|-------------|
| `{{param}}` | string | {{description}} |

**Query Params:**
| Param | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `{{param}}` | string | no | — | {{description}} |

**Request Body:**
```json
{
  "{{field}}": "{{type — string, required}}",
  "{{field}}": "{{type}}"
}
```

**Responses:**
| Status | Description | Schema |
|--------|-------------|--------|
| 200 | Success | `{{SchemaName}}` |
| 400 | Validation error | `ErrorResponse` |
| 401 | Unauthorized | `ErrorResponse` |
| 404 | Not found | `ErrorResponse` |

---

## Shared Schemas

### `ErrorResponse`
```json
{
  "error": "string",
  "details": "object (optional)"
}
```

### `{{SchemaName}}`
```json
{
  "id": "uuid",
  "{{field}}": "{{type}}"
}
```

---

## Output Format

**Format:** {{YAML / JSON}}

**OpenAPI Version:** {{3.0.x / 3.1.x}}
