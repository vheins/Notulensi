# Senior Code Review Request Template

> Fill in all fields before activating the `senior-code-review` skill.

---

## Change Overview

**PR / Change Title:** {{title}}

**Author:** {{author}} | **Reviewer:** {{reviewer}}

**Type:** {{feature / bugfix / refactor / performance / security}}

**Risk Level:** {{low / medium / high}}

---

## Code to Review

```{{language}}
{{paste the full diff or key changed files}}
```

---

## Context

**Tech Stack:** {{e.g. Node.js + TypeScript + Prisma + PostgreSQL}}

**Architecture pattern:** {{e.g. clean architecture, MVC, microservices}}

**Business context:** {{what problem this solves, why it matters}}

---

## Review Dimensions

| Dimension | Focus |
|-----------|-------|
| Correctness | Does it do what it claims? Edge cases handled? |
| Security | Input validation, auth checks, injection risks, data exposure |
| Performance | N+1 queries, missing indexes, blocking operations, memory |
| Maintainability | Naming, complexity, SOLID principles, test coverage |
| Reliability | Error handling, retries, idempotency, failure modes |
| Scalability | Will this hold at 10x load? 10x data? |

---

## Specific Concerns

{{list any specific areas you want the reviewer to focus on}}

- {{e.g. "Is the transaction handling correct for concurrent requests?"}}
- {{e.g. "Is the caching strategy safe for this data?"}}

---

## Tests

**Test coverage:** {{e.g. 80%, unit only, no integration tests}}

**Test command:** `{{e.g. npm test, pytest}}`
