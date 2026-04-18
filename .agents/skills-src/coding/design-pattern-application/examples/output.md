# Example Output: design-pattern-application

**Expected Output Shape:**
```
Pattern Recommendation: Strategy Pattern
The Strategy pattern fits because you have a family of interchangeable algorithms (payment providers)
that need to be selected at runtime. It eliminates the if/else chain and allows adding new providers
without touching existing code (Open/Closed Principle).

Alternatives Considered:
1. Factory Pattern — could create provider instances, but doesn't define the interchangeable interface
2. Adapter Pattern — useful if provider APIs are wildly different, but Strategy is simpler when the
   interface can be unified

Implementation:
```typescript
// Define the unified contract all providers must implement
interface PaymentProvider {
  charge(amount: number, currency: string, token: string): Promise<{ transactionId: string }>;
  refund(transactionId: string): Promise<void>;
  getStatus(transactionId: string): Promise<'pending' | 'completed' | 'failed'>;
}

// Concrete strategy: Stripe
class StripeProvider implements PaymentProvider {
  async charge(amount: number, currency: string, token: string) {
    // Stripe-specific implementation
    const charge = await stripe.charges.create({ amount, currency, source: token });
    return { transactionId: charge.id };
  }
  async refund(transactionId: string) { await stripe.refunds.create({ charge: transactionId }); }
  async getStatus(transactionId: string) { /* ... */ return 'completed' as const; }
}

// Context: uses whichever strategy is injected
class PaymentService {
  constructor(private provider: PaymentProvider) {}

  async processPayment(amount: number, currency: string, token: string) {
    return this.provider.charge(amount, currency, token);
  }
}

// Usage: swap provider without changing PaymentService
const service = new PaymentService(new StripeProvider());
```

Trade-offs:
- Easier: Adding new providers (implement interface, register in DI container)
- Harder: If providers have fundamentally different concepts (e.g., crypto wallets), forcing them into one interface becomes awkward
- Don't use when: You only ever have one implementation — the abstraction adds complexity for no benefit
```


**Expected Output Shape:**
```
Pattern Recommendation: Observer Pattern (Event-Driven)
The Observer pattern decouples the order creation logic from its side effects. OrderService becomes
the subject that emits an event; each downstream action (email, inventory, warehouse) is an observer
that reacts independently. Adding SMS or analytics requires zero changes to OrderService.

Alternatives Considered:
1. Chain of Responsibility — sequential, but side effects here are independent (no chain needed)
2. Mediator — adds a central coordinator, useful if observers need to communicate; overkill here

Implementation:
```python
from typing import Callable, List
from dataclasses import dataclass

@dataclass
class OrderCreatedEvent:
    order_id: str
    user_id: str
    total: float

class EventBus:
    def __init__(self):
        self._handlers: List[Callable] = []

    def subscribe(self, handler: Callable[[OrderCreatedEvent], None]):
        self._handlers.append(handler)

    def publish(self, event: OrderCreatedEvent):
        for handler in self._handlers:
            handler(event)  # Consider asyncio.gather for async handlers

event_bus = EventBus()

# Observers — registered at startup, never touch OrderService
event_bus.subscribe(lambda e: email_service.send_order_confirmation(e.order_id))
event_bus.subscribe(lambda e: inventory_service.reserve_items(e.order_id))
event_bus.subscribe(lambda e: warehouse_service.notify(e.order_id))

# OrderService stays clean
class OrderService:
    def create_order(self, user_id: str, items: list) -> Order:
        order = self._persist_order(user_id, items)
        event_bus.publish(OrderCreatedEvent(order.id, user_id, order.total))
        return order
```

Trade-offs:
- Easier: Adding new side effects (subscribe a new handler)
- Harder: Debugging — execution flow is non-linear; errors in one observer can silently fail others
- Don't use when: Side effects must be transactional with the main operation (use saga or outbox pattern instead)
```
