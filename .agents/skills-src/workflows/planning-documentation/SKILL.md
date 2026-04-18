---
name: planning-documentation
description: >
  Use to produce all pre-implementation documentation: BRD, PRD, FSD, TDD, ADRs, module docs, roadmap, sprint plans. Do NOT use for post-implementation docs.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Pipeline
complexity: Advanced
tags: [workflow, planning-documentation]
author: vheins
---

# Skill: Planning Documentation Pipeline

## Purpose
Produces the complete technical and product blueprint before coding begins.

## Operations

### 🔴 GATE 0 (ask_user)
Must confirm before Step 1.
- **Question**: "Start Planning Documentation Pipeline (BRD, PRD, FSD, TDD, ADRs, Module Docs, Roadmap, Sprints)?"

### Step Mapping

| Step | Output | Path |
|------|--------|------|
| 1 | BRD | `.agents/documents/requirements/brd/` |
| 2 | PRD | `.agents/documents/requirements/prd/` |
| 3 | FSD | `.agents/documents/requirements/fsd/` |
| 4 | TDD | `.agents/documents/requirements/tdd/` |
| 5 | ADRs | `.agents/documents/decisions/` |
| 6 | Module Docs | `.agents/documents/application/modules/` |
| 7 | Roadmap | `.agents/documents/tasks/roadmap/` |
| 8 | Sprints | `.agents/documents/tasks/sprints/` |

## 🔴 INTERNAL GATES
- **Gate 1-4**: Confirm each major doc (BRD, PRD, FSD, TDD).
- **Gate Module**: Validate API covers stories and has test scenarios.
- **Gate Final**: Final blueprint review before handoff to Design/Coding.

## Module Documentation (MANDATORY)
Each module requires:
1. `overview.md`: Responsibility & Architecture.
2. `{feature}.md`: Stories, Flow, Rules, Data Model.
3. `api-{feature}.md`: Endpoints & Validation.
4. `test-{feature}.md`: Scenarios (Pos/Neg/Edge/Security).

## Mermaid Diagram
```mermaid
flowchart TD
    A([Input]) --> B[1. BRD]
    B --> G1{G1}
    G1 --> C[2. PRD]
    C --> G2{G2}
    G2 --> D[3. FSD]
    D --> G3{G3}
    G3 --> E[4. TDD]
    E --> G4{G4}
    G4 --> F[5. ADRs]
    F --> G5{G5}
    G5 --> H[6. Module Docs]
    H --> GM{Gate Module}
    GM --> I[7. Roadmap]
    I --> J[8. Sprints]
    J --> GF{🔴 Gate Final}
    GF -- Yes --> K([Blueprint Ready ✅])
```
