# Mutation Testing Specification Template

> Fill in all fields before activating the `mutation-testing-guidance` skill.

---

## Project Info

**Tech Stack:** {{e.g. TypeScript + Jest, Python + pytest, Java + JUnit}}

**Mutation Tool:** {{e.g. Stryker (JS/TS), mutmut (Python), PIT (Java), go-mutesting (Go)}}

---

## Scope

**Files / Modules to Mutate:**
```
{{e.g. src/services/OrderService.ts}}
{{e.g. src/utils/discount.ts}}
```

**Exclude from mutation:**
```
{{e.g. src/generated/, src/migrations/, src/types/}}
```

---

## Current Test Coverage

**Coverage:** {{e.g. 85% line coverage}}

**Test command:** `{{e.g. npm test, pytest}}`

**Test files:**
```
{{e.g. tests/unit/OrderService.test.ts}}
```

---

## Mutation Score Target

**Current mutation score:** {{e.g. unknown / 45%}}

**Target mutation score:** {{e.g. ≥70%}}

**Acceptable surviving mutants:** {{e.g. trivial mutations in logging, toString methods}}

---

## Mutation Operators to Apply

| Operator | Include? | Example |
|----------|----------|---------|
| Arithmetic (`+` → `-`) | yes | `a + b` → `a - b` |
| Comparison (`>` → `>=`) | yes | `x > 0` → `x >= 0` |
| Logical (`&&` → `\|\|`) | yes | `a && b` → `a \|\| b` |
| Return value (return null) | yes | `return result` → `return null` |
| Conditional boundary | yes | `if (x > 0)` → `if (x >= 0)` |
| String literal | {{yes/no}} | `"error"` → `""` |

---

## Stryker Config (if applicable)

```json
{
  "mutate": ["{{src/**/*.ts}}"],
  "testRunner": "{{jest}}",
  "reporters": ["html", "clear-text"],
  "thresholds": { "high": 80, "low": 60, "break": 50 }
}
```
