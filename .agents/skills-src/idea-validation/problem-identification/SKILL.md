---
name: problem-identification
description: Articulates core problems behind product ideas, identifies users, and documents pain points. DO NOT use for solution brainstorming or feature planning.
version: "1.1.0"
time_saved: "Manual: 3–4 hours | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: idea-validation
complexity: Beginner
tokens: ~2500
tags: [problem-statement, pain-points, user-research, idea-validation]
author: vheins
---

# Skill: Problem Identification

## Purpose
Structures the problem space to identify root causes before proposing solutions.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{product_idea}}` | string | yes | Brief product/feature description |
| `{{target_domain}}` | string | yes | Industry or problem context |

## Prompt
- **Problem Statement**: 3–5 sentences (situation, gap, consequence).
- **Affected Users**: Table (User Group, Role, Frequency, Current Workaround).
- **Pain Points**: ≥3 verifiable points (Action → Pain → Consequence).
- **Root Cause**: 5-Why analysis chain (min 3 levels).
- **Impact**: Quantified short-term (6mo) and long-term (2-3yr) consequences.

## Rules
- Do NOT suggest solutions.
- No filler text.

## Edge Cases
| Case | Strategy |
|------|----------|
| Solution-First | Extract the underlying problem from the solution. |
| Vague Idea | Ask developer to narrow to specific user action. |

## Output Format
- Five numbered sections.
- User table; bulleted pain points.

## Senior Review Checklist
- [ ] No solutions suggested?
- [ ] Root cause reaches systemic level?
- [ ] Pain points are verifiable behaviors?
- [ ] Consequences are quantified?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Condensed format. |
| 1.0.0 | 2026-03-20 | Initial release. |

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start]) --> B[Problem Synthesis]
    B --> C[User/Workaround Mapping]
    C --> D[Pain Point Extraction]
    D --> E[5-Why Root Cause]
    E --> F[Impact Quantification]
    F --> G([Output Problem Doc])
```
