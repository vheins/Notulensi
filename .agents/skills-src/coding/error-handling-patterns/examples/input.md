# Example Input: error-handling-patterns

### Example 1: TypeScript + Express
**Input:**
- `{{tech_stack}}`: TypeScript + Express + Prisma
- `{{module_code}}`:
```typescript
async function createOrder(userId: string, items: OrderItem[]) {
  const user = await prisma.user.findUnique({ where: { id: userId } });
  const order = await prisma.order.create({ data: { userId, items: { create: items } } });
  await emailService.sendConfirmation(user.email, order.id);
  return order;
}
```
- `{{error_scenarios}}`: "User not found, DB failure, email service failure, invalid items array"


### Example 2: Python + FastAPI
**Input:**
- `{{tech_stack}}`: Python + FastAPI + SQLAlchemy
- `{{module_code}}`:
```python
def get_product_with_inventory(product_id: int, db: Session):
    product = db.query(Product).filter(Product.id == product_id).first()
    inventory = inventory_api.get_stock(product_id)
    return {**product.__dict__, "stock": inventory["quantity"]}
```
- `{{error_scenarios}}`: "Product not found, inventory API timeout, DB connection error, API returns unexpected format"
