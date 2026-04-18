---
name: requirements-planning
description: >
  Use to transform validated ideas into structured requirements: user stories, acceptance criteria, task backlog, and risk register. Do NOT use for technical planning or implementation.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Pipeline
complexity: Intermediate
tags: [workflow, requirements-planning]
author: vheins
---

# Skill: Requirements Planning Pipeline

## Purpose
Transforms validated ideas into structured requirements packages.

## Operations

### 🔴 GATE 0 (ask_user)
- **Question**: "Start Requirements Planning Pipeline (Stakeholder Reqs, Stories, AC, Backlog)?"

### Step Mapping

| Step | Skill | Output |
|------|-------|--------|
| 1 | `stakeholder-requirement-extraction` | Requirements List |
| 2 | `user-story-generation` | User Story Set |
| 3 | `acceptance-criteria-writing` | EARS Criteria |
| 4 | `brainstorm-feature` | Technical Design Notes |
| 5 | `edge-case-identification` | Edge Case List |
| 6 | `feature-decomposition` | Task Backlog |
| 7 | `risk-assessment` | Risk Register |
| 8 | `cost-estimation` | Cost Estimate |
| 9 | `feature-prioritization` | Ranked Backlog |

## 🔴 GATES
- **Gate 1**: Approve Requirements & Technical Design Highlights.
- **Gate 2**: Approve Final Backlog & Risk Register.

## Artifact Paths
- **Stories**: `.agents/documents/requirements/user-stories/`
- **Criteria**: `.agents/documents/requirements/acceptance-criteria/`
- **Backlog**: `.agents/documents/tasks/backlog/`

## Mermaid Diagram
```mermaid
flowchart TD
    A([Concept]) --> B[1. Extraction]
    B --> C[2-3. Stories & AC]
    C --> D[4. Tech Design]
    D --> G1{🔴 G1}
    G1 -- Yes --> E[5-6. Edge Cases & Tasks]
    E --> F[7-8. Risk & Cost]
    F --> H[9. Prioritization]
    H --> G2{🔴 G2}
    G2 -- Yes --> I([Requirements Package ✅])
```
