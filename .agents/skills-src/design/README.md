# Skills: Design (11 skills)

This category contains skills for UI/UX design and component specification.

## Subdirectory Structure

Each skill in the `design` category has the following structure:

```
{skill-name}/
├── SKILL.md          # Core instructions (≤500 lines)
├── references/       # Supporting technical documentation
│   ├── README.md
│   └── compatibility-matrix.md
├── assets/           # Component/layout specification templates
│   └── template.md
└── examples/         # Concrete input/output examples
    ├── input.md
    └── output.md
```

## Skills

| Skill | Description |
|-------|-------------|
| `component-inventory-generation` | Generate UI component inventories |
| `dashboard-layout-design` | Design dashboard layouts |
| `design-mcp-quickstart` | Quickstart for design with MCP tools |
| `design-system-specification` | Specify design systems |
| `form-design-specification` | Specify form designs |
| `mobile-first-ui-specification` | Specify mobile-first UIs |
| `modal-overlay-design` | Design modals and overlays |
| `navigation-structure-design` | Design navigation structures |
| `responsive-layout-planning` | Plan responsive layouts |
| `screen-wireframe-generation` | Generate screen wireframes |
| `user-flow-diagram-description` | Describe user flow diagrams |

---

## Mermaid Diagram

```mermaid
flowchart TD
    A([Design Task]) --> B{What do you need?}

    B -- Map user journeys --> C[user-flow-diagram-description]
    B -- Design navigation / site map --> D[navigation-structure-design]
    B -- Generate screen wireframes --> E[screen-wireframe-generation]
    B -- Plan responsive layout --> F[responsive-layout-planning]
    B -- Mobile-first spec --> G[mobile-first-ui-specification]
    B -- Dashboard / data-heavy layout --> H[dashboard-layout-design]
    B -- Inventory all components --> I[component-inventory-generation]
    B -- Specify forms --> J[form-design-specification]
    B -- Design modals / overlays --> K[modal-overlay-design]
    B -- Define design system tokens --> L[design-system-specification]
    B -- Quickstart with MCP design tools --> M[design-mcp-quickstart]

    C --> D --> E
    E --> F
    E --> G
    E --> H
    E --> I --> J --> K --> L
```
