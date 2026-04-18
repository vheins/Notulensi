# API Specification: Media Management

## Navigation
- [Overview](../../modules/media-management/overview.md) | [Feature](../../modules/media-management/file-management.md) | [Testing](../../testing/media-management/test-media-management.md)

## 1. Standards
- **Base URL:** `/api/v1/media`
- **Auth:** `Bearer <token>`

## 2. Endpoints

### 2.1 Upload File
- `POST /media/upload`
- **Type:** `multipart/form-data`
- **Fields:** `file` (binary), `folder` (optional)
- **201 Created:**
```json
{
  "data": {
    "id": "uuid-media-123",
    "filename": "a1b2c3.jpg",
    "original_name": "photo.jpg",
    "mime_type": "image/jpeg",
    "size_bytes": 102400,
    "url": "https://storage.example.com/avatars/a1b2c3.jpg"
  }
}
```

### 2.2 Attach to Entity
- `POST /media/attach`
- **Request:**
```json
{
  "media_id": "uuid-media-123",
  "entity_type": "product",
  "entity_id": "uuid-product-999",
  "tag": "gallery"
}
```
- **200 OK:** `{ "message": "Media attached successfully." }`

### 2.3 Delete Media
- `DELETE /media/{id}`
- **Access:** Owner / Admin
- **200 OK:** `{ "message": "Media deleted successfully." }`

## 3. Errors
- `413 PAYLOAD_TOO_LARGE`: Size limit exceeded.
- `422 INVALID_FILE_TYPE`: MIME type blocked.
- `404 NOT_FOUND`: Resource missing.
