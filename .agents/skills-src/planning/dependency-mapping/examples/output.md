# Example Output: dependency-mapping

**Expected Output Shape:**
```
1. Dependency Graph
OrderService → PaymentService (Direct, sync HTTP)
OrderService → InventoryService (Direct, sync HTTP)
PaymentService → NotificationService (Direct, sync HTTP)
InventoryService → OrderService (Direct, sync HTTP) ← CIRCULAR

Dependency Matrix:
| Module | Depends On | Depended On By | Coupling Type |
|--------|-----------|----------------|---------------|
| OrderService | PaymentService, InventoryService | InventoryService | Direct + Shared DB |
| PaymentService | NotificationService | OrderService | Direct + Shared DB |
| InventoryService | OrderService | OrderService | Direct + Shared DB |
| NotificationService | None | PaymentService | Shared DB |

2. Circular Dependencies
Cycle: OrderService → InventoryService → OrderService
Problem: Neither service can be deployed independently; testing requires both services running.
Severity: Critical

3. Risk Assessment
| Dependency | Risk Level | Risk Reason | Impact if Fails |
|------------|------------|-------------|-----------------|
| OrderService → PaymentService | High | Synchronous; payment failure blocks order creation | Orders cannot be placed |
| InventoryService → OrderService | High | Circular dependency; tight coupling | Both services fail together |
| All → Shared DB | High | Schema change in one service breaks others | All services affected by any migration |
| PaymentService → NotificationService | Medium | Notification failure could block payment confirmation | Payment confirmed but no receipt sent |

4. Decoupling Recommendations
1. Break OrderService ↔ InventoryService cycle:
   Current: Synchronous HTTP calls in both directions
   Recommended: InventoryService publishes "stock.reserved" event; OrderService subscribes
   Steps: Add message broker (Redis Streams or RabbitMQ); refactor InventoryService to emit events
   Trade-off: Eventual consistency instead of immediate; adds message broker operational overhead

2. Decouple shared PostgreSQL database:
   Current: All services share one DB schema
   Recommended: Database-per-service; cross-service data via API or events
   Steps: Identify service boundaries in schema; extract tables per service; add API endpoints for cross-service reads
   Trade-off: Eliminates cross-service joins; requires data duplication for reporting

3. Decouple PaymentService → NotificationService:
   Current: Synchronous HTTP call
   Recommended: Publish "payment.completed" event; NotificationService subscribes
   Steps: Add event emission in PaymentService; refactor NotificationService to consume events
   Trade-off: Notification delivery becomes async; simpler payment flow
```


**Expected Output Shape:**
```
1. Dependency Graph
billing → projects (Direct import)
reports → tasks, projects, billing (Direct import)
notifications → accounts, tasks (Direct import)
tasks → accounts, projects (Direct import)
accounts → (none — leaf node)
projects → accounts (Direct import)

2. Circular Dependencies
No circular dependencies detected. accounts is a pure leaf node imported by all others.
The dependency graph is a DAG (directed acyclic graph) — safe for current monolith structure.
Risk note: If accounts ever needs to import from tasks or billing, a cycle will form.

3. Risk Assessment
| Dependency | Risk Level | Risk Reason | Impact if Fails |
|------------|------------|-------------|-----------------|
| reports → billing | High | Reports tightly coupled to billing logic; billing changes break reports | Reports module fails on billing schema change |
| tasks → accounts | Medium | All task operations require accounts; accounts changes ripple to tasks | Task operations fail if accounts module errors |
| notifications → tasks | Low | Read-only dependency for notification content | Notifications degrade gracefully |

4. Decoupling Recommendations
1. Decouple reports from billing:
   Current: Direct import of billing models
   Recommended: Create a ReportingService interface that billing implements
   Steps: Define abstract interface; billing implements it; reports depends on interface only
   Trade-off: More abstraction layers; easier to test reports in isolation

2. Protect accounts as a stable core:
   Current: All modules import accounts directly
   Recommended: Define accounts as a formal internal API (service layer) with versioned interfaces
   Steps: Wrap accounts DB access in AccountsService class; all modules call service methods
   Trade-off: Slight overhead; prevents accidental direct DB access from other modules
```
