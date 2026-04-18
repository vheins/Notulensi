# Design Pattern Application Specification Template

> Fill in all fields before activating the `design-pattern-application` skill.

---

## Problem Description

**What is the current problem?**
{{describe the code smell, pain point, or design issue — e.g. "giant if/else chain for payment providers", "tightly coupled notification logic in order service"}}

**Where is it located?**
```
{{e.g. src/services/PaymentService.ts, app/Http/Controllers/OrderController.php}}
```

---

## Current Code (simplified)

```{{language}}
{{paste the problematic code or a simplified version}}
```

---

## Context

**Tech Stack:** {{e.g. TypeScript + Node.js, Python + FastAPI, Java + Spring}}

**Team Size / Experience:** {{e.g. 3 devs, mid-level}}

**Constraints:**
- {{e.g. must not break existing public API}}
- {{e.g. no new external dependencies}}
- {{e.g. must be testable in isolation}}

---

## Goals

| Goal | Priority |
|------|----------|
| Eliminate if/else / switch chains | {{high/medium/low}} |
| Enable adding new variants without modifying existing code | {{high/medium/low}} |
| Improve testability | {{high/medium/low}} |
| Reduce coupling | {{high/medium/low}} |
| {{custom goal}} | {{priority}} |

---

## Patterns Already Considered

| Pattern | Why Rejected (if applicable) |
|---------|------------------------------|
| {{e.g. Factory}} | {{e.g. doesn't solve the interface problem}} |
| {{e.g. Strategy}} | {{e.g. under consideration}} |
