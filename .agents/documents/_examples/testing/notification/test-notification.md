# Test Scenarios: Notification

## Navigation
- [Overview](../../modules/notification/overview.md) | [Feature](../../modules/notification/notification-system.md) | [API](../../api/notification/api-notifications.md)

## 1. Functional

### Happy Path
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| NOT-001 | US-NOT-01 | Send email | Template + User | 202 Accepted |
| NOT-002 | US-NOT-03 | List own | Token | 200 OK, list |
| NOT-003 | US-NOT-03 | Mark read | `is_read: true` | 200 OK, updated |

### Edge Cases
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| NOT-010 | US-NOT-01 | Bad template | "INVALID" | 422 Unprocessable |
| NOT-011 | US-NOT-01 | No recipient | `user_id: null` | 400 Bad Request |
| NOT-012 | US-NOT-03 | Cross-read | User B Notif | 403 Forbidden |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | Any | Inj. attempt | `{{env}}` payload | Literal render |
| SEC-002 | Any | Rate limit OTP | 20 OTPs / 1 min | 429 Too Many |

## 3. Chaos
| ID | Focus | Case | Expected |
| :- | :---- | :--- | :------- |
| MNK-001 | Flood | 1k requests/sec | 202 Accepted |
| MNK-002 | Size | 10MB body | 413 Too Large |
