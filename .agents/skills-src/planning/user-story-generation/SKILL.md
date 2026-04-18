---
name: user-story-generation
description: >
  Generate user stories in standard "As a [role], I want [goal], so that [benefit]" format with EARS-format acceptance criteria.
  Do NOT use for technical task breakdown, sprint planning, or backlog grooming.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 5–10 mins"
license: Proprietary — Personal Use Only
category: planning
complexity: Beginner
tokens: ~2500
tags: [user-stories, agile, acceptance-criteria, product-planning, EARS]
author: vheins
---

# Skill: User Story Generation

## Purpose
Generate well-formed user stories covering primary roles and interactions. Use standard format and EARS acceptance criteria to define build and verification requirements.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{feature_name}}` | string | yes | Feature name (e.g., "User Notifications") |
| `{{user_role}}` | string | yes | Primary user role/persona (e.g., "admin") |
| `{{context}}` | string | yes | Feature description, constraints |

## Prompt
You are a senior product manager defining user stories before implementation.

Feature: {{feature_name}}
Role: {{user_role}}
Context: {{context}}

Generate 3 to 8 user stories covering happy path, key variations, and ≥1 edge case/error scenario.

For each story, produce:

**Story [N]: [Short Title]**
- Story: As a {{user_role}}, I want [specific goal], so that [concrete benefit].
- Acceptance Criteria (Given/When/Then format):
  1. **Given** [precondition], **When** [action], **Then** [expected outcome].
  2. **Given** [precondition], **When** [action], **Then** [expected outcome].
  3. **Given** [precondition], **When** [action], **Then** [expected outcome].

Given/When/Then rules:
- **Given**: System state before action
- **When**: Specific action performed
- **Then**: Observable outcome after action
- Each criterion must be independently testable
- Use measurable thresholds (no vague terms like "quickly")
- Cover happy path, validation failure, auth failure, edge case

Provide after stories:

**Coverage Summary**: List covered and intentionally excluded user scenarios.

**Suggested Story Order**: Recommend implementation order for fastest user value delivery.

If feature scope/role is unclear, ask for clarification. Do NOT invent roles/features.

## Examples

@examples/input.md
@examples/output.md

## Edge Cases
1. **Single-action feature**: Generate ≥3 stories covering action, error states, and confirmation behavior.
2. **Multiple user roles**: Generate separate, clearly labeled story sets per role.
3. **Vague benefit clause**: Make benefit explicit and concrete, flag for product owner review.

## Output Format
Numbered story blocks (title, statement, 3 EARS criteria). Followed by Coverage Summary and Suggested Story Order. Total: 300–600 words for 3–8 stories.

## Senior Review Checklist
1. Simplest solution?
2. Failure modes handled?
3. Scales to 10x?
4. Security implications addressed?
5. Testable/observable in production?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.2.0 | 2026-03-21 | Upgrade acceptance criteria: EARS → Given/When/Then, added coverage types |
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |

## MCP Dependencies

- `@modelcontextprotocol/server-sequential-thinking` — Multi-step reasoning

## Output Path
```
.agents/documents/requirements/user-stories/{feature-slug}.md
```

## Mermaid Diagram

```mermaid
flowchart TD
    A([Start: User Story Generation]) --> B[Parse inputs]

    B --> C{Feature scope\nclear?}
    C -- Unclear --> D[Ask for clarification]
    D --> B
    C -- Yes --> E{Multiple distinct\nroles?}

    E -- Yes --> F[Generate separate story sets]
    E -- No --> G[Generate primary role stories]

    F & G --> H{Single-action?}
    H -- Yes --> I[Expand to 3 stories minimum (happy, error, confirm)]
    H -- No --> J[Cover variations, edge cases]

    I & J --> K[For each story: write goal, benefit]

    K --> L{Vague benefit?}
    L -- Yes --> M[Make benefit concrete, flag review]
    L -- No --> N

    M & N --> O[Write 3 Given/When/Then criteria]

    O --> P{Independently testable?}
    P -- No --> Q[Rewrite with measurable thresholds]
    Q --> O
    P -- Yes --> R[Ensure coverage types]

    R --> S[Write Coverage Summary]
    S --> T[Write Suggested Story Order]

    T --> U([Output: 3–8 Stories + Summary + Order])
```