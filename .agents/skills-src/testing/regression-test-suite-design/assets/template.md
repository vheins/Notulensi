# Regression Test Suite Specification Template

> Fill in all fields before activating the `regression-test-suite-design` skill.

---

## Context

**Project:** `{{project-name}}`

**Tech Stack:** {{e.g. Node.js + Express + PostgreSQL, Python + Django}}

**Trigger:** {{e.g. before release v2.0, after major refactor, recurring CI}}

---

## Previously Reported Bugs (to prevent regression)

| Bug ID | Description | Affected Area | Fixed In |
|--------|-------------|---------------|----------|
| `{{BUG-001}}` | {{e.g. order total calculated incorrectly with discount}} | `OrderService` | `v1.2.1` |
| `{{BUG-002}}` | {{e.g. user can checkout with empty cart}} | `CheckoutController` | `v1.3.0` |
| `{{BUG-003}}` | {{e.g. password reset link expires immediately}} | `AuthService` | `v1.4.0` |

---

## Critical Paths to Cover

| Path | Priority | Description |
|------|----------|-------------|
| {{e.g. User registration → login}} | high | {{core auth flow}} |
| {{e.g. Add to cart → checkout → payment}} | high | {{revenue-critical}} |
| {{e.g. Admin creates product}} | medium | {{content management}} |
| `{{path}}` | {{priority}} | {{description}} |

---

## Test Types in Suite

| Type | Count | Framework | Run Frequency |
|------|-------|-----------|---------------|
| Unit tests | {{e.g. 200}} | {{e.g. Jest}} | every commit |
| Integration tests | {{e.g. 50}} | {{e.g. Jest + supertest}} | every PR |
| E2E tests | {{e.g. 20}} | {{e.g. Playwright}} | pre-release |

---

## Flaky Test Policy

**Max allowed flakiness:** {{e.g. 0% — all tests must be deterministic}}

**Quarantine process:** {{e.g. move to quarantine suite, fix within 1 sprint}}

---

## CI Integration

**Run on:** {{every commit / PR only / nightly / pre-release}}

**Fail threshold:** {{e.g. any failure blocks merge}}

**Notification:** {{e.g. Slack #alerts, email to team}}
