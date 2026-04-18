# E2E Test Scenario Template

> Fill in all fields before activating the `e2e-test-scenario-writing` skill.

---

## Feature / Flow to Test

**Feature:** `{{e.g. User Registration, Checkout, Password Reset}}`

**Entry Point:** `{{URL — e.g. https://app.example.com/register}}`

**Tech Stack:** {{e.g. React + Next.js, Vue 3}}

**E2E Framework:** {{Playwright / Cypress / Selenium / Puppeteer}}

---

## User Flow

```
Step 1: {{e.g. Navigate to /register}}
Step 2: {{e.g. Fill in name, email, password}}
Step 3: {{e.g. Click "Create Account"}}
Step 4: {{e.g. Verify redirect to /dashboard}}
Step 5: {{e.g. Verify welcome email sent}}
```

---

## Test Scenarios

### Happy Path

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | {{action}} | {{expected}} |
| 2 | {{action}} | {{expected}} |

### Error Cases

| Scenario | Input | Expected Result |
|----------|-------|-----------------|
| {{e.g. Duplicate email}} | {{existing email}} | {{error message shown}} |
| {{e.g. Weak password}} | {{password < 8 chars}} | {{validation error}} |

### Edge Cases

| Scenario | Condition | Expected Result |
|----------|-----------|-----------------|
| {{e.g. Slow network}} | {{throttle to 3G}} | {{loading state shown, no crash}} |
| {{e.g. Session expired}} | {{token expired mid-flow}} | {{redirect to login}} |

---

## Test Data

**Test user:**
```
email: test-{{timestamp}}@example.com
password: TestPass123!
```

**Fixtures / Seeds:** {{e.g. seed products, create test org}}

---

## Environment

**Base URL:** `{{e.g. http://localhost:3000, https://staging.example.com}}`

**Auth:** {{e.g. bypass via test token, use test credentials}}

**Cleanup:** {{e.g. delete test user after each test}}
