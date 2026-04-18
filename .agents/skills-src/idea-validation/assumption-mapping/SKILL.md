---
name: assumption-mapping
description: >
  Identify and categorize key product assumptions by risk level and generate specific validation experiments.
  Do NOT use for hypothesis validation experiments, market sizing, or feasibility assessment.
version: "1.1.0"
time_saved: "Manual: 4–6 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: idea-validation
complexity: Intermediate
tokens: ~4000
tags: [assumption-mapping, lean-startup, risk-assessment, validation, idea-validation]
author: vheins
---

# Skill: Assumption Mapping

## Purpose
Surfaces and categorizes product assumptions by risk level and provides specific, low-cost validation experiments.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{product_idea}}` | string | yes | Brief product description |
| `{{business_model}}` | string | yes | Monetization strategy |
| `{{target_user}}` | string | yes | Primary user group |

## Prompt
- **User Assumptions**: 3–5 falsifiable assumptions about behavior/needs (Assumption, Risk, Experiment).
- **Market Assumptions**: 3–5 assumptions about size, competition, and timing.
- **Technical Assumptions**: 2–4 assumptions about feasibility and integrations.
- **Business Assumptions**: 3–5 assumptions about pricing and economics.
- **Priority Matrix**: Table of top 5 highest-risk assumptions (Priority, Category, Risk, Rationale, Method).

**Rules**:
- Risk Levels: High (fails product), Medium (needs changes), Low (minor adjustments).
- Matrix sorting: (1) Risk level, (2) Ease of validation.

## Examples
- @examples/input.md
- @examples/output.md

## Edge Cases
| Case | Strategy |
|------|----------|
| Already Validated | Mark as "Validated" and focus experiments on remaining gaps. |
| Specialty Domain | Flag assumptions requiring expert consulting (e.g., legal). |
| Undecided Model | Generate assumptions for both subscription and freemium models. |

## Output Format
- Five labeled sections with markdown headers.
- Structured lists for category assumptions.
- Priority markdown table.
- 600–900 words.

## Senior Review Checklist
- [ ] Solution is the simplest that could work?
- [ ] Failure modes handled?
- [ ] Scales to 10x load/codebase?
- [ ] Security implications addressed?
- [ ] Output testable and observable?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start]) --> B{business_model\ndefined?}
    B -- No --> C[Generate for 2 models]
    B -- Yes --> D[Extract 3-5 User Assumptions]
    C --> D
    D --> E[Extract 3-5 Market Assumptions]
    E --> F[Extract 2-4 Tech Assumptions]
    F --> G[Extract 3-5 Business Assumptions]
    G --> H{All falsifiable?}
    H -- No --> I[Rewrite or flag]
    H -- Yes --> J{Already validated?}
    J -- Yes --> K[Mark Validated\nskip experiment]
    J -- No --> L{Risk level?}
    L -- High --> M[Cheapest/fastest experiment]
    L -- Medium --> N[Medium-effort experiment]
    L -- Low --> O[Lightweight experiment]
    K & M & N & O --> P[Build Priority Matrix\nTop 5 by risk & ease]
    P --> Q([Output: Map + Priority Matrix])
```
