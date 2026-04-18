# API Specification: {{feature_name}}

> All endpoints follow the **JSON:API** standard (https://jsonapi.org).

---

## 1. Global Standards

- **Base URL:** `/api/v1`
- **Content-Type:** `application/vnd.api+json`
- **Date Format:** ISO 8601 (`YYYY-MM-DDTHH:mm:ssZ`)
- **Auth:** Bearer JWT (header: `Authorization: Bearer <token>`)

---

## 2. Endpoints

### 2.1 {{endpoint_name}}

- **URL:** `{{METHOD}} /{{resource-name}}`
- **Description:** {{description}}
- **Access:** {{Public | Authenticated | Role: Admin}}

#### Request

```http
{{METHOD}} /api/v1/{{resource-name}}
Content-Type: application/vnd.api+json
Authorization: Bearer {{token}}
```

**Body:**
```json
{
  "data": {
    "type": "{{resource_type}}",
    "attributes": {
      "{{field_1}}": "{{value_1}}",
      "{{field_2}}": {{value_2}}
    }
  }
}
```

#### Response

**Success ({{2xx}}):**
```json
{
  "data": {
    "type": "{{resource_type}}",
    "id": "{{uuid}}",
    "attributes": {
      "{{field_1}}": "{{value_1}}",
      "{{field_2}}": {{value_2}},
      "created_at": "{{timestamp}}"
    },
    "links": {
      "self": "/api/v1/{{resource-name}}/{{uuid}}"
    }
  }
}
```

**Error (4xx/5xx):**
```json
{
  "errors": [
    {
      "status": "{{status_code}}",
      "source": { "pointer": "/data/attributes/{{field}}" },
      "title": "{{error_title}}",
      "detail": "{{error_detail}}"
    }
  ]
}
```

---

### 2.2 {{endpoint_name_2}}

- **URL:** `{{METHOD}} /{{resource-name}}/{{id}}`
- **Description:** {{description}}
- **Access:** {{access_level}}

---

## 3. Error Codes Reference

| Status | Meaning | When |
|--------|---------|------|
| 400 | Bad Request | Invalid input format |
| 401 | Unauthorized | Missing or invalid token |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 422 | Unprocessable | Business rule violation |
| 500 | Server Error | Unexpected error |
