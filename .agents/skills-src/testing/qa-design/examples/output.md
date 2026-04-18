# Example Output: qa-design

## Example 1: User login feature

**Test Scenarios**

| ID | Type | Scenario | Input | Expected |
|----|------|----------|-------|----------|
| TC-001 | Positive | Valid login | Correct email + password | 200, JWT token returned |
| TC-002 | Positive | Login returns refresh token | Correct credentials | Response includes `refreshToken` |
| TC-003 | Negative | Wrong password | Correct email, wrong password | 401, "Invalid credentials" |
| TC-004 | Negative | Non-existent email | Unknown email | 401, "Invalid credentials" (no user enumeration) |
| TC-005 | Negative | Missing email field | No email in body | 400, validation error on `email` |
| TC-006 | Negative | Missing password field | No password in body | 400, validation error on `password` |
| TC-007 | Negative | Empty string email | `email: ""` | 400, validation error |
| TC-008 | Negative | Account locked | 5 prior failures | 429, "Account temporarily locked", `retryAfter` in response |
| TC-009 | Negative | Correct password but locked | Correct creds after lockout | 429 (lockout takes priority) |
| TC-010 | Monkey | SQL injection in email | `' OR '1'='1` | 401 (not 200, no DB error) |
| TC-011 | Monkey | Extremely long password (10k chars) | 10000-char password | 400 or 401, no 500 |
| TC-012 | Monkey | Unicode in email | `tëst@example.com` | 401 (graceful, no crash) |
| TC-013 | Security | Lockout resets after 15 min | Wait 15 min after lockout | Login succeeds again |
| TC-014 | Security | Failed attempt counter resets on success | 4 failures then success | Counter resets to 0 |
| TC-015 | Security | Response time consistent | Valid vs invalid email | Both respond in ~same time (no timing oracle) |
