# Example Output: api-documentation

## Example 1: User authentication endpoint

```yaml
# OpenAPI 3.1 — POST /api/auth/login
/api/auth/login:
  post:
    summary: Authenticate user
    description: |
      Authenticates a user with email and password.
      Returns a JWT access token (1h) and refresh token (7d) on success.
      Accounts are locked for 15 minutes after 5 consecutive failed attempts.
    tags: [Authentication]
    requestBody:
      required: true
      content:
        application/json:
          schema:
            type: object
            required: [email, password]
            properties:
              email:
                type: string
                format: email
                example: user@example.com
              password:
                type: string
                minLength: 8
                example: "SecurePass123!"
    responses:
      "200":
        description: Login successful
        content:
          application/json:
            schema:
              type: object
              properties:
                token:
                  type: string
                  description: JWT access token (expires in 1 hour)
                  example: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                refreshToken:
                  type: string
                  description: Refresh token (expires in 7 days)
                expiresIn:
                  type: integer
                  description: Access token TTL in seconds
                  example: 3600
      "400":
        description: Validation error
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/ValidationError"
      "401":
        description: Invalid credentials
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Error"
            example:
              error: "Invalid credentials"
      "429":
        description: Account locked after too many failed attempts
        headers:
          Retry-After:
            schema:
              type: integer
            description: Seconds until account is unlocked
        content:
          application/json:
            schema:
              type: object
              properties:
                error:
                  type: string
                  example: "Account temporarily locked"
                retryAfter:
                  type: integer
                  example: 900
```
