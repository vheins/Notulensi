# Test Refactoring Specification Template

> Fill in all fields before activating the `test-refactoring` skill.

---

## Tests to Refactor

**File(s):** `{{e.g. tests/unit/OrderService.test.ts}}`

**Tech Stack:** {{e.g. TypeScript + Jest, Python + pytest}}

---

## Current Test Code

```{{language}}
{{paste the tests to refactor}}
```

---

## Problems to Fix

| Problem | Severity | Description |
|---------|----------|-------------|
| {{e.g. Duplicated setup}} | {{high/medium/low}} | {{e.g. same beforeEach in 5 describe blocks}} |
| {{e.g. Magic values}} | {{medium}} | {{e.g. hardcoded "user123" instead of factory}} |
| {{e.g. Testing implementation}} | {{high}} | {{e.g. asserts on private method calls}} |
| {{e.g. No isolation}} | {{high}} | {{e.g. tests share state, order-dependent}} |
| {{e.g. Unclear test names}} | {{medium}} | {{e.g. "test 1", "should work"}} |
| {{e.g. Overly large tests}} | {{medium}} | {{e.g. one test asserts 20 things}} |

---

## Refactoring Goals

| Goal | Include? |
|------|----------|
| Extract shared setup to beforeEach / fixtures | {{yes/no}} |
| Use factory functions for test data | {{yes/no}} |
| Rename tests to describe behavior (not implementation) | {{yes/no}} |
| Split large tests into focused single-assertion tests | {{yes/no}} |
| Remove test order dependencies | {{yes/no}} |
| Replace implementation assertions with behavior assertions | {{yes/no}} |

---

## Constraints

**Must not change:** {{e.g. test coverage must not decrease, all tests must still pass}}

**Test naming convention:** {{e.g. "should [behavior] when [condition]", "given/when/then"}}
