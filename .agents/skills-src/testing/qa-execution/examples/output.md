# Example Output: qa-execution

## Example 1: Execute login test plan

**Execution Summary**

| Total | Passed | Failed | Blocked | Skipped |
|-------|--------|--------|---------|---------|
| 15 | 12 | 2 | 1 | 0 |

**Results**

| ID | Result | Notes |
|----|--------|-------|
| TC-001 | ✅ Pass | 200, JWT returned |
| TC-002 | ✅ Pass | refreshToken present in response |
| TC-003 | ✅ Pass | 401, correct message |
| TC-004 | ✅ Pass | 401, same message as TC-003 (no enumeration) |
| TC-005 | ✅ Pass | 400, `email` field error |
| TC-006 | ✅ Pass | 400, `password` field error |
| TC-007 | ✅ Pass | 400 |
| TC-008 | ✅ Pass | 429, `retryAfter: 900` |
| TC-009 | ✅ Pass | 429 even with correct password |
| TC-010 | ✅ Pass | 401, no SQL error |
| TC-011 | ✅ Pass | 400 (password max length validation) |
| TC-012 | ✅ Pass | 401, no crash |
| TC-013 | ⏭ Blocked | Cannot test in CI — requires waiting 15 min. Manual test pending. |
| TC-014 | ❌ Fail | **BUG-201**: Counter not reset after successful login. After 4 failures + 1 success, 5th failure still triggers lockout. |
| TC-015 | ❌ Fail | **BUG-202**: Valid email responds in ~50ms, invalid email in ~200ms (DB lookup skipped). Timing oracle present. |

---

**Bug Reports**

**BUG-201** — Lockout counter not reset on successful login
- Severity: Medium
- Steps: Fail login 4 times → login successfully → fail once more → account locked (should not be)
- Expected: Counter resets to 0 on successful login
- Actual: Counter persists, 5th failure triggers lockout

**BUG-202** — Timing oracle: response time differs for valid vs invalid email
- Severity: High (security)
- Steps: Time 100 requests with valid email vs 100 with invalid email
- Expected: ~same response time (constant-time comparison)
- Actual: Invalid email ~4x faster — allows email enumeration via timing
- Fix: Always perform password hash comparison regardless of whether user exists
