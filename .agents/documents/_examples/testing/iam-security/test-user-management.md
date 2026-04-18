# Test Scenarios: User Management

## Navigation
- [Overview](./overview.md) | [Feature](../../modules/iam-security/user-management.md) | [API](../../api/iam-security/api-user-management.md)

## 1. Functional

### Happy Path
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| USR-001 | US-USR-01 | Admin create | Valid data | 201 Created |
| USR-002 | US-USR-02 | Get self | Token | 200 OK |
| USR-003 | US-USR-02 | Update self | Name/Bio | 200 OK |
| USR-004 | US-USR-03 | Suspend user | User ID | 200 OK |
| USR-005 | US-USR-03 | Reactivate | User ID | 200 OK |
| USR-006 | US-USR-01 | Delete user | User ID | 204 No Content |
| USR-007 | US-USR-04 | Filter list | `?status=...`| 200 OK |

### Edge Cases
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| USR-010 | US-USR-01 | User list all | — | 403 Forbidden |
| USR-011 | US-USR-02 | IDOR update | Other ID | 403 Forbidden |
| USR-012 | US-USR-01 | Suspended log | Valid creds | 403 Forbidden |
| USR-013 | US-USR-01 | Missing user | Random ID | 404 Not Found |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | User | IDOR edit | PATCH other | 403 Forbidden |
| SEC-002 | Any | Pass leak | GET user | No hash in JSON |
| SEC-003 | User | Escalate | Create admin | 403 Forbidden |
