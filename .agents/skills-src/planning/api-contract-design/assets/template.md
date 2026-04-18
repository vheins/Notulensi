# Template: api-contract-design

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## API Contract: {{resource_name}}

**API Type:** {{api_type}}

**Backend Stack:** {{tech_stack}}

---

### 1. Endpoint Definitions

```
{{method_1}}   {{path_1}}   — {{description_1}}
{{method_2}}   {{path_2}}   — {{description_2}}
{{method_3}}   {{path_3}}   — {{description_3}}
```

### 2. Request/Response Examples

```
{{method}} {{path}}
Request:  { {{request_body}} }
Response {{success_status}}: { {{success_body}} }
Response {{error_status}}: { "error": "{{error_code}}", "message": "{{error_message}}" }
```

### 3. Error Codes

| Error Code | HTTP Status | Message | When It Occurs |
|------------|-------------|---------|----------------|
| {{error_code_1}} | {{http_status_1}} | {{message_1}} | {{when_1}} |
| {{error_code_2}} | {{http_status_2}} | {{message_2}} | {{when_2}} |

### 4. Authentication

- Method: {{auth_method}}
- Public endpoints: {{public_endpoints}}
- Authenticated endpoints: {{authenticated_endpoints}}
- Token placement: {{token_placement}}

### 5. Rate Limiting

- Global limit: {{global_limit}} requests/minute per {{scope}}
- Headers: {{rate_limit_headers}}
- Exceeded behavior: {{exceeded_behavior}}
