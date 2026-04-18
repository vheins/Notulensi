---
name: implement-feature
description: >
  Use when a blueprint exists and you need to build end-to-end (design, code, test, document). Do NOT use for unvalidated ideas.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Orchestrator
complexity: Advanced
tags: [workflow, implement-feature]
author: vheins
---

# Skill: Implement Feature Orchestrator

## Purpose
End-to-end orchestrator chaining all pipelines from idea to shippable feature.

## Pipeline Sequence

| Phase | Pipeline | Condition |
|-------|----------|-----------|
| 1 | `idea-validation` | New product/feature |
| 2 | `requirements-planning` | Validated concept |
| 3 | `technical-planning` | Requirements done |
| 4 | `planning-documentation`| Blueprint done |
| 5 | `design-pipeline` | If has UI/Frontend |
| 6 | `coding-pipeline` | Docs/Design ready |
| 7 | `testing-pipeline` | Code implemented |
| 8 | `debugging-pipeline` | If tests fail |
| 9 | `release-documentation`| All tests passing |

## 🔴 TOP-LEVEL GATES (MANDATORY)
Wait for explicit confirmation between phases. **NO AUTO-PROCEED.**

## Prohibited Behaviors
- Skipping Phase 5 (Design) for UI apps.
- Answering own gate questions.
- Proceeding without explicit confirmation.

## Mermaid Diagram
```mermaid
flowchart TD
    A([Input]) --> P1[1. Idea Valid]
    P1 --> G1{G1}
    G1 -- Yes --> P2[2. Requirements]
    P2 --> G2{G2}
    G2 -- Yes --> P3[3. Tech Plan]
    P3 --> G3{G3}
    G3 -- Yes --> P4[4. Plan Docs]
    P4 --> G4{🔴 G4: Has UI?}
    G4 -- Yes --> P5[5. Design]
    P5 --> G5{G5}
    G5 -- Yes --> P6[6. Coding]
    G4 -- No --> P6
    P6 --> G6{G6}
    G6 -- Yes --> P7[7. Testing]
    P7 --> G7{🔴 G7: Pass?}
    G7 -- No --> P8[8. Debugging]
    P8 --> P7
    G7 -- Yes --> P9[9. Release Docs]
    P9 --> GF([Shipped ✅])
```
