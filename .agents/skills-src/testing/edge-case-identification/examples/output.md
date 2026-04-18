# Example Output: edge-case-identification

## Example 1: File upload handler

**Edge Cases Identified**

| Category | Edge Case | Expected Behavior |
|----------|-----------|-------------------|
| **File type** | File with `.jpg` extension but PNG content (MIME mismatch) | Reject — validate by magic bytes, not extension |
| **File type** | `.JPG` uppercase extension | Accept — normalize extension to lowercase |
| **File type** | `.jpeg` vs `.jpg` | Both should be accepted |
| **File type** | SVG file (can contain XSS) | Reject — not in allowed list |
| **File size** | Exactly 50MB | Accept (boundary) |
| **File size** | 50MB + 1 byte | Reject with 413 |
| **File size** | 0 bytes (empty file) | Reject with 400 |
| **File size** | Very large filename (>255 chars) | Handle gracefully, truncate or reject |
| **userId** | Non-existent userId | Reject with 404 before uploading to S3 |
| **userId** | SQL/path injection in userId | Sanitize before using in S3 key |
| **Concurrency** | Same user uploads 2 files simultaneously | Both succeed, no race condition on S3 key |
| **S3 failure** | S3 returns 503 during upload | Return 502, do not leave partial upload |
| **S3 failure** | S3 upload times out | Return 504, retry logic or clear error |
| **Network** | Client disconnects mid-upload | Abort S3 upload, no orphaned files |
| **Filename** | Unicode characters in filename | Encode properly for S3 key |
| **Filename** | Filename with `../` path traversal | Sanitize — strip path components |
| **Duplicate** | Same file uploaded twice by same user | Allow (idempotent) or deduplicate by hash |

**Highest Priority to Test**
1. MIME type spoofing (security)
2. 50MB boundary (exact + 1 byte over)
3. S3 failure handling (no orphaned files)
4. Path traversal in filename (security)
