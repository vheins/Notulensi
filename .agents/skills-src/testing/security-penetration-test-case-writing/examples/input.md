# Example Input: security-penetration-test-case-writing

## Example 1: REST API with JWT auth

| Variable | Value |
|----------|-------|
| `{{target_description}}` | REST API: `/api/users/:id`, `/api/orders`, `/api/admin/*`. JWT Bearer auth. Users can only access their own data. Admins can access all. PostgreSQL backend. |
| `{{tech_stack}}` | Node.js + Express + JWT + PostgreSQL |
| `{{owasp_categories}}` | IDOR, Broken Auth, Injection, Security Misconfiguration |
