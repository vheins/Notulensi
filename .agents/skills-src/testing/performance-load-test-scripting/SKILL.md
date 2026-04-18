---
name: performance-load-test-scripting
description: >
  Generates load test scripts (ramp-up, steady state, spike) to verify system performance.
  Do NOT use for unit tests, functional tests, or stress testing beyond defined thresholds.
version: "1.1.0"
time_saved: "Manual: 4-6h | With skill: 15-20m"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [load-testing, performance-testing, k6, jmeter, locust]
author: vheins
---

# Skill: Performance Load Test Scripting

## Purpose
Generate load test scripts (k6, JMeter, Locust) to measure throughput, latency, and bottlenecks under realistic traffic patterns.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `api_endpoints` | string | Yes | Targets or flows |
| `tech_stack` | string | Yes | e.g., "k6 + Node.js" |
| `performance_targets` | string | Yes | SLA (e.g., "p95 < 500ms") |
| `test_scenarios` | string | No | ramp-up, spike, soak, stress |

## Instructions
- **Patterns**: Simulate Ramp-up, Steady State, Spike, and Soak scenarios.
- **Behavior**: Include realistic think times (1-3s), auth flows, and session management.
- **Thresholds**: Enforce SLA targets for response time (p95), error rates, and RPS.
- **Metrics**: Collect throughput, latency breakdown (DNS, TTFB), and custom metrics.
- **Data**: Parameterize inputs; ensure unique identifiers per user to avoid collisions.
- **Cleanup**: Include teardown logic to purge test-generated data.

## Edge Cases
| Case | Strategy |
|------|----------|
| Auth Overhead | Account for login time in throughput; reuse tokens per session. |
| Isolation | Use unique IDs per virtual user to prevent concurrent update collisions. |
| Warm-up | Exclude first 30-60s of metrics from final SLA verification. |

## Workflow
```mermaid
flowchart TD
    A([Start: Load Test Scripting]) --> B[Parse inputs]
    B --> C{Scenarios specified?}
    C -- Yes --> D[Generate specified]
    C -- No --> E[Generate all: ramp-up, spike, soak, stress]
    D & E --> F[Define Thresholds (p95, error rate, RPS)]
    F --> G[Ramp-Up Scenario]
    F --> H[Spike Scenario]
    F --> I[Soak Scenario]
    G & H & I --> J[Add Realistic Behavior (think time, auth)]
    J --> K{Auth required?}
    K -- Yes --> L[Login once, reuse token]
    K -- No --> M
    L & M --> N[Handle Test Data (parameterize, avoid collisions)]
    N --> O[Collect Metrics (latency breakdown, RPS)]
    O --> P{Warm-up needed?}
    P -- Yes --> Q[Exclude first 30-60s]
    P -- No --> R
    Q & R --> S[Add Assertions]
    S --> T([Output: Load Test Scripts])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Ramp-up/Spike/Soak covered.
- [ ] Thresholds enforced.
- [ ] Think time included.
- [ ] Data conflicts avoided.
- [ ] Custom metrics collected.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
