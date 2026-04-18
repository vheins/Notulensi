---
name: performance-optimization
description: >
  Use when a developer has identified a performance issue in existing code and needs bottleneck
  analysis, optimized implementation, and benchmarks. Activate for slow
  code, high CPU/memory usage, or latency problems in a specific module.
  Do NOT use for database query optimization (use database-query-optimization skill), caching design,
  or infrastructure scaling.
version: "1.1.0"
time_saved: "Manual: 3–6 hours (profiling + analysis + optimization + benchmarking) | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [performance, optimization, benchmarking, profiling, bottleneck]
author: vheins
---

# Skill: Performance Optimization

## Purpose
Identify bottlenecks, implement targeted algorithmic/memory fixes, and verify improvements via benchmarks.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + TypeScript" |
| `code` | string | Yes | Target logic (hot path) |
| `performance_issue` | string | Yes | Symptoms, measurements, or profiler logs |

## Instructions
- **Analysis**: Identify root causes (Algorithmic complexity, memory allocation, I/O blocking, lock contention). Provide current Big-O.
- **Implementation**: Rewrite with fixes. Preserve behavior. Use stack-idiomatic high-performance patterns.
- **Complexity**: Contrast Optimized vs. Original Time/Space complexity in a table.
- **Benchmarking**: Provide code using standard tools (Benchmark.js, Go testing.B, etc.). Test with realistic data sizes.
- **Future Ops**: List deferred optimizations with rationale and triggers for implementation.

## Edge Cases
| Case | Strategy |
|------|----------|
| Profiler available | Base analysis on hottest flame graph paths; avoid guesswork. |
| Premature Opt Risk | Flag risk; recommend profiling before implementing complex fixes. |
| Memory vs CPU | Present both optimized versions; provide a decision matrix. |

## Optimization Flow
```mermaid
flowchart TD
    A([Start: Performance Optimization]) --> B{Profiler output available?}
    B -- Yes --> C[Focus on hottest paths from flame graph / pprof / py-spy]
    B -- No --> D[Analyze code manually for common bottlenecks]
    C & D --> E{Is this actually a hot path?}
    E -- No --> F[Flag: recommend profiling first, avoid premature optimization]
    E -- Yes --> G[Identify bottleneck type]
    G --> H{Bottleneck type?}
    H -- Algorithmic: O n² or worse --> I[Replace with better algorithm: hash map, binary search, etc.]
    H -- Memory allocation in loop --> J[Pre-allocate, reuse buffers, avoid GC pressure]
    H -- Blocking I/O in async context --> K[Convert to async / non-blocking pattern]
    H -- N+1 queries --> L[Batch queries, use DataLoader or JOIN]
    H -- Lock contention --> M[Reduce critical section, use lock-free structures]
    H -- Redundant computation --> N[Memoize or cache computed values]
    I & J & K & L & M & N --> O{Memory vs CPU trade-off?}
    O -- Yes --> P[Present both versions, let developer choose]
    O -- No --> Q[Apply single optimized version]
    P & Q --> R[Add inline comments explaining each optimization]
    R --> S[Write benchmark: before vs after with realistic data sizes]
    S --> T[Measure: time complexity + space complexity comparison]
    T --> U[List further opportunities deferred with rationale]
    U --> V([Output: Optimized code + benchmarks + complexity analysis])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is behavior preserved 100%?
2. Is the bottleneck empirically identified?
3. Is the benchmark realistic?
4. Is Time/Space complexity improved?
5. is the code still maintainable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
