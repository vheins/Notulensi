---
name: network-latency-diagnosis
description: >
  Identify network layer bottlenecks causing high latency, slow API calls, or timeouts.
  Do NOT use for database optimization, application profiling, or infrastructure provisioning.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [network, latency, tracing, timeout, debugging, distributed-systems]
author: vheins
---

# Skill: Network Latency Diagnosis

## Purpose
Diagnose network latency via distributed traces to identify bottleneck layers (DNS, TCP, TLS, App) and provide optimizations.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + AWS + Datadog" |
| `latency_symptoms`| string | Yes | p99 latency, affected endpoints |
| `trace_data` | string | No | Distributed trace, waterfall chart |
| `context` | string | Yes | Arch, region, traffic patterns |

## Instructions
- **Breakdown**: Parse trace for time per layer (DNS, TCP, TLS, TTFB, Service, Downstream).
- **Identification**: Classify bottleneck (Infrastructure, App processing, Downstream, Network path).
- **Root Cause**: Explain cause (TTL overload, no keep-alive, handshake overhead, N+1, CDN miss).
- **Remediation**: Provide prioritized fixes for bottlenecks (config, code, infrastructure).
- **Monitoring**: Recommend metrics/alerts for early regression detection.
- **Fallback**: If no trace, provide layer commands (`dig`, `mtr`, `openssl`, `curl -w`) and elimination approach.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Trace | Activate fallback; provide layer-specific diagnostic commands. |
| Intermittent | Recommend spike tracing, checking GC, correlating infra events. |
| Client-side | Investigate browser rendering, last-mile network, JS blocking. |

## Workflow
```mermaid
flowchart TD
    A([Start: Network Latency Diagnosis]) --> B[Parse inputs]
    B --> C{Trace data\navailable?}
    C -- No --> D[Provide tracing setup]
    D --> E[Provide per-layer diagnostic commands]
    E --> F[Systematic elimination approach]
    C -- Yes --> G[Latency Breakdown]
    G --> H[Parse trace: time per layer]
    H --> I{Bottleneck layer?}
    I -- DNS --> J[No caching / high TTL]
    I -- TCP --> K[No keep-alive / high RTT]
    I -- TLS --> L[Full handshake]
    I -- Application --> M[Sync blocking]
    I -- Database --> N[N+1 / connection pool]
    I -- Cross-region --> O[CDN miss]
    J & K & L & M & N & O --> P{Latency intermittent?}
    P -- Yes --> Q[Capture spikes, check GC, correlate infra events]
    P -- No --> R{Client slow, server fast?}
    Q --> R
    R -- Yes --> S[Investigate client-side factors]
    R -- No --> T[Prioritized optimizations with code/config]
    S --> T
    T --> U[Setup monitoring alerts]
    U --> V([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Latency breakdown is quantified.
- [ ] Bottleneck layer pinpointed.
- [ ] Prioritized fixes provided.
- [ ] Monitoring metrics defined.
- [ ] Elimination steps clear.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
