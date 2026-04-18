# API Specification: Notification

## Navigation
- [Overview](../../modules/notification/overview.md) | [Feature](../../modules/notification/notification-system.md) | [Testing](../../testing/notification/test-notification.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>`

## 2. Endpoints

### 2.1 Send
- `POST /notifications/send`
- **Access:** Service / Admin
- **Request:**
```json
{
  "user_id": "uuid-user",
  "template_code": "OTP_EMAIL",
  "channel": "email",
  "payload": { "code": "123456", "name": "Jane" }
}
```
- **202 Accepted:**
```json
{
  "data": {
    "job_id": "job-uuid-1234",
    "status": "queued"
  }
}
```

### 2.2 List
- `GET /notifications`
- **Filters:** `status` (unread)
- **Pagination:** `page` (int), `per_page` (int)
- **200 OK:**
```json
{
  "data": [
    {
      "id": "notif-uuid-1",
      "title": "Order Received",
      "body": "Your order #123 is being processed.",
      "is_read": false,
      "created_at": "2024-01-01T09:00:00Z"
    }
  ],
  "meta": { "total": 50, "unread_count": 5 }
}
```

### 2.3 Mark as Read
- `PATCH /notifications/{id}`
- **Access:** Owner
- **Request:** `{ "is_read": true }`
- **200 OK:** *(Returns updated object)*
```json
{
  "data": {
    "id": "notif-uuid-1",
    "title": "Order Received",
    "body": "Your order #123 is being processed.",
    "is_read": true,
    "created_at": "2024-01-01T09:00:00Z"
  }
}
```
*(Note: Example expanded to show returned object for consistency)*
