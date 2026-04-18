# API Specification: Background Jobs

## Navigation
- [Overview](../../modules/background-jobs/overview.md) | [Feature](../../modules/background-jobs/job-processing.md) | [Testing](../../testing/background-jobs/test-background-jobs.md)

## 1. Standards
- **Base URL:** `/api/v1/jobs`
- **Auth:** `Authorization: Bearer <token>` (Admin/System)

## 2. Endpoints

### 2.1 Get Status
- `GET /jobs/{queue}/{jobId}`
- **Access:** Admin/System
- **200 OK:**
```json
{
  "data": {
    "id": "job-uuid-123",
    "queue": "export",
    "status": "completed",
    "progress": 100,
    "result": { "download_url": "https://..." },
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### 2.2 Retry Job
- `POST /jobs/{queue}/{jobId}/retry`
- **Access:** Admin
- **200 OK:**
```json
{ "message": "Job retried successfully." }
```

### 2.3 Trigger Export
- `POST /jobs/export`
- **Access:** Authenticated
- **Request:**
```json
{
  "format": "csv",
  "date_range": { "from": "2024-01-01", "to": "2024-01-31" }
}
```
- **202 Accepted:**
```json
{
  "data": {
    "job_id": "job-uuid-new",
    "status": "waiting",
    "queue": "export"
  }
}
```
