---
name: async-await-error-tracing
description: >
  Debug async/await errors, unhandled promise rejections, and event loop blocking. Do not use for synchronous logic bugs or race conditions in concurrent systems.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [async, await, promise, unhandled-rejection, event-loop, debugging]
author: vheins
---

# Skill: Async/Await Error Tracing

## Purpose
Trace and fix async errors including unhandled rejections, missing awaits, and event loop blocking.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `error_message` | string | Yes | e.g., "UnhandledPromiseRejection" |
| `code` | string | Yes | Async logic section |
| `context` | string | Yes | Op flow and error expectations |

## Instructions
- **Classification**: Identify type (Unhandled rejection, missing await, swallowing, loop blocking, forEach async, race).
- **Trace**: Map execution path from creation to rejection and catch sites.
- **Remediation**:
  - Wrap awaits in `try/catch`.
  - Ensure proper error propagation and re-throwing.
  - Add contextual logging.
- **Config**: Provide settings for better stack traces (e.g., `--async-stack-traces`).
- **Validation**: Write test snippets verifying propagation (e.g., `expect(...).rejects.toThrow()`).
- **Fallback**: If no code, provide execution model descriptions and diagnostic templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| Async in `forEach` | Recommend `Promise.all(array.map(...))` for sequential/parallel handling. |
| Event Loop Block | Recommend worker threads or `setImmediate` for heavy computation. |
| Intermittent Race | Add diagnostic logs around promise settlement points. |

## Tracing Flow
```mermaid
flowchart TD
    A[Parse inputs] --> B{Code available?}
    B -- No --> C[Describe async execution model]
    C --> D[Provide diagnostic template + tracing tools]
    B -- Yes --> E[Classify Async Error Type]
    E --> F[Trace Error Flow]
    F --> G[Apply Fix: try/catch + propagation + logging]
    G --> H[Improve async stack trace config]
    H --> I[Write test verifying error propagation]
    D --> J[Output: Diagnostic Path]
    I --> K[Output: 5-Section Report + Test Snippet]
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Awaits properly handled.
- [ ] Propagation is explicit.
- [ ] Stack traces improved.
- [ ] Fix verified by tests.
- [ ] Event loop protected.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: examples/references separated, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
