# Example Input: qa-design

## Example 1: User login feature

| Variable | Value |
|----------|-------|
| `{{feature_description}}` | User login with email and password. Lockout after 5 failed attempts for 15 minutes. JWT returned on success. |
| `{{user_stories}}` | As a registered user, I want to log in with my email and password, so that I can access my account. As a security system, I want to lock accounts after repeated failures, so that brute force attacks are prevented. |
| `{{tech_stack}}` | Node.js + Express + JWT |
