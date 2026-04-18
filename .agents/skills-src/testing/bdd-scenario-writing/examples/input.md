# Example Input: bdd-scenario-writing

## Example 1: User Login Feature

| Variable | Value |
|----------|-------|
| `{{feature_description}}` | User login with email and password. Users can log in with valid credentials, see errors for invalid ones, and get locked out after 5 failed attempts. |
| `{{tech_stack}}` | Node.js + Express + Cucumber.js |
| `{{context}}` | JWT-based auth, lockout resets after 15 minutes |
