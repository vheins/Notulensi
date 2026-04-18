# API Specification: User Management

## Navigation
- [Overview](../../modules/iam-security/overview.md) | [Feature](../../modules/iam-security/user-management.md) | [Testing](../../testing/iam-security/test-user-management.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>`

## 2. Endpoints

### 2.1 List
- `GET /users`
- **Access:** Admin
- **Filters:** `status` (active, suspended, inactive), `role` (string)
- **Pagination:** `page` (int), `per_page` (int)
- **200 OK:**
```json
{
  "data": [
    {
      "id": "uuid-1",
      "email": "user@example.com",
      "full_name": "Jane Doe",
      "status": "active",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "meta": { "total": 100, "page": 1, "per_page": 20 }
}
```

### 2.2 Get
- `GET /users/{id}`
- **Access:** Admin / Self
- **200 OK:**
```json
{
  "data": {
    "id": "uuid-1",
    "email": "user@example.com",
    "full_name": "Jane Doe",
    "status": "active"
  }
}
```

### 2.3 Create
- `POST /users`
- **Access:** Admin
- **Request:**
```json
{
  "email": "employee@company.com",
  "full_name": "New Employee",
  "password": "InitialPass123",
  "role_ids": ["role-uuid-1"]
}
```
- **201 Created:**
```json
{
  "data": {
    "id": "uuid-new",
    "email": "employee@company.com",
    "status": "inactive"
  }
}
```

### 2.4 Update
- `PATCH /users/{id}`
- **Access:** Admin / Self
- **Request:** `{ "full_name": "Updated Name", "status": "suspended" }`
- **200 OK:** *(Returns updated user)*

### 2.5 Delete
- `DELETE /users/{id}`
- **Access:** Admin
- **204 No Content**
