# Caching Strategy Specification Template

> Fill in all fields before activating the `caching-strategy-implementation` skill.

---

## Data to Cache

**Data Description:** {{what data — e.g. user profiles, product catalog, API responses}}

**Data Source:** {{e.g. PostgreSQL, external REST API, computed aggregation}}

**Access Pattern:** {{read-heavy / write-heavy / mixed}}

**Read Frequency:** {{e.g. every API request, ~1000 reads/min}}

**Write Frequency:** {{e.g. rarely — user updates profile ~once/week}}

**Data Size per Entry:** {{e.g. ~2KB per user profile}}

**Total Entries:** {{e.g. 100k active users}}

---

## Cache Requirements

| Setting | Value |
|---------|-------|
| TTL | {{e.g. 1 hour, 5 minutes, no expiry}} |
| Invalidation trigger | {{e.g. on update, on delete, time-based only}} |
| Consistency level | {{eventual / strong}} |
| Cache stampede protection | {{yes/no}} |
| Graceful degradation (cache down) | {{yes/no}} |
| Max cache size | {{e.g. 512MB, unlimited}} |

---

## Tech Stack

**Application Stack:** {{e.g. Node.js + TypeScript + Express}}

**Cache Technology:** {{e.g. Redis 7 (ioredis), Memcached, in-memory (node-cache)}}

**Cache Connection:** {{e.g. REDIS_URL env var, already configured}}

---

## Cache Key Design

**Key Pattern:** `{{prefix}}:{{entity}}:{{id}}` *(e.g. `cache:user:123`)*

**Namespace:** {{e.g. `user:`, `product:`, `session:`}}
