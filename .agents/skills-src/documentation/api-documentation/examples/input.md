# Example Input: api-documentation

## Example 1: User authentication endpoint

| Variable | Value |
|----------|-------|
| `{{endpoint_description}}` | Authenticates a user with email and password. Returns a JWT access token (1h expiry) and refresh token (7d expiry) on success. Locks account after 5 failed attempts. |
| `{{tech_stack}}` | TypeScript + Express |
| `{{auth_method}}` | None (this IS the auth endpoint) |
