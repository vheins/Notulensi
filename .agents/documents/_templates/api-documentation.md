# API: [Feature]

## Navigation
- [Overview](../../modules/[module-slug]/overview.md)
- [Docs](../../modules/[module-slug]/[feature-slug].md)
- [Tests](../../testing/[module-slug]/test-[feature-slug].md)

## Global Standards
- **Base:** `/api/v1`
- **Auth:** Bearer token
- **Date:** ISO 8601

## Endpoints

### [Name]
- **Route:** `[METHOD] /[path]`
- **Auth:** [Public/Role]

#### Request
**Headers:**
```http
Content-Type: application/json
```
**Params:**
| Name | Type | Req | Desc |
|------|------|-----|------|
| `id` | uuid | yes | ID |

**Body:**
```json
{ "field": "val" }
```

#### Response
**200 OK:**
```json
{ "data": { "id": "uuid" } }
```
**Error:**
```json
{ "error": { "code": "ERR", "message": "msg" } }
```

## Error Codes
| Status | Code | Desc |
|--------|------|------|
| 400 | `VALIDATION_ERROR` | Invalid body |
| 401 | `UNAUTHORIZED` | No token |
| 403 | `FORBIDDEN` | No perm |
| 404 | `NOT_FOUND` | Missing |
| 422 | `UNPROCESSABLE` | Rule violation |
