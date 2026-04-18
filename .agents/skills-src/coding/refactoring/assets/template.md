# Refactoring Specification Template

> Fill in all fields before activating the `refactoring` skill.

---

## Code to Refactor

**File(s):** `{{path/to/file.ts}}`

**Tech Stack:** {{e.g. TypeScript + Node.js, Python, Go}}

---

## Current Code

```{{language}}
{{paste the code to refactor}}
```

---

## Problems to Fix

| Problem | Severity | Description |
|---------|----------|-------------|
| {{e.g. God class}} | {{high/medium/low}} | {{e.g. OrderService has 800 lines, handles 12 responsibilities}} |
| {{e.g. Duplicated logic}} | {{high/medium/low}} | {{e.g. validation repeated in 5 controllers}} |
| {{e.g. Deep nesting}} | {{medium}} | {{e.g. 5-level nested if/else}} |
| {{e.g. Magic numbers}} | {{low}} | {{e.g. hardcoded 86400 instead of named constant}} |
| {{e.g. Missing abstraction}} | {{medium}} | {{e.g. DB calls directly in controller}} |

---

## Refactoring Goals

| Goal | Include? |
|------|----------|
| Extract service / helper classes | {{yes/no}} |
| Remove duplication (DRY) | {{yes/no}} |
| Improve naming | {{yes/no}} |
| Reduce function length (max {{N}} lines) | {{yes/no}} |
| Add missing types / interfaces | {{yes/no}} |
| Improve testability | {{yes/no}} |

---

## Constraints

**Must preserve:** {{e.g. public API surface, existing test suite, DB schema}}

**Cannot change:** {{e.g. function signatures used by other modules}}

**Test coverage before refactor:** {{e.g. 60%, none — write tests first}}
