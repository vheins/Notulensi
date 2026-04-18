---
name: code-review
description: >
  Use when a developer needs a thorough review of existing code before merging — covering bugs,
  security vulnerabilities, style violations, and improvement opportunities. Activate when the
  request involves reviewing a PR, function, or module for quality and correctness.
  Do NOT use for refactoring, generating new code, or writing tests.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [code-review, security, bugs, style, quality-assurance]
author: vheins
---

# Skill: Code Review

## Purpose
Perform a structured senior-level code review resulting in prioritized findings with fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Java + Spring Boot" |
| `code` | string | Yes | Function, class, module, or PR diff |
| `context` | string | Yes | Purpose, intent, or PR description |

## Instructions
- **Findings**: Categorize by severity (CRITICAL to SUGGESTION) and type (Bug, Security, Performance, Style, Maintainability, Test Coverage).
- **Structure**: Each finding must include **Severity**, **Category**, **Location**, **Problem**, and **Fix** (code snippet).
- **Dimensions**: Evaluate Correctness, Security (SQLi/XSS/Auth), Error Handling, Performance (N+1/Blocking), Style, and Testability.
- **Summary**: Provide total counts by severity, an overall assessment (APPROVE/REQUEST CHANGES/NEEDS DISCUSSION), and Top 3 priorities.

## Severity Reference
| Level | Impact |
|-------|--------|
| CRITICAL | Data loss, security breach, or outage. |
| HIGH | Incorrect behavior or major performance degradation. |
| MEDIUM | Code smell or edge-case logic failure. |
| LOW | Style inconsistency or naming issues. |
| SUGGESTION | Optional quality enhancement. |

## Review Flow
```mermaid
flowchart TD
    A([Start: code + tech_stack + context]) --> B{context provided?}
    B -- Empty --> C[Best-effort review\nflag: intent unclear\nmay miss logic errors]
    B -- Provided --> D{Code is auto-generated?\ne.g. ORM migration, protobuf}
    D -- Yes --> E[Review config correctness only\nskip style + maintainability]
    D -- No --> F[Full review]
    C --> F
    F --> G{Correctness\nlogic errors?}
    G -- Found --> H[Finding: Bug\nSeverity: CRITICAL/HIGH]
    G -- Clean --> I
    H --> I{Security issues?\ninjection/auth/exposure}
    I -- Found --> J[Finding: Security\nSeverity: CRITICAL/HIGH]
    I -- Clean --> K
    J --> K{Error handling\ngaps?}
    K -- Found --> L[Finding: Error Handling\nSeverity: MEDIUM]
    K -- Clean --> M
    L --> M{Performance issues?\nN+1 / blocking / missing index}
    M -- Found --> N[Finding: Performance\nSeverity: HIGH/MEDIUM]
    M -- Clean --> O
    N --> O{Style violations?}
    O -- Found --> P[Finding: Style\nSeverity: LOW]
    O -- Clean --> Q
    P --> Q{Testability issues?\nhidden deps?}
    Q -- Found --> R[Finding: Testability\nSeverity: MEDIUM/LOW]
    Q -- Clean --> S
    R --> S[Compile all findings\nSeverity + Category + Location\nProblem + Fix]
    S --> T{Any CRITICAL\nor HIGH?}
    T -- Yes --> U[Assessment: REQUEST CHANGES]
    T -- No --> V{Any MEDIUM?}
    V -- Yes --> W[Assessment: NEEDS DISCUSSION]
    V -- No --> X[Assessment: APPROVE]
    U & W & X --> Y[Summary: counts by severity\n+ top 3 priorities]
    Y --> Z([Output: Numbered findings\n+ Overall assessment + Top 3])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the assessment objective?
2. Are failure modes identified?
3. Are fixes concrete and actionable?
4. Are security implications addressed?
5. Is the review scoped to the stack?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
