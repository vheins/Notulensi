# Example Output: error-handling-patterns

**Expected Output Shape:**
```typescript
// Error type hierarchy
class AppError extends Error {
  constructor(
    public readonly code: string,
    message: string,
    public readonly httpStatus: number,
    public readonly isOperational: boolean = true,
    public readonly cause?: Error
  ) { super(message); this.name = this.constructor.name; }
}

class NotFoundError extends AppError {
  constructor(resource: string, id: string) {
    super('NOT_FOUND', `${resource} ${id} not found`, 404);
  }
}

class ExternalServiceError extends AppError {
  constructor(service: string, cause: Error) {
    super('EXTERNAL_SERVICE_ERROR', `${service} is unavailable`, 503, true, cause);
  }
}

// Updated module with error handling
async function createOrder(userId: string, items: OrderItem[], correlationId: string) {
  if (!items?.length) throw new ValidationError('items', 'Order must contain at least one item');

  const user = await prisma.user.findUnique({ where: { id: userId } });
  if (!user) throw new NotFoundError('User', userId);

  let order: Order;
  try {
    order = await prisma.order.create({ data: { userId, items: { create: items } } });
  } catch (err) {
    logger.error({ correlationId, userId, err }, 'DB error creating order');
    throw new AppError('DB_ERROR', 'Failed to create order', 500, true, err as Error);
  }

  // Email failure is non-fatal — log and continue
  try {
    await emailService.sendConfirmation(user.email, order.id);
  } catch (err) {
    logger.warn({ correlationId, orderId: order.id, err }, 'Email confirmation failed — order still created');
  }

  return order;
}

// Global error handler middleware
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  if (err instanceof AppError && err.isOperational) {
    return res.status(err.httpStatus).json({ error: err.message, code: err.code });
  }
  // Programmer error — log full details, return generic message
  logger.error({ err, path: req.path }, 'Unhandled error');
  res.status(500).json({ error: 'An unexpected error occurred', code: 'INTERNAL_ERROR' });
});
```


**Expected Output Shape:**
```python
from fastapi import HTTPException
import logging

logger = logging.getLogger(__name__)

class InventoryServiceError(Exception):
    """Raised when the inventory API returns an error or unexpected response."""
    pass

def get_product_with_inventory(product_id: int, db: Session, correlation_id: str) -> dict:
    # DB lookup
    try:
        product = db.query(Product).filter(Product.id == product_id).first()
    except SQLAlchemyError as e:
        logger.error("DB error fetching product", extra={"product_id": product_id, "correlation_id": correlation_id, "error": str(e)})
        raise HTTPException(status_code=503, detail="Service temporarily unavailable")

    if product is None:
        raise HTTPException(status_code=404, detail=f"Product {product_id} not found")

    # External API call — non-fatal fallback
    try:
        inventory = inventory_api.get_stock(product_id)
        stock = inventory.get("quantity")
        if stock is None:
            raise InventoryServiceError("Missing 'quantity' field in response")
    except (requests.Timeout, InventoryServiceError) as e:
        logger.warning("Inventory API unavailable, returning null stock", extra={"product_id": product_id, "error": str(e)})
        stock = None  # Graceful degradation

    return {**product.__dict__, "stock": stock}
```
