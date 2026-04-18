# Testing Overview: IAM & Security

## Navigation
- [Module Overview](../../modules/iam-security/overview.md)

## 1. Scope
- **Authentication:** Login, register, recovery, tokens. [Scenarios](./test-authentication.md)
- **User Management:** CRUD, profiles, status. [Scenarios](./test-user-management.md)
- **RBAC:** Roles, permissions, enforcement. [Scenarios](./test-role-permission-management.md)

## 2. E2E Flows
- **Onboarding:** Admin creates → Email sent → User activates → User logins.
- **Enforcement:** Admin configures role → Assigns to user → User blocked from restricted routes.

## 3. Access Matrix
| Role | Auth | User Mgmt | Role Mgmt |
| :--- | :--- | :-------- | :-------- |
| **Super Admin** | Full | Full | Full |
| **Admin** | Full | Create/Edit/Suspend | Assign only |
| **User** | Self | Self only | — |

## 4. Strategy
- **Unit:** Required for hashing, token logic, and permission checks.
- **Integration:** Required for all API endpoints.
- **Security:** Focus on injection, auth bypass, and privilege escalation.
