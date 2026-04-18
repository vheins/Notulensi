# Code Review Checklist Template

> Use this template to structure a code review request for the `code-review` skill.

---

## PR / Change Info

**PR Title:** {{title}}

**Author:** {{author}}

**Branch:** `{{feature-branch}}` → `{{target-branch}}`

**Description:** {{what this change does}}

**Linked Issue / Ticket:** {{e.g. #123, JIRA-456}}

---

## Files Changed

```
{{list key files — paste from git diff --stat or PR file list}}
```

---

## Review Focus Areas

| Area | Priority | Notes |
|------|----------|-------|
| Correctness | {{high/medium/low}} | {{specific concerns}} |
| Security | {{high/medium/low}} | {{e.g. input validation, auth checks}} |
| Performance | {{high/medium/low}} | {{e.g. N+1 queries, missing indexes}} |
| Error handling | {{high/medium/low}} | |
| Test coverage | {{high/medium/low}} | |
| Code style / conventions | {{high/medium/low}} | |

---

## Context

**Tech Stack:** {{e.g. Node.js + TypeScript + Prisma}}

**Project Conventions:** {{e.g. thin controllers, service layer, Zod validation}}

**Known Constraints:** {{e.g. must be backward compatible, no new dependencies}}

---

## Code to Review

```{{language}}
{{paste the code diff or key sections here}}
```
