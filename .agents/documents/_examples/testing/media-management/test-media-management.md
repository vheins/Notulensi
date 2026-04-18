# Test Scenarios: Media Management

## Navigation
- [Overview](../../modules/media-management/overview.md) | [Feature](../../modules/media-management/file-management.md) | [API](../../api/media-management/api-media-management.md)

## 1. Functional

### Happy Path
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| MED-001 | US-MED-01 | Valid image | JPG, 1MB | 201 Created |
| MED-002 | US-MED-04 | PDF document | PDF, 2MB | 201 Created |
| MED-003 | US-MED-02 | Attach entity | Entity + Media | 200 OK |
| MED-004 | US-MED-02 | Delete media | Media ID | 200 OK, deleted |

### Edge Cases
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| MED-010 | US-MED-01 | Oversized | 50MB video | 413 Too Large |
| MED-011 | US-MED-01 | Blocked type | .exe file | 422 Unprocessable |
| MED-012 | US-MED-02 | Bad Entity | Random ID | 404 Not Found |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | Any | Traversal | `../../passwd` | Sanitized/Blocked |
| SEC-002 | Any | Zip Bomb | High ratio file | Rejected by size |
