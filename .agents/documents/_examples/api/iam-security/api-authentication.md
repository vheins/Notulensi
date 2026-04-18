# API Specification: Authentication

## Navigation
- [Overview](../../modules/iam-security/overview.md) | [Feature](../../modules/iam-security/authentication.md) | [Testing](../../testing/iam-security/test-authentication.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>`
- **Date Format:** ISO 8601

## 2. Endpoints

### 2.1 Register
- `POST /auth/register`
- **Access:** Public
- **Request:**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123",
  "full_name": "Jane Doe"
}
```
- **201 Created:**
```json
{
  "data": {
    "id": "uuid-1234",
    "email": "user@example.com",
    "full_name": "Jane Doe",
    "status": "inactive",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### 2.2 Login
- `POST /auth/login`
- **Access:** Public
- **Request:** `{ "email": "user@example.com", "password": "SecurePass123" }`
- **200 OK:**
```json
{
  "data": {
    "access_token": "eyJhbG...",
    "refresh_token": "eyJhbG...",
    "expires_in": 3600,
    "token_type": "Bearer"
  }
}
```

### 2.3 Current User
- `GET /auth/me`
- **Access:** Authenticated
- **200 OK:**
```json
{
  "data": {
    "id": "uuid-me",
    "email": "user@example.com",
    "full_name": "Jane Doe",
    "roles": ["editor"]
  }
}
```

### 2.4 Logout
- `POST /auth/logout`
- **Access:** Authenticated
- **204 No Content**

### 2.5 Activate Account
- `POST /auth/activate`
- **Access:** Public
- **Request:** `{ "token": "activation-token-xyz" }`
- **200 OK:** `{ "message": "Account activated successfully." }`

### 2.6 Forgot Password
- `POST /auth/forgot-password`
- **Access:** Public
- **Request:** `{ "email": "user@example.com" }`
- **202 Accepted:** `{ "message": "If the email exists, a reset link has been sent." }`

### 2.7 Reset Password
- `POST /auth/reset-password`
- **Access:** Public
- **Request:** `{ "token": "reset-token-xyz", "new_password": "NewSecurePass1" }`
- **200 OK:** `{ "message": "Password updated successfully." }`

### 2.8 Change Password
- `POST /auth/change-password`
- **Access:** Authenticated
- **Request:** `{ "current_password": "OldPass123", "new_password": "NewSecurePass1" }`
- **204 No Content**

## 3. Errors
- `400 VALIDATION_ERROR`: Request body failed validation.
- `401 UNAUTHORIZED`: Invalid credentials or missing token.
- `403 FORBIDDEN`: Account inactive or suspended.
- `409 CONFLICT`: Email already registered.
- `422 UNPROCESSABLE`: Business rule violation (e.g., weak password).
