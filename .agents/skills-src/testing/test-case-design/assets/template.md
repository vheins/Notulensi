# Test Case Design Template

> Fill in all fields before activating the `test-case-design` skill.

---

## Feature / Function to Test

**Name:** `{{e.g. UserRegistration, calculateShipping, applyDiscount}}`

**Description:** {{what it does}}

**Tech Stack:** {{e.g. TypeScript + Node.js, Python, Go}}

---

## Function / API Spec

```{{language}}
{{paste function signature, API endpoint, or feature description}}
```

---

## Test Case Matrix

### Positive Cases (valid inputs, expected success)

| Test ID | Input | Expected Output | Priority |
|---------|-------|-----------------|----------|
| TC-001 | {{valid input}} | {{expected result}} | high |
| TC-002 | {{another valid input}} | {{expected result}} | high |

### Negative Cases (invalid inputs, expected errors)

| Test ID | Input | Expected Error | Priority |
|---------|-------|----------------|----------|
| TC-010 | {{invalid input}} | {{error type / message}} | high |
| TC-011 | {{missing required field}} | {{validation error}} | high |

### Boundary Cases

| Test ID | Input | Expected Output | Boundary |
|---------|-------|-----------------|----------|
| TC-020 | {{min value}} | {{expected}} | lower bound |
| TC-021 | {{max value}} | {{expected}} | upper bound |
| TC-022 | {{min - 1}} | {{error}} | below lower bound |

### Edge Cases

| Test ID | Scenario | Input | Expected |
|---------|----------|-------|----------|
| TC-030 | {{e.g. empty array}} | `[]` | {{e.g. return 0}} |
| TC-031 | {{e.g. null input}} | `null` | {{e.g. throw TypeError}} |

---

## Test Framework

**Framework:** {{e.g. Jest, pytest, Go test, RSpec}}

**Test file:** `{{e.g. tests/unit/discount.test.ts}}`

**Mocks needed:** {{e.g. mock DB, mock external API}}
