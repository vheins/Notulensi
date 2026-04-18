---
name: logging-instrumentation
description: >
  Adds structured logging to a module or service, including log levels, context fields, correlation IDs, and PII masking.
  Do NOT use for error handling design, metrics/tracing instrumentation, or log aggregation setup.
version: "1.1.0"
time_saved: "Manual: 2–3 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [logging, observability, structured-logs, correlation-id, pii-masking]
author: vheins
---

# Skill: Logging Instrumentation

## Purpose
Add production-quality structured logging with context, tracing, and data protection to any module.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | Stack + Library (e.g., "Node.js + pino") |
| `module_code` | string | Yes | Source code to instrument |
| `log_requirements` | string | Yes | Events, fields, and masking policies |

## Instructions
- **Setup**: Configure JSON output, `LOG_LEVEL` environment checks, and ISO timestamps. Include service/version/env as default fields.
- **Level Policy**: Use ERROR (unexpected), WARN (degradation), INFO (business events), and DEBUG (tracing). Avoid INFO+ in hot loops.
- **Tracing**: Implement Correlation ID propagation across the call chain (params/context/AsyncLocalStorage).
- **Security**: Mask PII (Passwords, tokens, email mid-parts, credit card partials). Provide the masking utility.
- **Volume**: Recommend log sampling (1 in N) for high-frequency operations.

## Edge Cases
| Case | Strategy |
|------|----------|
| High-frequency loops | Use DEBUG or apply sampling; avoid per-iteration INFO. |
| Async boundaries | Use stack-specific propagation (AsyncLocalStorage/contextvars). |
| 3rd-Party libs | Map external logs to the internal JSON format and Correlation IDs. |

## Instrumentation Flow
```mermaid
flowchart TD
    A([Start: Logging Instrumentation]) --> B[Analyze module code & log requirements]
    B --> C[Configure JSON logger, LOG_LEVEL, ISO timestamps]
    C --> D[Identify significant events]
    D --> E{Event type?}
    E -- Unexpected error --> F[LOG ERROR with full context]
    E -- Recoverable/degradation --> G[LOG WARN]
    E -- Business event --> H[LOG INFO]
    E -- Trace details --> I[LOG DEBUG (disabled in prod)]
    E -- Hot path --> J[Skip or apply log sampling]
    F & G & H & I & J --> K[Inject correlation ID at entry point]
    K --> L{Async context?}
    L -- Node.js --> M[AsyncLocalStorage]
    L -- Python --> N[contextvars]
    L -- Go --> O[context.Context]
    M & N & O --> P[Include correlation ID in all logs]
    P --> Q[Identify sensitive fields]
    Q --> R{Field type?}
    R -- Password/key --> S[Mask: ***]
    R -- Email --> T[Partial mask: j***@example.com]
    R -- Credit card --> U[Last 4: ****1234]
    S & T & U --> V{High volume?}
    V -- Yes --> W[Apply sampling (1 in N)]
    V -- No --> X([Output: Instrumented module code])
    W --> X
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is output structured JSON?
2. Are Correlation IDs propagated?
3. Is PII masked effectively?
4. Are log levels applied correctly?
5. is the performance overhead minimal?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
