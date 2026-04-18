---
name: caching-strategy-implementation
description: >
  Use to design and implement a caching layer for data that is expensive
  to compute or fetch. Activate for cache-aside, write-through, or
  write-behind patterns, TTL strategy, and cache invalidation logic.
  Do NOT use for database query optimization, CDN configuration, or HTTP response caching headers.
version: "1.1.0"
time_saved: "Manual: 3–5 hours | With skill: 20–35 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [caching, redis, cache-aside, invalidation, ttl, performance]
author: vheins
---

# Skill: Caching Strategy Implementation

## Purpose
Implement a caching layer (cache-aside, write-through, etc.) to optimize data access while maintaining consistency.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | App stack + cache tech (e.g., "Node.js + Redis") |
| `data_description` | string | Yes | Data source, access patterns, consistency requirements |
| `cache_requirements` | string | Yes | TTL, invalidation triggers, size limits, consistency level |

## Instructions
- **Pattern Selection**: Select and justify a pattern (Cache-aside, Write-through, Write-behind, Read-through) based on access patterns.
- **Key Design**: Define a namespaced, collision-resistant key schema (include tenant/user scope).
- **Implementation**: Code the read/write logic with TTL, invalidation (key/pattern/tag), and stampede prevention (mutex/locks). Ensure graceful degradation if the cache is down.
- **Invalidation**: Define TTL rationale and event-driven invalidation triggers.
- **Monitoring**: Add hit/miss metrics and operational logging.

## Edge Cases
| Case | Strategy |
|------|----------|
| Multi-instance | Use Redis pub/sub or tags to broadcast invalidation. |
| Large objects | Apply compression (gzip/msgpack) or split entries. |
| Cold starts | Implement cache warming for hot keys on startup. |

## Logical Flow
```mermaid
flowchart TD
    A([Start: data_description + cache_requirements]) --> B{Access pattern?}
    B -- Read-heavy, eventual OK --> C[Cache-Aside
lazy load on miss]
    B -- Write-heavy, strong consistency --> D[Write-Through
write cache + source together]
    B -- Write-heavy, eventual OK --> E[Write-Behind
write cache → async flush to source]
    B -- Transparent to app --> F[Read-Through
cache handles misses automatically]
    C & D & E & F --> G[Design cache key schema
namespace + tenant scope + collision prevention]
    G --> H[Implement cache read]
    H --> I{Cache hit?}
    I -- Hit --> J[Return cached value]
    I -- Miss --> K{Hot key?
stampede risk?}
    K -- Yes --> L[Acquire mutex/lock
only one fetches from source]
    K -- No --> M[Fetch from source]
    L --> M
    M --> N{Source available?}
    N -- No --> O[Graceful degradation
return stale or error]
    N -- Yes --> P[Populate cache with TTL
return value]
    P --> Q{Invalidation trigger?}
    Q -- TTL expired --> R[Evict on next read]
    Q -- Source data changed --> S[Invalidate by key / pattern / tag
broadcast to all instances if multi-node]
    Q -- Stale-while-revalidate --> T[Serve stale
async refresh in background]
    R & S & T --> U[Emit hit/miss metrics
log cache operations]
    U --> V([Output: Caching layer
Pattern + Keys + Implementation
+ TTL/Invalidation + Metrics])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes (cache down) handled?
3. Does it scale 10x in load/size?
4. Are security implications addressed?
5. Is the output testable and observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|----------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
