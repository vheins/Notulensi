---
name: container-crash-analysis
description: >
  Analyzes crashing, restarting, or OOMKilled Docker/Kubernetes containers. Fixes crash causes.
  Do NOT use for deployment failures, app bugs, or infrastructure.
version: "1.1.0"
time_saved: "Manual: 1-3h | With skill: 15-30m"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [container, docker, kubernetes, pod, oomkilled, crash, debugging]
author: vheins
---

# Skill: Container Crash Analysis

## Purpose
Analyze container/pod failures to identify root causes (OOM, probes, config) and provide targeted fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Docker + Kubernetes" |
| `container_logs` | string | Yes | Logs, symptoms, or exit codes |
| `pod_description` | string | No | `kubectl describe pod` output |
| `context` | string | Yes | Limits, changes, crash frequency |

## Instructions
- **Classification**: Identify type (OOMKilled/137, App Crash/1, Startup, Liveness, CrashLoop, Segfault/139).
- **Analysis**: Pinpoint memory-consuming process, exception trace, or missing config.
- **Remediation**: Provide corrected manifests/configs; adjust probe timings.
- **Tuning**: Right-size resources (Requests = 50-70% of limits) using `top pod` or VPA.
- **Monitoring**: Setup alerts for restarts (>3/10m), OOM, and CrashLoop states.
- **Fallback**: If no logs, provide retrieval commands and crash-type checklist.

## Edge Cases
| Case | Strategy |
|------|----------|
| Intermittent | Recommend persistent monitoring for leaks; check graceful shutdown. |
| Init Containers | Use `kubectl logs -c` for init; diagnose as a separate block. |
| High Load OOM | Recommend Vertical Pod Autoscaler (VPA) or horizontal scaling. |

## Diagnostic Workflow
```mermaid
flowchart TD
    A([Start: Container Crash Analysis]) --> B[Parse inputs]
    B --> C{Logs available?}
    C -- No --> D[Provide retrieval commands]
    D --> E[Describe crash types]
    C -- Yes --> F[Identify Crash Type]
    F --> G{Type?}
    G -- OOMKilled 137 --> H[Identify memory-consuming process]
    G -- App crash 1 --> I[Find exception/panic + stack trace]
    G -- Startup failure --> J[Check config/port/dependency]
    G -- Liveness failure --> K[Check endpoint/port/startup]
    G -- CrashLoopBackOff --> L[Identify repeating crash]
    G -- Segfault 139 --> M[Analyze core dump]
    H --> N[Increase limit/fix leak]
    I --> O[Fix exception/handling]
    J --> P[Add config/port/init container]
    K --> Q[Adjust timing/endpoint/startupProbe]
    L --> R[Fix root cause]
    M --> S[Check native deps]
    N & O & P & Q & R & S --> T[Show corrected config]
    T --> U{Resource crash?}
    U -- Yes --> V[Right-size:\nkubectl top\nRequests=50-70%\nVPA]
    U -- No --> W
    V --> W[Setup alerts:
Restarts>3/10m
OOMKilled
CrashLoopBackOff]
    W --> X([Output: 5 Sections + Config + Monitoring])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Exit code interpreted correctly.
- [ ] Resource limits right-sized.
- [ ] Non-root fix provided.
- [ ] Probes adjusted.
- [ ] Manifest is syntactically correct.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
