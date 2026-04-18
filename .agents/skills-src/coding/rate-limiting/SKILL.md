---
name: rate-limiting
description: >
  Use to implement rate limiting middleware for API endpoints to prevent
  abuse and protect backend resources. Activate for configurable request
  limits, response headers, and bypass rules for trusted clients.
  Do NOT use for authentication, API gateway configuration, or DDoS protection at the infrastructure level.
version: "1.1.0"
time_saved: "Manual: 2–4 hours (algorithm research + implementation + headers + bypass) | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [rate-limiting, middleware, api-protection, redis, sliding-window, token-bucket]
author: vheins
---

# Skill: Rate Limiting

## Purpose
Implement configurable rate limiting middleware with standard headers, multiple algorithms, and bypass rules.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express + Redis" |
| `endpoint_description` | string | Yes | Targets (Public, Auth, Uploads, etc.) |
| `rate_limit_requirements` | string | Yes | Limits per window, keys (IP/UID), bypasses |

## Instructions
- **Algorithm**: Select between Fixed Window, Sliding Window (Log/Counter), or Token Bucket based on burst requirements.
- **Middleware**: Implement atomic check-and-increment in Redis. Return 429 with `Retry-After` on exhaustion.
- **Headers**: Add `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Reset` to all responses.
- **Configuration**: Allow per-endpoint/group overrides and environment-specific strictness.
- **Bypass**: Implement rules for internal services (shared secret), admins, or IP whitelists.
- **Observability**: Add metrics for hits, exceeded, and bypassed requests.

## Edge Cases
| Case | Strategy |
|------|----------|
| Distributed Env | Use Redis for shared state across instances. |
| Redis Down | Implement fallback (Fail Open/Closed) based on config flag. |
| Proxy/LB | Trust `X-Forwarded-For` only from known proxy IPs. |

## Rate Limit Flow
```mermaid
flowchart TD
    A([Start: Rate Limiting]) --> B[Analyze endpoints + requirements]
    B --> C{Algorithm selection?}
    C -- Simple, no burst needed --> D[Fixed window: easy but burst at boundary]
    C -- Accurate, low volume --> E[Sliding window log: precise, memory-heavy]
    C -- Balanced accuracy + memory --> F[Sliding window counter: recommended default]
    C -- Controlled burst allowed --> G[Token bucket: allows short bursts]
    D & E & F & G --> H{Deployment: single or distributed?}
    H -- Single instance --> I[In-memory counter acceptable]
    H -- Multiple instances --> J[Redis required for shared counter]
    I & J --> K[Identify rate limit key]
    K --> L{Key type?}
    L -- Public API --> M[Key by IP address]
    L -- Authenticated API --> N[Key by user ID or API key]
    L -- Mixed --> O[Key by user ID if auth, else IP]
    M & N & O --> P[Atomic check-and-increment in Redis]
    P --> Q{Limit exceeded?}
    Q -- Yes --> R[Return 429 + Retry-After header]
    Q -- No --> S[Add headers: X-RateLimit-Limit, Remaining, Reset]
    R & S --> T{Bypass rules needed?}
    T -- Yes --> U{Bypass type?}
    U -- Internal service --> V[Check shared secret header]
    U -- Admin user --> W[Check user role / API key whitelist]
    U -- IP whitelist --> X[Check CIDR range]
    T -- No --> Y
    V & W & X & Y --> Z{Redis unavailable?}
    Z -- Fail open --> AA[Allow all requests, log warning]
    Z -- Fail closed --> AB[Block all requests, return 503]
    AA & AB --> AC[Emit metrics: hits, exceeded, bypassed]
    AC --> AD([Output: Rate limiting middleware with bypass + monitoring])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Are operations atomic (Redis)?
2. Are standard headers included?
3. Is bypass logic secure?
4. Are failure modes handled?
5. is it performance-tuned?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
