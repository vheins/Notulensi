# Test Scenarios: Role & Permission Management

## Navigation
- [Overview](./overview.md) | [Feature](../../modules/iam-security/role-permission-management.md) | [API](../../api/iam-security/api-role-permission-management.md)

## 1. Functional

### Happy Path
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| RBAC-001 | US-RBAC-01 | Create role | Name | 201 Created |
| RBAC-002 | US-RBAC-03 | Assign perms | Perm IDs | 204 No Content |
| RBAC-003 | US-RBAC-02 | Assign role | User + Role | 204 No Content |
| RBAC-004 | US-RBAC-04 | Valid access | — | 200 OK |
| RBAC-005 | US-RBAC-01 | List all | — | 200 OK, list |
| RBAC-006 | US-RBAC-01 | Delete unused| Role ID | 204 No Content |

### Edge Cases
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| RBAC-010 | US-RBAC-01 | Duplicate | "editor" | 409 Conflict |
| RBAC-011 | US-RBAC-04 | Unauthorized | — | 403 Forbidden |
| RBAC-012 | US-RBAC-01 | Delete in-use| Role ID | 409 Conflict |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | User | Escalate | POST /roles | 403 Forbidden |
| SEC-002 | User | Self-admin | PUT /roles | 403 Forbidden |
