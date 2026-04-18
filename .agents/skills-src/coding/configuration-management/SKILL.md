---
name: configuration-management
description: >
  Use to design and implement a configuration management system with
  environment separation, secrets handling, and startup validation. Activate when the request
  involves managing app config across dev/staging/production environments.
  Do NOT use for environment setup scripts, CI/CD configuration, or infrastructure secrets management.
version: "1.1.0"
time_saved: "Manual: 2–3 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [configuration, environment, secrets, validation, twelve-factor]
author: vheins
---

# Skill: Configuration Management

## Purpose
Implement a fail-fast configuration system that separates secrets, validates environments, and adheres to twelve-factor app principles.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + TypeScript" |
| `config_requirements` | string | Yes | List of DB URLs, API keys, flags, etc. |
| `environments` | string | Yes | e.g., "dev, staging, production" |

## Instructions
- **Schema**: Define Name, Type, Req/Opt, Default, Scope, and Secret status.
- **Implementation**: Create a type-safe config module. Avoid raw environment access; use a central object.
- **Environment Separation**: Document `.env.example`. Use non-committed `.env.{env}` files; show CI/CD override patterns.
- **Secrets**: Redact secrets from logs/dumps. Recommend production integrations (Vault, AWS SM).
- **Validation**: Implement startup checks for existence and format (URL, Port, Enum). Exit with a comprehensive list of all failures.

## Edge Cases
| Case | Strategy |
|------|----------|
| Homogeneous environments | Use base config with environment-specific overrides. |
| CI/CD Secrets | Inject as ENV variables; avoid file storage. |
| Dynamic Config | Separate static startup config from runtime/feature flag services. |

## Implementation Logic
```mermaid
flowchart TD
    A([Start: tech_stack + config_requirements + environments]) --> B[Define Configuration Schema]
    B --> C{Dynamic config?}
    C -- Yes --> D[Separate static vs dynamic config]
    C -- No --> E
    D & E --> F[Implement Config Module\nType-safe + Twelve-factor]
    F --> G[Startup Validation\nFail-fast on missing/invalid]
    G --> H{Any failures?}
    H -- Yes --> I[Exit with ALL error details]
    H -- No --> J[Environment Separation\n.env.example + .env.{env}]
    I --> J
    J --> K{Include CI?}
    K -- Yes --> L[Inject secrets as ENV vars]
    K -- No --> M
    L & M --> N[Secrets Handling\nRedaction + Prod recommendation]
    N --> O{Stack commonality?}
    O -- High --> P[Base config + Overrides]
    O -- Low --> Q[Separate config per env]
    P & Q --> R([Output: Config Schema + Module\n+ .env.example + Validation + Secrets])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution type-safe?
2. Does it fail fast on startup?
3. Are secrets protected (logs/API)?
4. Is it twelve-factor compliant?
5. Is the output production-ready?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
