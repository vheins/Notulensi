---
name: observability-monitoring-test
description: >
  Generates tests verifying metrics, logs, and traces are correctly emitted to validate observability setup. Do NOT use for functional or performance tests.
version: "1.1.0"
time_saved: "Manual: 1-2 hours | With skill: 15-20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [observability, monitoring, metrics, logging, tracing, opentelemetry]
author: vheins
---

# Skill: Observability Monitoring Test

## Purpose
Verify that metrics, logs, and traces are correctly emitted and propagated to validate instrumentation setup.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `observability_setup` | string | Yes | Stack and scope |
| `tech_stack` | string | Yes | e.g., "Node.js + OpenTelemetry" |
| `instrumentation_code`| string | No | Current logic |

## Instructions
- **Metrics**: Verify counters increment, histograms record values, and labels are correct.
- **Logging**: Validate structured JSON format, levels, and exclusion of sensitive data (PII/tokens).
- **Tracing**: Confirm spans are created for key ops and context propagates across service boundaries.
- **Alerting**: Test that rules fire on thresholds and are actionable.
- **Async/Jobs**: Verify spans close properly and trace IDs persist in background jobs.
- **Gaps**: Document instrumentation missing from third-party libraries.

## Edge Cases
| Case | Strategy |
|------|----------|
| Async | Ensure context managers are used to verify spans close on completion. |
| Background | Verify trace propagation from parent context into worker/queue spans. |
| 3rd-party | Document gaps if libraries lack native OTel support. |

## Workflow
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C[Identify signals: metrics, logs, traces]
    C --> D[Metrics Tests]
    C --> E[Logging Tests]
    C --> F[Tracing Tests]
    D --> G{PII in labels?}
    G -- Yes --> H[Flag]
    G -- No --> I
    E --> J{Sensitive data?}
    J -- Yes --> K[Flag]
    J -- No --> L
    H & I & J & K & L --> M[Trace context propagation]
    F --> M
    M --> N{Background jobs?}
    N -- Yes --> O[Verify context]
    N -- No --> P
    O & P --> Q[Alert Tests]
    Q --> R{Third-party libs?}
    R -- Yes --> S[Document gaps]
    R -- No --> T
    S & T --> U([Output: Test File])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Spans verified for critical operations.
- [ ] Required span attributes present.
- [ ] Logs validated as structured JSON.
- [ ] PII absence confirmed.
- [ ] Cross-boundary context propagation tested.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
