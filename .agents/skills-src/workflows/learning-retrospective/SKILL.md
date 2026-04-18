---
name: learning-retrospective
description: >
  Extract durable knowledge from recent work in the current repository.
  Identifies mistakes, decisions, and patterns to store in Local Memory MCP.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Orchestrator
complexity: Intermediate
tags: [workflow, retrospective, memory, knowledge-management]
author: vheins
---

# Skill: Learning Retrospective

## Purpose
Extracts and stores durable knowledge in the repository's long-term memory.

## Knowledge Types

| Type | Description | Store As |
|------|-------------|----------|
| **Mistakes** | Bugs, environment quirks, "gotchas". | `mistake` |
| **Decisions** | Trade-offs, library/pattern choices. | `decision` |
| **Patterns** | Repeatable standards, code style. | `pattern` |

## Actions
- `memory-search`: Check existing context.
- `memory-store`: Record findings (Title, Content, Type, Importance, Tags).
- `memory-summarize`: Update repository summary.

## memory-store Rules
- **Title**: Concise (e.g., "Use UUID for IDs").
- **Content**: Objective rule/fact; no narrative.
- **Importance**: 1–5.
- **Tags**: Tech stack tags (e.g., `['typescript']`).

## Mermaid Diagram
```mermaid
flowchart TD
    A([Work Done]) --> B{Mistakes?}
    B -- Yes --> C[Store mistake]
    A --> D{Decisions?}
    D -- Yes --> E[Store decision]
    A --> F{Patterns?}
    F -- Yes --> G[Store pattern]
    C & E & G --> H[memory-summarize]
    H --> I([Memory Synced ✅])
```
