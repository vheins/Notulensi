---
name: memory-leak-detection
description: >
  Identify and fix memory leak patterns using profiling data and code analysis.
  Do NOT use for one-time high memory usage, OOM from large data processing, or general performance optimization.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [memory-leak, heap, profiling, garbage-collection, debugging]
author: vheins
---

# Skill: Memory Leak Detection

## Purpose
Identify memory leak patterns (event listeners, unclosed resources, growing caches), pinpoint sources via profiling, and provide fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `code` | string | Yes | Suspected module or lifecycle description |
| `symptoms` | string | Yes | Memory growth rate, crash frequency |
| `profiling_data` | string | No | Heap snapshot, profiler output |

## Instructions
- **Identification**: Categorize pattern (Accumulation, closure captures, timer leaks, goroutine leaks).
- **Source**: Pinpoint exact location (file/line) and explain retention chain (prevented GC).
- **Remediation**: Provide minimal fix with before/after comparison to break retention chain.
- **Profiling**: Provide commands to capture baseline vs load snapshots (e.g., `jmap`, `tracemalloc`).
- **Prevention**: Describe patterns to prevent the leak class (e.g., `try-with-resources`, `WeakMap`).
- **Fallback**: If no profiling, identify top 3 patterns for stack and provide capture instructions.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Profiling | Identify likely patterns; provide step-by-step capture instructions. |
| Third-party | Document issue, provide workaround (e.g., pooling), recommend upstream bug. |
| Intermittent | Identify trigger; recommend load test for reliable reproduction. |

## Workflow
```mermaid
flowchart TD
    A([Start: Memory Leak Detection]) --> B[Parse inputs]
    B --> C{Profiling data
available?}
    C -- No --> D[Identify likely patterns]
    D --> E[Provide capture commands]
    E --> F[Describe analysis targets]
    C -- Yes --> G[Identify Leak Pattern]
    G --> H{Runtime?}
    H -- JS/Node.js --> I[Event listeners, closures, globals, timers]
    H -- Java/JVM --> J[Static collections, classloaders, ThreadLocal, listeners]
    H -- Python --> K[Circular refs, global caches, unclosed generators]
    H -- Go --> L[Goroutines, channels, slice headers]
    I & J & K & L --> M[Pinpoint leak source & explain retention chain]
    M --> N{Leak in 3rd-party?}
    N -- Yes --> O[Document issue, workaround, file bug]
    N -- No --> P[Provide minimal code fix]
    O --> P
    P --> Q{Intermittent leak?}
    Q -- Yes --> R[Identify trigger, recommend load test]
    Q -- No --> S[Profiling Guidance]
    R --> S
    S --> T[Add Prevention Pattern]
    T --> U([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Retention chain explained.
- [ ] Fix is minimal.
- [ ] Profiling commands provided.
- [ ] Prevention pattern included.
- [ ] Stack-specific patterns used.

## MCP Dependencies
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
