# Example Input: qa-execution

## Example 1: Execute login test plan

| Variable | Value |
|----------|-------|
| `{{feature_description}}` | User login with email/password, lockout after 5 failures |
| `{{test_plan}}` | TC-001 through TC-015 from qa-design output (see examples/output.md in qa-design) |
| `{{implementation_summary}}` | POST /api/auth/login implemented. JWT + refresh token returned. Lockout via Redis counter (key: `lockout:{email}`, TTL 900s). Known limitation: lockout counter not reset on successful login yet (BUG-201). |
