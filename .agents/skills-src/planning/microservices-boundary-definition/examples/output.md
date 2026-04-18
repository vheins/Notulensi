# Example Output: microservices-boundary-definition

**Expected Output Shape:**
```
1. Service List
Catalog Service — owns product listings, categories, search; exposes: GET /products, GET /categories; data: products, categories; team: A
Inventory Service — owns stock levels and reservations; exposes: reserve stock, release stock; data: stock_levels, reservations; team: A
Order Service — owns order lifecycle; exposes: create order, update status; data: orders, order_items; team: B
Payment Service — owns payment processing and refunds; exposes: charge, refund; data: payments, refunds; team: B
Customer Service — owns user accounts and addresses; exposes: user CRUD, auth; data: users, addresses; team: C
Shipping Service — owns shipment tracking and carrier integration; exposes: create shipment, track; data: shipments; team: C

2. Boundary Rationale
Order Service boundary: Maps to "Order Management" bounded context. Orders have their own lifecycle (pending → shipped → delivered) independent of payment or inventory. Splitting order + payment into one service would couple two high-change-frequency domains. Team B owns both, reducing coordination overhead.

Payment Service boundary: Maps to "Payment" bounded context. Payment logic (PCI compliance, idempotency, refund rules) is specialized and changes independently of order logic. Separate service enables independent PCI audit scope.

3. Inter-Service Communication
| Source | Target | Pattern | Contract | Rationale |
|--------|--------|---------|----------|-----------|
| Order Service | Inventory Service | Async (Kafka) | stock.reserve event | Eventual consistency acceptable; decouples order creation from stock check |
| Order Service | Payment Service | Sync (gRPC) | ChargeRequest/ChargeResponse | Payment confirmation required before order proceeds |
| Payment Service | Order Service | Async (Kafka) | payment.completed event | Payment result triggers order status update |
| Shipping Service | Order Service | Async (Kafka) | shipment.created event | Order status updated when shipment created |

4. Data Ownership Map
orders table: owned by Order Service; read by Shipping Service via API; consistency: strong within Order Service
stock_levels table: owned by Inventory Service; read by Catalog Service via API (for display); consistency: eventual for display, strong for reservation
payments table: owned by Payment Service; read by Order Service via event-sourced read model; consistency: eventual

5. Migration Strategy
Extraction order: 1) Customer Service (lowest coupling, no shared state with core flow), 2) Catalog Service (read-heavy, easy to extract), 3) Payment Service (high value, isolated PCI scope), 4) Order + Inventory (most coupled, extract last)
Strangler fig: Route /api/customers/* to new Customer Service; keep monolith handling all other routes; expand routing incrementally.
Database decomposition: Extract customer tables first (no foreign keys from other domains); use dual-write pattern during transition.
Rollback: Keep monolith running in parallel for 2 sprints after each extraction; revert routing if error rate increases.
```


**Expected Output Shape:**
```
1. Service List
User Service — owns user accounts, authentication, roles; data: users, roles; team: A
Project Service — owns projects, tasks, team membership; data: projects, tasks, memberships; team: A
Billing Service — owns subscriptions, invoices, payment methods; data: subscriptions, invoices; team: B
Notification Service — owns email/push delivery; no persistent data (stateless); team: B
Analytics Service — owns usage metrics and reports; data: events (append-only); team: B

2. Boundary Rationale
User Service boundary: Authentication and user identity is a cross-cutting concern but should be owned by one service. Separating from Project Service allows independent scaling of auth (high read volume) vs. project operations (high write volume).

Billing Service boundary: Billing has specialized compliance requirements (PCI, tax) and changes on a different cadence than product features. Team B owns it, aligning with Conway's Law.

3. Inter-Service Communication
| Source | Target | Pattern | Contract | Rationale |
|--------|--------|---------|----------|-----------|
| Project Service | User Service | Sync (REST) | GET /users/{id} | User data needed synchronously for project membership display |
| Billing Service | User Service | Async (RabbitMQ) | subscription.activated event | User service updates feature flags on subscription change |
| All Services | Notification Service | Async (RabbitMQ) | notification.send event | Fire-and-forget; notification failure should not block business operations |
| All Services | Analytics Service | Async (RabbitMQ) | usage.event | Append-only event stream; analytics is read-only consumer |

4. Data Ownership Map
users table: owned by User Service; read by Project Service via API; consistency: strong
subscription status: owned by Billing Service; read by User Service via event-sourced cache; consistency: eventual (acceptable for feature flag checks)

5. Migration Strategy
Extraction order: 1) Notification Service (stateless, easy to extract), 2) Analytics Service (append-only, no write dependencies), 3) Billing Service (isolated domain), 4) User + Project Services (most coupled, extract last)
```
