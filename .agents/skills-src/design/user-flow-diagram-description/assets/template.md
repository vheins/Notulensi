# User Flow Diagram Specification Template

> Fill in all fields before activating the `user-flow-diagram-description` skill.

---

## Flow Info

**Flow Name:** `{{e.g. User Registration, Checkout, Password Reset}}`

**Actor:** `{{e.g. new visitor, authenticated user, admin}}`

**Entry Point:** `{{e.g. landing page CTA, email link, direct URL}}`

**Success End State:** `{{e.g. account created + redirected to dashboard}}`

---

## Flow Steps

| Step | Screen | User Action | System Response | Next Step |
|------|--------|-------------|-----------------|-----------|
| 1 | `{{e.g. Landing Page}}` | {{e.g. clicks "Sign Up"}} | {{e.g. navigate to /register}} | Step 2 |
| 2 | `{{e.g. Register Form}}` | {{e.g. fills name, email, password}} | {{e.g. validate in real-time}} | Step 3 |
| 3 | `{{e.g. Register Form}}` | {{e.g. clicks "Create Account"}} | {{e.g. submit, show loading}} | Step 4 |
| 4 | `{{e.g. Email Sent}}` | {{e.g. checks email}} | {{e.g. send verification email}} | Step 5 |
| 5 | `{{e.g. Email}}` | {{e.g. clicks verify link}} | {{e.g. activate account, redirect to /dashboard}}` | End |

---

## Decision Points

| Step | Condition | Yes Path | No Path |
|------|-----------|----------|---------|
| Step 3 | Email already exists | show error "Email taken" | continue to step 4 |
| Step 3 | Validation fails | show field errors | continue to step 4 |
| Step 5 | Link expired | show "Resend email" | continue to end |

---

## Alternative Flows

| Scenario | Entry | Deviation | Resolution |
|----------|-------|-----------|------------|
| {{e.g. Social login}} | Step 2 | {{click "Sign in with Google"}} | {{OAuth flow → skip steps 3-5}} |
| {{e.g. Already logged in}} | Step 1 | {{detect session}} | {{redirect to /dashboard}} |

---

## Error States

| Error | Trigger | User-Facing Message |
|-------|---------|---------------------|
| {{e.g. Network error}} | {{submit fails}} | {{e.g. "Something went wrong. Please try again."}} |
| {{e.g. Invalid token}} | {{verify link}} | {{e.g. "This link has expired."}} |
