# Example Output: tech-stack-selection

**Expected Output Shape:**
```
1. Recommended Stack
- Backend: FastAPI (Python) — async support, automatic OpenAPI generation, team familiarity
- Database: PostgreSQL — ACID compliance, RBAC via row-level security, team preference
- Background Jobs: Celery + Redis — mature Python ecosystem, reliable retry logic
- Infrastructure: AWS ECS + RDS — managed services reduce ops burden for small team
- Admin Dashboard: React Admin — rapid CRUD UI generation, connects to FastAPI

2. Alternative Stacks
Alt 1: Django + DRF — stronger ORM, built-in admin panel, but slower async performance
Alt 2: Node.js + NestJS — better real-time support, but team retraining cost is high

3. Decision Matrix
| Criterion | Weight | FastAPI | Django | NestJS |
|-----------|--------|---------|--------|--------|
| Team familiarity | 30% | 5 | 4 | 2 |
| OpenAPI support | 20% | 5 | 3 | 4 |
| Background jobs | 20% | 4 | 5 | 3 |
| Async performance | 15% | 5 | 3 | 5 |
| Admin UI | 15% | 3 | 5 | 3 |
| Weighted Total | 100% | 4.5 | 3.9 | 3.1 |

4. Migration Path
Trigger: Team grows to 10+ engineers needing stronger conventions → migrate to Django.
Sequence: 1) Add Django alongside FastAPI, 2) migrate admin routes first, 3) migrate API routes incrementally.
Effort: ~3–4 months for full migration.
```


**Expected Output Shape:**
```
1. Recommended Stack
- Frontend: Next.js + TipTap (rich text) — TypeScript-native, Vercel-optimized, TipTap has CRDT support
- Backend: Node.js + tRPC — end-to-end type safety, minimal boilerplate for small team
- Real-time: Liveblocks or PartyKit — managed real-time infrastructure, avoids WebSocket ops burden
- Database: PostgreSQL + Supabase — managed Postgres with real-time subscriptions, generous free tier
- Deployment: Vercel (frontend) + Railway (backend)

2. Alternative Stacks
Alt 1: Next.js + Supabase only (no separate backend) — simpler ops, but limited business logic control
Alt 2: Next.js + Socket.io + Redis — full control over real-time, but significant ops overhead for 2 engineers

3. Decision Matrix
| Criterion | Weight | Recommended | Supabase-only | Socket.io |
|-----------|--------|-------------|---------------|-----------|
| Real-time capability | 35% | 5 | 4 | 5 |
| Ops simplicity | 25% | 4 | 5 | 2 |
| TypeScript support | 20% | 5 | 4 | 4 |
| Cost at 1k users | 20% | 4 | 5 | 3 |
| Weighted Total | 100% | 4.6 | 4.4 | 3.4 |

4. Migration Path
Trigger: 10k+ concurrent users → Liveblocks pricing becomes expensive → self-host with Socket.io + Redis.
Sequence: 1) Abstract real-time layer behind interface, 2) swap Liveblocks for Socket.io, 3) add Redis for pub/sub.
Effort: ~2 months with abstraction layer in place from day one.
```
