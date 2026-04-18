# API Specification: Role & Permission Management

## Navigation
- [Overview](../../modules/iam-security/overview.md) | [Feature](../../modules/iam-security/role-permission-management.md) | [Testing](../../testing/iam-security/test-role-permission-management.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>` (Admin)

## 2. Endpoints

### 2.1 List Roles
- `GET /roles`
- **200 OK:**
```json
{
  "data": [
    { "id": "role-uuid-1", "name": "editor", "description": "Can edit content" }
  ]
}
```

### 2.2 Create Role
- `POST /roles`
- **Request:** `{ "name": "editor", "description": "Can edit content" }`
- **201 Created:** *(Returns created object)*

### 2.3 Update Role
- `PATCH /roles/{id}`
- **Request:** `{ "name": "senior-editor", "description": "Lead editor with publish rights" }`
- **200 OK:** *(Returns updated object)*

### 2.4 Delete Role
- `DELETE /roles/{id}`
- **204 No Content**

### 2.5 List Permissions
- `GET /permissions`
- **200 OK:**
```json
{
  "data": [
    { "id": "perm-uuid-1", "code": "articles:create", "description": "Can create articles" }
  ]
}
```

### 2.6 Assign Permissions to Role
- `PUT /roles/{id}/permissions`
- **Request:** `{ "permission_ids": ["perm-uuid-1", "perm-uuid-2"] }`
- **204 No Content**

### 2.7 Assign Roles to User
- `PUT /users/{id}/roles`
- **Request:** `{ "role_ids": ["role-uuid-1"] }`
- **204 No Content**
