---
name: user-flow-diagram-description
description: >
  Produce a structured user journey description for visual flow diagrams (Excalidraw/draw.io). Not for wireframes or high-fidelity UI.
version: "1.1.0"
time_saved: "Manual: 1-2 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: design
complexity: Intermediate
tokens: ~6000
tags: [user-flow, flow-diagram, ux, excalidraw, draw.io, user-journey, decision-tree]
author: vheins
---

# Skill: User Flow Diagram Description

## Purpose
Generates structured user journey descriptions including nodes, edges, decision points, and error paths.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{flow_name}}` | string | yes | Flow name (e.g., "Checkout") |
| `{{user_goal}}` | string | yes | Target outcome |
| `{{starting_point}}` | string | yes | Starting screen or trigger |
| `{{tech_stack}}` | string | no | Optional tech context |
| `{{include_error_paths}}` | string | no | Include errors ("yes"/"no") |

## Prompt
- **Overview**: Summary of user, goal, and happy path steps.
- **Node List**: Table (ID, Type, Label, Description) for screens/states/decisions.
- **Edge List**: Table (ID, From → To, Trigger, Label) for transitions.
- **Decision Points**: List per decision (Condition, Destinations).
- **Exit Points**: List Success, Abandonment, and Error exits.
- **Error Paths**: (If enabled) ID, Trigger, affected nodes, and recovery.

## Rules
- Use IDs (N1, E1, ERR1) consistently.
- No step invention.
- No filler text.

## Edge Cases
| Case | Strategy |
|------|----------|
| High Complexity | If >10 decisions, recommend splitting into sub-flows. |
| No Errors | Omit Section 6; remove error-related nodes. |
| Platform Limits | Incorporate stack constraints as specific nodes/annotations. |

## Output Format
- Six sections (`##`).
- Tables for nodes and edges.
- Indented lists for decision branches.

## MCP Tools
| Tool | Server | Use Case |
|------|--------|----------|
| Excalidraw | `excalidraw-mcp` | Render hand-drawn style visual flows. |
| draw.io | `drawio-mcp` | Create structured XML flows. |
| Figma | `figma-mcp` | Embed flows into design files. |

## Senior Review Checklist
- [ ] Simplest path to goal?
- [ ] Decisions are mutually exclusive?
- [ ] IDs are consistent across tables?
- [ ] Error recovery paths included?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Condensed format. |
| 1.0.0 | 2026-03-20 | Initial release. |

## Output Path
`.agents/documents/design/flows/{feature-slug}-flow.md`

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start]) --> B[Flow Overview]
    B --> C[Node Table (N1, N2...)]
    C --> D[Edge Table (E1, E2...)]
    D --> E[Decision Branching]
    E --> F[Exit Points]
    F --> G[Error Paths (optional)]
    G --> H([Output Flow Doc])
```
