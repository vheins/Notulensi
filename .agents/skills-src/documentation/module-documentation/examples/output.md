# Example Output: module-documentation

## Example 1: Auth middleware module

# `auth-middleware`

Express middleware for JWT authentication and role-based authorization.

## Overview

Verifies Bearer JWT tokens on incoming requests, attaches the decoded user payload to `req.user`, and rejects unauthenticated or unauthorized requests with appropriate HTTP errors.

## Installation

```bash
# Already part of the project — no separate install needed
import { authenticate, requireRole } from '@/middleware/auth';
```

## API

### `authenticate`

Middleware that verifies the `Authorization: Bearer <token>` header.

**Attaches to request:** `req.user: { id: string, email: string, role: string }`

**Throws:**
- `401 Unauthorized` — missing token, invalid signature, or expired token
- `401 Unauthorized` — token payload missing required fields

```typescript
// Usage
router.get('/profile', authenticate, (req, res) => {
  res.json(req.user); // { id, email, role }
});
```

---

### `requireRole(role: string)`

Factory that returns middleware enforcing a minimum role. Must be used **after** `authenticate`.

**Throws:**
- `403 Forbidden` — authenticated user does not have the required role

```typescript
// Usage
router.delete('/admin/users/:id',
  authenticate,
  requireRole('admin'),
  AdminController.deleteUser
);
```

## Error Responses

| Status | Condition | Body |
|--------|-----------|------|
| 401 | Missing or malformed token | `{ "error": "Authentication required" }` |
| 401 | Expired token | `{ "error": "Token expired" }` |
| 401 | Invalid signature | `{ "error": "Invalid token" }` |
| 403 | Insufficient role | `{ "error": "Forbidden" }` |

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `JWT_SECRET` | yes | Secret used to verify token signatures |

## Testing

```typescript
import { generateToken } from '@/tests/helpers/auth';

// Generate test token
const token = generateToken({ id: 'u1', email: 'test@example.com', role: 'user' });
```
