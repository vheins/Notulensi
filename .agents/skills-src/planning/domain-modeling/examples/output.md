# Example Output: domain-modeling

**Expected Output Shape:**
```
1. Entity Definitions
Order (Aggregate Root)
- Identity: OrderId (UUID)
- Attributes: customerId (CustomerId), items (OrderItem[]), status (OrderStatus), placedAt (Date)
- Invariants: Must have at least one item; total amount must be > 0; cannot ship without payment confirmation
- Lifecycle: Pending → Confirmed → Shipped → Delivered | Cancelled

OrderItem (Entity within Order aggregate)
- Identity: OrderItemId (UUID)
- Attributes: productId (ProductId), quantity (Quantity), unitPrice (Money)
- Invariants: Quantity must be > 0; unitPrice must be > 0

2. Value Objects
Money
- Attributes: amount (Decimal), currency (CurrencyCode)
- Why value object: Equality by amount + currency; immutable; no identity
- Validation: amount >= 0; currency must be valid ISO 4217 code

Quantity
- Attributes: value (Integer)
- Why value object: Immutable integer with domain validation
- Validation: value > 0

OrderStatus
- Attributes: value (enum: PENDING | CONFIRMED | SHIPPED | DELIVERED | CANCELLED)
- Why value object: Represents a state with valid transitions

3. Aggregate Roots
Order Aggregate
- Root: Order
- Contains: OrderItem (entities), Money (value objects), Quantity (value objects)
- Invariants enforced: Payment must be confirmed before status transitions to SHIPPED
- Boundary rationale: All order consistency rules (item count, total, status transitions) must be enforced atomically

4. Domain Events
OrderPlaced
- Trigger: Customer successfully places an order
- Payload: orderId, customerId, items[], totalAmount, placedAt
- Consumers: Payment context (to initiate payment), Inventory context (to reserve stock)

OrderShipped
- Trigger: Warehouse confirms shipment
- Payload: orderId, trackingNumber, shippedAt
- Consumers: Notification context (to email customer), Fulfillment context

OrderCancelled
- Trigger: Customer or system cancels order
- Payload: orderId, reason, cancelledAt
- Consumers: Payment context (to refund), Inventory context (to release stock)

5. Repository Interfaces
interface OrderRepository {
  findById(id: OrderId): Promise<Order | null>
  findByCustomerId(customerId: CustomerId): Promise<Order[]>
  findByStatus(status: OrderStatus): Promise<Order[]>
  save(order: Order): Promise<void>
  delete(id: OrderId): Promise<void>
}

6. Ubiquitous Language Glossary
- Order: A customer's request to purchase one or more products at a specific point in time
- Order Item: A single product line within an order, with quantity and agreed price
- Fulfillment: The process of picking, packing, and shipping an order to the customer
- Confirmation: The act of verifying payment and reserving inventory before shipping
- Cancellation: The termination of an order before it is shipped, triggering refund and stock release
```


**Expected Output Shape:**
```
1. Entity Definitions
Product (Aggregate Root)
- Identity: ProductId (UUID)
- Attributes: sku (SKU), name (String), stockQuantity (Quantity), reservedQuantity (Quantity), alertThreshold (Quantity)
- Invariants: stockQuantity >= 0; reservedQuantity <= stockQuantity; alertThreshold >= 0
- Lifecycle: Active | Discontinued

StockReservation (Entity within Product aggregate)
- Identity: ReservationId (UUID)
- Attributes: orderId (OrderId), quantity (Quantity), reservedAt (Instant)
- Invariants: quantity > 0

2. Value Objects
SKU
- Attributes: value (String, format: [A-Z]{3}-[0-9]{6})
- Why value object: Immutable identifier with format validation; equality by value

Quantity
- Attributes: value (Integer)
- Validation: value >= 0

3. Aggregate Roots
Product Aggregate
- Root: Product
- Contains: StockReservation (entities), SKU, Quantity (value objects)
- Invariants: Available stock (stockQuantity - reservedQuantity) must never go negative
- Boundary rationale: All stock consistency rules must be enforced atomically per product

4. Domain Events
StockReserved
- Trigger: Order placed and stock reserved for it
- Payload: productId, orderId, quantity, reservedAt
- Consumers: Order Management context (to confirm reservation)

LowStockAlertTriggered
- Trigger: stockQuantity falls below alertThreshold after a stock update
- Payload: productId, sku, currentQuantity, threshold
- Consumers: Notification context (to alert warehouse manager)

StockReleased
- Trigger: Order cancelled; reserved stock returned to available
- Payload: productId, orderId, quantity, releasedAt
- Consumers: Order Management context

5. Repository Interfaces
public interface ProductRepository {
  Optional<Product> findById(ProductId id);
  Optional<Product> findBySku(SKU sku);
  List<Product> findBelowThreshold();
  void save(Product product);
}

6. Ubiquitous Language Glossary
- Stock: The quantity of a product physically available in the warehouse
- Reservation: A temporary hold on stock quantity for a pending order
- Available Stock: Stock quantity minus reserved quantity
- Alert Threshold: The minimum stock level that triggers a low-stock notification
- SKU: Stock Keeping Unit — a unique identifier for a product variant
```
