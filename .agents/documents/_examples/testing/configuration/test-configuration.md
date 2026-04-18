# Test Scenarios: Configuration

## Navigation
- [Overview](../../modules/configuration/overview.md) | [Feature](../../modules/configuration/system-config.md) | [API](../../api/configuration/api-configuration.md)

## 1. Functional

### Happy Path
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| CFG-001 | US-CFG-01 | Update value | Admin token | 200 OK, updated |
| CFG-002 | US-CFG-03 | Get public | — | Only public items |
| CFG-003 | US-CFG-01 | List all | Admin token | All configurations |
| CFG-004 | US-CFG-04 | Cache invalid | Update value | Next GET returns new |

### Edge Cases
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| CFG-010 | US-CFG-01 | User access | User token | 403 Forbidden |
| CFG-011 | US-CFG-01 | Wrong type | Bad value | 400 Bad Request |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | Any | Private Leak | GET /public | No private configs |
| SEC-002 | Admin | Audit Trail | PATCH config | Audit record created |
