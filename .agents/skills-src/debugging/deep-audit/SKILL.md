---
name: deep-audit
description: >
  Audits modules for architectural violations (layer separation, N+1 queries, inline logic, coding standards). Use before refactors or when code feels messy. Do NOT use for general bug fixes or new features.
version: "1.1.0"
time_saved: "30-60 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~3000
tags: [audit, architecture, layer-separation, refactoring, code-quality, n+1]
author: vheins
---

# Skill: Deep Audit

## Purpose
Systematically audit modules for architectural debt, N+1 issues, and coding standard violations before refactoring.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `module_name` | string | Yes | e.g., `OrderManagement` |
| `module_path` | string | Yes | Directory/File targets |
| `tech_stack` | string | Yes | Target technology stack |

## Instructions
- **Layer Check**: Flag violations of 5-layer principle (Controllers delegate; Services handle logic).
- **Logic Extraction**: Identify complex closures or queries in UI/Controller layers for extraction.
- **N+1 Detection**: Scan loops for repeated database or service calls missing eager-loading.
- **Compliance**: Verify Services/Handlers are `static`; check Slug-case Enums, i18n, and constants.
- **Reporting**: Categorize results into Architectural (Critical), Performance (Major), and Standard (Minor).
- **Summary**: Provide health score (0-10) and total violation counts.

## Edge Cases
| Case | Strategy |
|------|----------|
| Vendor Code | Skip; flag as out of scope. |
| No Tests | Flag violations; forbid refactor recommendations until tests are added. |
| Ambiguous Ownership | Provide trade-off analysis; recommend conservative placement. |

## Audit Workflow
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C[Scan files]
    C --> D{Generated/vendor?}
    D -- Yes --> E[Skip]
    D -- No --> F[Run Checklist]
    F --> G[1. Layer Separation]
    F --> H[2. Inline Logic]
    F --> I[3. N+1 Detection]
    F --> J[4. Static Compliance]
    F --> K[5. Coding Standards]
    G & H & I & J & K --> L[Categorize findings]
    L --> M{Severity?}
    M -- Critical --> N[Architectural Violation]
    M -- Major --> O[Performance Issue]
    M -- Minor --> P[Coding Standard Violation]
    N & O & P --> Q{Tests exist?}
    Q -- No --> R[Do NOT recommend refactor]
    Q -- Yes --> S[Write Summary]
    R --> S
    S --> T([Output: Report + Score])
```

## Quality Gate
- [ ] Violations severity-rated.
- [ ] Health score justified.
- [ ] Layer separation verified.
- [ ] N+1 fixes concrete.
- [ ] Audit scoped correctly.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
