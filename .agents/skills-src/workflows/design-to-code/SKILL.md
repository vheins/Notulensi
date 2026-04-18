---
name: design-to-code
description: >
  Translates approved UI/UX designs into implementation. Covers design handoff, component mapping, and coding.
  Do NOT use if designs are not approved.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Orchestrator
complexity: Advanced
tags: [workflow, design-to-code]
author: vheins
---

# Skill: Design to Code Orchestrator

## Purpose
Chains `design-pipeline` and `coding-pipeline` to implement UI requirements.

## Pipeline Sequence

| Phase | Pipeline | Artifacts |
|-------|----------|-----------|
| 1 | `design-pipeline` | Flows, Wireframes, Inventory, Tokens |
| 2 | `coding-pipeline` | Components, Logic, Review, Refactor |

## 🔴 GATES
- **Gate 1**: Present design artifacts. Ask: "Design approved. Proceed to coding?"
- **Gate 2**: Present implemented modules. Ask: "Implementation complete. Proceed to testing?"

## Context Rule
Pass accumulated context (input + `@paths`) to each pipeline.

## Mermaid Diagram
```mermaid
flowchart TD
    A([UI/UX Reqs]) --> B[design-pipeline]
    B --> G1{🔴 Gate 1}
    G1 -- Yes --> C[coding-pipeline]
    C --> G2{🔴 Gate 2}
    G2 -- Yes --> D([→ testing-pipeline ✅])
```
