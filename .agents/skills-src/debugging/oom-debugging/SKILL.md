---
name: oom-debugging
description: >
  Analyze heap dumps or memory metrics to identify and fix out-of-memory errors.
  Do NOT use for container OOMKilled events, active memory leak detection, or performance optimization.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [oom, out-of-memory, heap-dump, memory, debugging]
author: vheins
---

# Skill: OOM Debugging

## Purpose
Debug out-of-memory errors via heap dumps and metrics to identify hogs and provide fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js", "Java" |
| `error_message` | string | Yes | OOM message |
| `heap_dump` | string | No | Top retained objects/metrics |
| `code` | string | No | Suspected section or operation |

## Instructions
- **Classification**: Identify OOM type (Heap, Stack/Recursion, Native/Metaspace, Process/Container).
- **Hog Identification**: Find object type, allocation site, and retention chain from heap dump.
- **Remediation**:
  - Reduce object size/efficient structs.
  - Limit collection size (bound caches/queues).
  - Stream/Chunk processing.
  - Break reference chains.
- **Configuration**: Provide stack-specific heap flags (e.g., `-Xmx4g`, `--max-old-space-size`).
- **Monitoring**: Recommend thresholds (>80%), periodic snapshots, and GC pause tracking.
- **Fallback**: If no heap dump, identify likely cause and provide capture commands (`jmap`, `SIGUSR2`).

## Edge Cases
| Case | Strategy |
|------|----------|
| No Heap Dump | Activate fallback; provide capture commands and reproduction script. |
| Startup OOM | Check static initializers, classpath scanning, or large config loading. |
| Load-only OOM | Investigate per-request alloc; recommend load test with heap monitoring. |

## Workflow
```mermaid
flowchart TD
    A([Start: OOM Debugging]) --> B[Parse tech_stack, error_message, heap_dump, code]
    B --> C{Heap dump
available?}
    C -- No --> D[Provide capture commands]
    D --> E[Describe analysis targets]
    E --> F[Provide reproduction script]
    C -- Yes --> G[Classify OOM Type]
    G --> H{OOM type?}
    H -- Heap --> I[App objects exceed heap]
    H -- Stack --> J[Deep recursion]
    H -- Native --> K[Direct buffers/metaspace]
    H -- Process --> L[OS/container limit]
    I & J & K & L --> M{OOM on startup?}
    M -- Yes --> N[Check static init/classpath]
    M -- No --> O{OOM under load?}
    N --> O
    O -- Yes --> P[Investigate per-request alloc]
    O -- No --> Q[Identify Memory Hog: Object type, Allocation site, Retention chain]
    P --> Q
    Q --> R{Fix strategy?}
    R -- Reduce size --> S[Use efficient structs]
    R -- Limit collection --> T[Bound caches/queues]
    R -- Stream --> U[Process chunks]
    R -- Fix retention --> V[Break ref chain]
    S & T & U & V --> W[Show before/after code]
    W --> X[Configure heap size]
    X --> Y[Setup monitoring]
    Y --> Z([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] OOM type classified.
- [ ] Hog identified via retention chain.
- [ ] Fix provided with before/after.
- [ ] Heap flags provided.
- [ ] Alerting strategy included.

## MCP Dependencies
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
