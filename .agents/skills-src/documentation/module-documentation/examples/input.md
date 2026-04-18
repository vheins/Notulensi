# Example Input: module-documentation

## Example 1: Auth middleware module

| Variable | Value |
|----------|-------|
| `{{module_name}}` | `auth-middleware` |
| `{{module_code}}` | Express middleware that verifies JWT Bearer token, attaches `req.user`, throws 401 if missing/invalid/expired. Also exports `requireRole(role)` for role-based access. |
| `{{tech_stack}}` | TypeScript + Node.js + Express + jsonwebtoken |
