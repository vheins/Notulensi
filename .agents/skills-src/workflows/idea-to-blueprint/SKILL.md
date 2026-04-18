---
name: idea-to-blueprint
description: >
  Use to transform a raw product idea into a complete blueprint (validation, requirements, technical plan, docs). Do NOT use if a blueprint exists.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Orchestrator
complexity: Advanced
tags: [workflow, idea-to-blueprint]
author: vheins
---

# Skill: Idea to Blueprint Orchestrator

## Purpose
Transforms raw product ideas into implementation-ready blueprints.

## Pipeline Sequence

| Phase | Pipeline | Core Output |
|-------|----------|-------------|
| 1 | `idea-validation` | Feasibility & Scoped Features |
| 2 | `requirements-planning` | User Stories & AC |
| 3 | `technical-planning` | Arch, DB, API, Sprints |
| 4 | `planning-documentation` | BRD, PRD, FSD, TDD, Module Docs |

## 🔴 GATES
Wait for explicit confirmation between phases.
- **Gate 1**: Idea validated?
- **Gate 2**: Requirements approved?
- **Gate 3**: Technical blueprint approved?
- **Gate 4**: Blueprint complete (Docs + Handoff ready)?

## Mandatory Mandates
- **Reference Examples**: Use `@.agents/documents/_examples/` for all documentation structure.
- **Module Coverage**: Phase 4 is incomplete without ALL 4 module documents (Overview, Feature, API, Test).

## Mermaid Diagram
```mermaid
flowchart TD
    A([Idea]) --> B[1. idea-validation]
    B --> G1{G1}
    G1 -- Yes --> C[2. requirements-planning]
    C --> G2{G2}
    G2 -- Yes --> D[3. technical-planning]
    D --> G3{G3}
    G3 -- Yes --> E[4. planning-documentation]
    E --> G4{🔴 Gate Final}
    G4 -- Yes --> F([Blueprint Ready ✅])
```
