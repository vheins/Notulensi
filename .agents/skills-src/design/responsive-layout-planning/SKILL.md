---
name: responsive-layout-planning
description: >
  Plan how screen layouts adapt across breakpoints (mobile/tablet/desktop). Produces a structured reflow spec for CSS Grid/Flexbox or Figma. Not for high-fidelity visual design.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: design
complexity: Intermediate
tokens: ~6500
tags: [responsive, layout, breakpoints, css-grid, flexbox, mobile-first, tailwind, reflow, ux, figma]
author: vheins
---

# Skill: Responsive Layout Planning

## Purpose
Produces structured reflow specifications detailing element adaptation across device breakpoints.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{screen_name}}` | string | yes | Screen/component name |
| `{{current_layout}}` | string | yes | Desktop layout description |
| `{{framework}}` | string | yes | CSS framework/approach |
| `{{breakpoints}}` | string | yes | Target breakpoints |
| `{{priority}}` | string | yes | Layout priority (e.g., "mobile-first") |

## Prompt
- **Breakpoint Summary**: Table (Breakpoint, Width, Primary Shift).
- **ASCII Grids**: Draw ASCII grid per breakpoint showing zones, columns, and `[HIDDEN]` elements.
- **Reflow Spec**: List grid/flex changes, visibility, and spacing for each breakpoint.
- **CSS Hints**: Framework-specific implementation (Tailwind classes, media queries).
- **Navigation Transformation**: Pattern changes (e.g., Menu → Drawer).
- **Accessibility**: Mobile touch target audit (≥44×44px) and focus order implications.

## Rules
- Use WCAG 2.5.5 size targets.
- Normalize breakpoints to match `{{priority}}`.
- No filler text.

## Edge Cases
| Case | Strategy |
|------|----------|
| Nav Overload | If >5 mobile nav items, recommend overflow/drawer. |
| Fixed Pixels | Instruct conversion to fluid/max-width first. |
| custom breakpoints | Generate `theme.extend.screens` config for Tailwind. |

## Output Format
- Six sections (`##`).
- Tables for summary and a11y audit.
- ASCII grids for visual reflow.

## MCP Tools
| Tool | Server | Use Case |
|------|--------|----------|
| Figma | `figma-mcp` | Create responsive frames with auto-layout. |

## Senior Review Checklist
- [ ] Simplest reflow strategy?
- [ ] Mobile-first/Desktop-first consistency?
- [ ] Touch targets ≥ 44px?
- [ ] Navigation patterns are platform-appropriate?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Condensed format. |
| 1.0.0 | 2026-03-20 | Initial release. |

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start]) --> B[Breakpoint Summary Table]
    B --> C[ASCII Grid per Breakpoint]
    C --> D[Grid/Flex Reflow Spec]
    D --> E[CSS/Framework Hints]
    E --> F[Nav Pattern Transformation]
    F --> G[Touch Target & A11y Audit]
    G --> H([Output Reflow Spec])
```
