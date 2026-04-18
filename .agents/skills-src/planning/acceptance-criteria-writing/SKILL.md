---
name: acceptance-criteria-writing
description: Writes EARS-format acceptance criteria for a user story. DO NOT use for generating user stories, test cases, or sprint goals.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 5–15 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Intermediate
tokens: ~3500
tags: [acceptance-criteria, EARS, user-stories, requirements, testing, quality]
author: vheins
---

# Skill: Acceptance Criteria Writing

## Purpose
Produces testable acceptance criteria using Given/When/Then (EARS) format covering happy paths, edge cases, failures, and non-functional requirements.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `user_story` | string | Yes | Target user story |
| `tech_stack` | string | Yes | Technology stack |
| `context` | string | Yes | Constraints/Background |

## Instructions
- **Happy Path**: Write 3–5 criteria for primary success scenarios. Ensure they are specific and atomic.
- **Edge Cases**: Write 3–5 criteria for boundaries (empty inputs, max lengths, concurrent requests).
- **Errors**: Write 3–4 criteria for validation/auth/system failures with exact error codes/messages.
- **Non-Functional**: Write 2–3 criteria for measurable performance, security, and accessibility thresholds.
- **Testability**: Include notes flagging hard-to-automate criteria and suggest testing approaches.
- **Clarification**: If the goal or benefit is missing from the story, ask for details before proceeding.

## Edge Cases
| Case | Strategy |
|------|----------|
| Vague Story | Stop and request measurable targets/outcomes from the user. |
| Broad Story | Note the need for splitting; write for the most specific interpretation. |
| Missing NFRs | Apply stack-appropriate defaults (e.g., <200ms latency) and label as assumed. |

## Workflow
```mermaid
flowchart TD
    A([Start: AC Writing Request]) --> B{user_story\nclear and specific?}
    B -- No --> C[Ask for clarification:\nmissing goal or benefit]
    C --> B
    B -- Yes --> D{context provides\nperformance/security\nconstraints?}
    D -- No --> E[Apply reasonable defaults\nfrom tech_stack\nLabel as assumed]
    D -- Yes --> F[Use provided constraints\nfor NFR criteria]
    E & F --> G[Write Happy Path Criteria\n3–5 Given/When/Then\nprimary success scenario]
    G --> H[Write Edge Case Criteria\n3–5 boundary conditions:\nempty inputs, max length,\nconcurrent requests, zero values]
    H --> I[Write Error/Failure Criteria\n3–4 with exact error message\nor HTTP status code per criterion]
    I --> J[Write Non-Functional Criteria\n2–3 with measurable thresholds:\nperformance + security + accessibility]
    J --> K[Review all criteria:\neach must be independently testable]
    K --> L{Any criterion\nvague or untestable?}
    L -- Yes --> M[Rewrite with specific\nmeasurable threshold]
    L -- No --> N[Write Testability Notes\nflag hard-to-automate criteria\nsuggest testing approach]
    M --> N
    N --> O([Output: 4 groups of AC\n+ Testability Notes\n400–700 words])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Criteria use Given/When/Then format.
- [ ] All 4 categories (Happy/Edge/Error/NFR) covered.
- [ ] Thresholds are measurable.
- [ ] Error messages are explicit.
- [ ] Testability notes included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.2.0 | 2026-03-21 | EARS → Given/When/Then. Exact errors required. |
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
