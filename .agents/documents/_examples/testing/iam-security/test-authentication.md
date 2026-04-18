# Test Scenarios: Authentication

## Navigation
- [Overview](./overview.md) | [Feature](../../modules/iam-security/authentication.md) | [API](../../api/iam-security/api-authentication.md)

## 1. Functional

### Happy Path
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| AUTH-001 | US-AUTH-01 | Register | Valid data | 201 Created |
| AUTH-002 | US-AUTH-01 | Login | Email/Pass | 200 OK, tokens |
| AUTH-003 | US-AUTH-01 | Refresh | Refresh token| 200 OK |
| AUTH-004 | US-AUTH-02 | Logout | Token | 204, revoked |
| AUTH-005 | US-AUTH-03 | Activate | Valid token | 200 OK, active |
| AUTH-006 | US-AUTH-05 | Forgot Pass | Email | 202 Accepted |
| AUTH-007 | US-AUTH-05 | Reset Pass | Token + Pass | 200 OK |
| AUTH-008 | US-AUTH-04 | Change Pass | Old + New | 204 No Content |

### Edge Cases
| ID | Story | Case | Input | Expected |
| :- | :---- | :--- | :---- | :------- |
| AUTH-010 | US-AUTH-01 | Duplicate | Same email | 409 Conflict |
| AUTH-011 | US-AUTH-01 | Weak Pass | "12345" | 422 Unprocessable |
| AUTH-012 | US-AUTH-01 | Bad Pass | Wrong pass | 401 Unauthorized |
| AUTH-013 | US-AUTH-01 | Inactive | Valid creds | 403 Forbidden |
| AUTH-014 | US-AUTH-05 | Expired | Old token | 400 Bad Request |
| AUTH-015 | US-AUTH-04 | Bad Old | Wrong current| 401 Unauthorized |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | Anon | SQLi | `' OR 1=1` | 400/401 Blocked |
| SEC-002 | Anon | JWT Tamper | Bad token | 401 Unauthorized |
| SEC-003 | Anon | Brute Force | 100 req/sec | 429 Too Many |
| SEC-004 | Any | Pass leak | GET /me | No hash in JSON |

## 3. Chaos
| ID | Focus | Case | Expected |
| :- | :---- | :--- | :------- |
| MNK-001 | Fuzzing | Random bytes | 400/422, no crash |
| MNK-002 | Types | Bad object | 400 Bad Request |
