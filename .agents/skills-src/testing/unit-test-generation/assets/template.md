# Unit Test Specification Template

> Fill in all fields before activating the `unit-test-generation` skill.

---

## Function / Class to Test

**Name:** `{{e.g. calculateDiscount, UserService, parseDate}}`

**File:** `{{e.g. src/services/UserService.ts}}`

**Tech Stack:** {{e.g. TypeScript + Jest, Python + pytest, Go test}}

---

## Code to Test

```{{language}}
{{paste the function or class to test}}
```

---

## Dependencies to Mock

| Dependency | Type | Mock Strategy |
|------------|------|---------------|
| `{{e.g. UserRepository}}` | database | `jest.fn() / mock.patch` |
| `{{e.g. EmailService}}` | external | `jest.fn()` |
| `{{e.g. Date.now}}` | built-in | `jest.spyOn` |

---

## Test Cases

### Happy Path

| Test | Input | Expected Output |
|------|-------|-----------------|
| {{description}} | {{input}} | {{expected}} |

### Error Cases

| Test | Input | Expected Error |
|------|-------|----------------|
| {{description}} | {{invalid input}} | {{error type / message}} |

### Edge Cases

| Test | Scenario | Expected |
|------|----------|----------|
| {{description}} | {{boundary / null / empty}} | {{expected}} |

---

## Test Config

**Framework:** {{e.g. Jest, Vitest, pytest, Go test}}

**Test file:** `{{e.g. src/services/__tests__/UserService.test.ts}}`

**Coverage target:** {{e.g. 100% branch coverage for this function}}

**Run command:** `{{e.g. npm test -- UserService, pytest tests/unit/test_user_service.py}}`
