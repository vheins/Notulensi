# Edge Case Identification Template

> Fill in all fields before activating the `edge-case-identification` skill.

---

## Function / Feature to Analyze

**Name:** `{{e.g. calculateDiscount(), processPayment(), UserRegistration}}`

**Description:** {{what it does}}

**Tech Stack:** {{e.g. TypeScript, Python, Go}}

---

## Function Signature / Interface

```{{language}}
{{paste function signature, method, or API endpoint spec}}
```

---

## Input Parameters

| Parameter | Type | Constraints | Normal Range |
|-----------|------|-------------|--------------|
| `{{param}}` | {{type}} | {{e.g. required, min: 0, max: 100}} | {{e.g. 1–50}} |
| `{{param}}` | {{type}} | {{e.g. non-empty string, max 255}} | {{e.g. typical username}} |

---

## Known Business Rules

- {{e.g. discount cannot exceed 100%}}
- {{e.g. quantity must be a positive integer}}
- {{e.g. user must be verified before checkout}}

---

## Edge Case Categories to Explore

| Category | Examples to Consider |
|----------|---------------------|
| Boundary values | min, max, min-1, max+1, zero |
| Empty / null inputs | null, undefined, empty string, empty array |
| Type coercion | "123" vs 123, true vs "true" |
| Concurrency | simultaneous requests, race conditions |
| Large inputs | very long strings, large arrays, huge numbers |
| Special characters | unicode, SQL injection chars, newlines |
| Negative numbers | where only positive expected |
| Floating point | 0.1 + 0.2, precision issues |
| Timezone / date | DST, leap year, end of month |
| Auth edge cases | expired token, revoked session, role change mid-session |

---

## Existing Test Coverage

**Current tests:** {{describe what's already tested}}

**Gaps identified:** {{what's not covered}}
