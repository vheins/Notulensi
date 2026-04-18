# API Specification: Configuration

## Navigation
- [Overview](../../modules/configuration/overview.md) | [Feature](../../modules/configuration/system-config.md) | [Testing](../../testing/configuration/test-configuration.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>`

## 2. Endpoints

### 2.1 List All (Admin)
- `GET /configurations`
- **Access:** Admin
- **Filters:** `filter[group]` (string), `filter[key]` (string)
- **200 OK:**
```json
{
  "data": [
    {
      "id": "cfg-uuid-1",
      "key": "MAINTENANCE_MODE",
      "value": "false",
      "data_type": "boolean",
      "is_public": true,
      "group": "SYSTEM"
    }
  ]
}
```

### 2.2 List Public
- `GET /configurations/public`
- **Access:** Public
- **200 OK:**
```json
{
  "data": [
    {
      "key": "CONTACT_PHONE",
      "value": "+1-800-000-0000",
      "data_type": "string"
    }
  ]
}
```

### 2.3 Update
- `PATCH /configurations/{id}`
- **Access:** Admin
- **Request:**
```json
{ "value": "true" }
```
- **200 OK:** *(Returns updated object)*
```json
{
  "data": {
    "id": "cfg-uuid-1",
    "key": "MAINTENANCE_MODE",
    "value": "true",
    "data_type": "boolean",
    "is_public": true,
    "group": "SYSTEM"
  }
}
```
*(Note: Example expanded to show returned object for consistency)*
