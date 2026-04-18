# Feature Flag Specification Template

> Fill in all fields before activating the `feature-flag-implementation` skill.

---

## Feature Flag Info

**Flag Name:** `{{feature-flag-name}}` *(e.g. `new-checkout-flow`, `dark-mode`)*

**Description:** {{what feature this flag controls}}

**Flag Type:** {{boolean / percentage rollout / user segment / A/B variant}}

---

## Rollout Strategy

| Stage | Target | Percentage / Criteria |
|-------|--------|-----------------------|
| Internal | {{e.g. team members only}} | {{e.g. user.email ends with @company.com}} |
| Beta | {{e.g. opted-in users}} | {{e.g. 10% of users}} |
| GA | {{e.g. all users}} | {{100%}} |

---

## Targeting Rules

**Enable for:**
- Users with role: {{e.g. admin, beta_tester}}
- Users in region: {{e.g. US, EU}}
- Account plan: {{e.g. pro, enterprise}}
- Percentage: {{e.g. 25% of all users}}

**Disable for:**
- {{e.g. users on legacy plan}}

---

## Tech Stack

**Stack:** {{e.g. Node.js + TypeScript + Express, React + Next.js}}

**Flag Storage:** {{e.g. environment variable, database table, LaunchDarkly, Unleash, custom}}

**Evaluation Point:** {{e.g. server-side per request, client-side on page load}}

---

## Cleanup Plan

**Target removal date:** {{e.g. after 2026-Q2 release}}

**Cleanup steps:**
1. Remove flag check from code
2. Delete flag from storage
3. Remove targeting rules
