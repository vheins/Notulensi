---
name: component-inventory-generation
description: >
  Use to produce a structured UI component inventory: name, purpose, props, states, and reusability. Used before implementation. Do NOT use for wireframes or backend architecture.
version: "1.1.0"
time_saved: "Manual: 3–5 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: design
complexity: Intermediate
tokens: ~6000
tags: [component-inventory, ui-components, atomic-design, design-system, figma, react, vue, component-library]
author: kiro
---

# Skill: Component Inventory Generation

## Purpose
Generates a structured UI component inventory for a screen/app to align design and development scope.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{screen_or_app_name}}` | string | yes | Target screen or application |
| `{{component_source}}` | string | yes | Source (Figma, code, description) |
| `{{framework}}` | string | yes | Frontend framework |
| `{{design_system}}` | string | no | Optional existing design system |

## Prompt
- **Summary**: Screen inventoried, total components, and Atomic Design breakdown.
- **Inventory Table**: Table (Component, Type, Purpose, Props, States, Reusability, Source, Notes).
- **Atomic Grouping**: Subsections for Atoms, Molecules, and Organisms with descriptions.
- **Gap Analysis**: Lists of components to "Use from `{{design_system}}`" vs "Build/Extend".

**Rules**:
- Use PascalCase for component names.
- Do not invent components; derive only from inputs.
- If no design system provided, mark all as `custom`.

## Examples
- @examples/input.md
- @examples/output.md

## Edge Cases
| Case | Strategy |
|------|----------|
| No design system | Mark all `custom`; recommend evaluating a design system. |
| Existing code | Flag likely existing components as `reuse`. |
| Simple screen | Use a flat list if Atomic Design is overkill. |
| Ambiguous desc | Ask user for key sections/features before generating. |

## Output Format
- Four sections with markdown headers.
- Markdown table for inventory.
- Indented bullet lists for groupings.
- 400–800 words.

## MCP Tools
| Tool | Server | Use Case |
|------|--------|----------|
| Figma | `figma-mcp` | Extract components/variants/props from Figma files. |
| Storybook | `storybook-mcp` | Scan stories to auto-generate inventory. |

## Senior Review Checklist
- [ ] Solution is the simplest that could work?
- [ ] Failure modes handled?
- [ ] Scales to 10x load/codebase?
- [ ] Security implications addressed?
- [ ] Output testable and observable?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured examples, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start: inputs]) --> B{component_source?}
    B -- Figma --> C[Auto-extract from Figma]
    B -- Codebase --> D[Flag existing components ('reuse')]
    B -- Description --> E[Infer components]
    C & D & E --> F{description clear?}
    F -- No --> G[Ask for details]
    F -- Yes --> H[Classify: atom/molecule/organism]
    G --> H
    H --> I[Build inventory table]
    I --> J{design_system?}
    J -- No --> K[Mark all 'custom']
    J -- Yes --> L[Gap Analysis: DS vs custom]
    K --> M[Group by Atomic level]
    L --> M
    M --> N[Inventory Summary]
    N --> O([Output: Table + Grouping + Gap Analysis + Summary])
```
