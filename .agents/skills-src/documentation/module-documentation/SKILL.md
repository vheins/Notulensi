---
name: module-documentation
description: >
  Generate comprehensive documentation for a code module/package covering purpose, public interface, dependencies, usage examples, limitations, and deprecations.
  Do NOT use for full API reference docs, project-level READMEs, or architecture documentation.
version: "1.1.0"
time_saved: "Manual: 2-3 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~5000
tags: [module-documentation, public-interface, dependencies, exports, package-docs]
author: vheins
---

# Agent Optimized: Module Documentation

## Directives
- **Content Sections**:
    1. **Overview**: Purpose, architectural role, and problem solved.
    2. **Data Model**: Mermaid ERD for owned/used entities.
    3. **Business Logic**: Structured pseudocode for complex operations.
    4. **Sequence Diagram**: Mermaid for multi-actor/component flows.
    5. **Public Interface**: Document every exported symbol (Signature, Return, Params Table, Throws).
    6. **Dependencies**: Table of internal/external deps and their roles.
    7. **Limitations**: Constraints, edge cases, and workarounds.
- **Source Analysis**: Extract symbols and types directly from `{{module_code}}`.
- **Interface Grouping**: Use `### Functions`, `### Classes`, `### Types/Interfaces`.
- **Pseudocode Rule**: Use pseudocode only for logic; NO verbatim code snippets.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B{Purpose Provided?}
    B -- No --> C[Infer purpose from code]
    B -- Yes --> D[Use provided purpose]
    C & D --> E[Parse Exports from module_code]
    E --> F[Generate Mermaid ERD & Sequence]
    F --> G[Draft Logic Pseudocode]
    G --> H[Document Public Interface Symbols]
    H --> I[List Dependencies & Roles]
    I --> J[Identify Limitations/Constraints]
    J --> K([Final Module Documentation])
```

## Constraints
| Rule | Description |
|------|-------------|
| Precision | Signature/Return types must match source code exactly. |
| Deprecation | Mark deprecated symbols; list specific replacements. |
| Initialization | Flag circular dependencies as risk factors. |
| Tone | Concise, technical, and consumer-focused. |

## Review Criteria
- [ ] Every exported symbol is documented.
- [ ] Parameter tables include validation rules/constraints.
- [ ] External dependencies are explicitly listed.
- [ ] Mermaid diagrams reflect current architectural logic.

## Metadata
- **Output Path**: `.agents/documents/application/modules/{module-slug}/`
- **Changelog**: 1.2.0 (Added Diagrams/Pseudocode); 1.1.0 (Added metadata); 1.0.0 (Initial).
