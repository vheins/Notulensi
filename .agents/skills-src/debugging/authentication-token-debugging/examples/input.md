# Example Input: authentication-token-debugging

### Example 1: Node.js + jsonwebtoken + Express — JWT Expiry + Refresh
**Input:**
- `{{tech_stack}}`: Node.js + Express + jsonwebtoken
- `{{token_type}}`: JWT access token
- `{{error_message}}`: `JsonWebTokenError: TokenExpiredError: jwt expired`
- `{{token_payload}}`: `{ "sub": "user123", "iat": 1700000000, "exp": 1700003600 }` (expired 1 hour ago)


### Example 2: Python + FastAPI + OAuth2 — Invalid Grant
**Input:**
- `{{tech_stack}}`: Python + FastAPI + python-jose + OAuth2
- `{{token_type}}`: OAuth2 authorization code
- `{{error_message}}`: `invalid_grant: Authorization code has already been used`
- `{{token_payload}}`: Not applicable — error occurs during token exchange
