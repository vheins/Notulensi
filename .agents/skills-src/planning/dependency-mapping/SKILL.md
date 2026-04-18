---
name: dependency-mapping
description: Maps dependencies, identifies circular/risky dependencies, and recommends decoupling. DO NOT use for package management or build configuration.
version: "1.1.0"
time_saved: "Manual: 3–5 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Intermediate
tokens: ~3500
tags: [dependencies, coupling, circular-dependencies, decoupling, architecture, modules]
author: vheins
---

# Skill: Dependency Mapping

## Purpose
Identify module/service dependencies, flag circular or risky patterns, and recommend decoupling strategies.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `module_list` | string | Yes | Modules to map |
| `tech_stack` | string | Yes | Technology stack |
| `context` | string | Yes | Interaction details |

## Instructions
- **Graph**: Provide a text-based `A -> B` map grouped by upstream/downstream layers.
- **Matrix**: Use a markdown table: Module | Depends On | Depended On By | Coupling Type (Direct/Shared/None).
- **Circular Check**: List all cycles, their severity (Critical/High), and the problems caused (e.g., deployment locks).
- **Risk Assessment**: Identify high-risk dependencies based on coupling strength and failure impact.
- **Remediation**: Provide decoupling plans (Event-driven, API gateway, Dependency Injection) for top risks.
- **Vague context**: If interactions are unclear, stop and ask for communication patterns.

## Edge Cases
| Case | Strategy |
|------|----------|
| Large List | Focus exclusively on highest-risk dependencies; recommend `dependency-cruiser` for full maps. |
| Event-driven | Risk focuses on schema coupling; recommend consumer-driven contract testing. |
| No Context | Ask for primary interaction types (REST vs PubSub) before mapping. |

## Workflow
```mermaid
flowchart TD
    A([Start: Dependency Mapping]) --> B{context describes\nactual interactions?}
    B -- Too vague --> C[Ask for primary communication\npatterns between modules]
    C --> B
    B -- Yes --> D{module_list\nhas 10+ modules?}
    D -- Yes --> E[Focus on highest-risk deps\nnote full graph needs dedicated tool\ne.g. dependency-cruiser]
    D -- No --> F[Build Dependency Graph\nA → B notation\ngroup by upstream/downstream]
    E --> F
    F --> G[Build Dependency Matrix\nModule + Depends On + Depended On By\n+ Coupling Type:\nDirect/Indirect/Shared/None]
    G --> H[Identify Circular Dependencies\nfull cycle path\nwhy problematic\nSeverity: Critical/High/Medium]
    H --> I{Circular deps\nfound?}
    I -- Yes --> J[Flag each cycle\ndeployment ordering issues\ntesting difficulty]
    I -- No --> K[State explicitly:\nno circular deps\nexplain why structure avoids them]
    J & K --> L[Risk Assessment per Dependency\nHigh/Medium/Low\nrisk reason + impact if fails]
    L --> M{All services communicate\nvia events only?}
    M -- Yes --> N[Note healthy architecture\nfocus on event schema coupling\nrecommend consumer-driven contract testing]
    M -- No --> O[Decoupling Recommendations\ntop 3 highest-risk deps\ncurrent pattern → recommended pattern\nmigration steps + trade-off]
    N --> P([Output: 4-section dependency map\n500–900 words])
    O --> P
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Dependency graph uses `A -> B` notation.
- [ ] Circular dependencies identified (or absence justified).
- [ ] Risk levels severity-rated.
- [ ] Decoupling strategies provide migration steps.
- [ ] Coupling types defined.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
