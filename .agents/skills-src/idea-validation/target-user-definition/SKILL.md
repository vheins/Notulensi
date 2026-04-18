---
name: target-user-definition
description: >
  Define a concrete user persona including demographics, goals, frustrations, and behaviors.
  Do NOT use for market sizing, competitor analysis, or feature prioritization.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: idea-validation
complexity: Beginner
tokens: ~2500
tags: [user-persona, target-user, ux-research, idea-validation]
author: vheins
---

# Skill: Target User Definition

## Purpose
Generates actionable user personas to guide design and prioritization.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{product_idea}}` | string | yes | Brief product description |
| `{{user_segment}}` | string | yes | Specific target user group |

## Prompt
- **Persona Table**: Name, Role, and demographic summary.
- **Goals**: ≥3 concrete actionable work/life and product-specific goals.
- **Frustrations**: ≥3 specific frustrations and their consequences.
- **Behavioral Patterns**: Regular tools, discovery methods, and adoption context.
- **Tech Savviness**: Rating (Novice–Expert) with UX implications.
- **Quote**: One first-person sentence capturing core intent.

## Rules
- Ground traits in real-world behaviors.
- Generate exactly one persona.
- No filler text.

## Edge Cases
| Case | Strategy |
|------|----------|
| Broad segment | Ask developer to narrow scope first. |
| Niche segment | State assumptions; recommend real-user validation. |

## Output Format
- Five sections (`##`).
- Table for profile; bullet lists for goals/pains.

## Senior Review Checklist
- [ ] Persona is specific and non-generic?
- [ ] Goals align with product value?
- [ ] Tech savviness matches UX assumptions?
- [ ] Frustrations justify the product's existence?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Condensed format. |
| 1.0.0 | 2026-03-20 | Initial release. |

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start]) --> B[Segment Analysis]
    B --> C[Profile Generation]
    C --> D[Goal & Pain Identification]
    D --> E[Behavioral Mapping]
    E --> F[Tech Rating]
    F --> G([Output User Persona])
```
