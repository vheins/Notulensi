---
name: api-timeout-debugging
description: Diagnoses API timeouts, identifies slow components via tracing, and provides retry/timeout strategies. DO NOT use for network infrastructure, DB query optimization, or general profiling.
version: "1.1.0"
time_saved: "Manual: 1–3 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [api, timeout, retry, tracing, debugging, http]
author: vheins
---

# Skill: API Timeout Debugging

## Purpose
Diagnose API timeouts using trace data to identify slow components and implement remediation strategies (retries, breakers, budget adjustments).

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Axios + Express" |
| `timeout_symptoms` | string | Yes | Endpoint, duration, frequency, user impact |
| `trace_data` | string | No | Distributed trace or span timings |
| `context` | string | Yes | Arch, downstream deps, config, recent changes |

## Instructions
- **Classification**: Determine timeout type (Client, Server, Gateway, Downstream, Connection).
- **Identification**: Pinpoint source (App, DB, API, Internal Service, Queue).
- **Root Cause**: Analyze reasons (Missing indexes, rate limits, resource exhaustion, blocking code).
- **Remediation**:
  - Implement corrected timeout values.
  - Apply exponential backoff with jitter for retries.
  - Add circuit breakers for failing downstream services.
  - Optimize via async/parallel execution.
- **Monitoring**: Define alert rules (P99 latency, error rates) and dashboard metrics.
- **Fallback**: If no trace data, provide OTel setup commands and manual timing strategies.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Trace Data | Activate OTel setup path; provide manual timing templates. |
| Expected Slowness | Recommend transition to async jobs with polling/webhooks. |
| Cascading Timeouts | Identify root service; implement decreasing timeout budgets downstream. |

## Diagnostic Logic
```mermaid
flowchart TD
    A[tech_stack + timeout_symptoms + context] --> B{Trace data available?}
    B -- No --> C[Add OpenTelemetry / manual timestamps]
    C --> D[List timeout config points to check]
    B -- Yes --> E[Classify Timeout Type]
    E --> F[Identify Slow Component]
    F --> G[Root Cause Analysis]
    G --> H[Apply Fix: timeout values + retry + circuit breaker]
    H --> I[Before/After Code]
    D --> J[Output: Diagnostic Path + Recommendations]
    I --> K[Output: 5-Section Report + Monitoring Alerts]
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Slow component identified.
- [ ] Timeout budgets adjusted.
- [ ] Circuit breaker considered.
- [ ] Retries are idempotent.
- [ ] Tracing enabled/recommended.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: examples/ and references/, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
