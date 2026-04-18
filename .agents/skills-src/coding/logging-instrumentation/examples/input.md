# Example Input: logging-instrumentation

### Example 1: Node.js + pino
**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + pino
- `{{module_code}}`:
```typescript
async function processPayment(userId: string, amount: number, cardToken: string) {
  const user = await userService.findById(userId);
  const result = await paymentGateway.charge(cardToken, amount);
  await orderService.markPaid(result.transactionId);
  return result;
}
```
- `{{log_requirements}}`: "Log payment start, success, and failure. Include userId, amount, transactionId. Mask cardToken. Correlation ID required."


### Example 2: Python + structlog
**Input:**
- `{{tech_stack}}`: Python + FastAPI + structlog
- `{{module_code}}`:
```python
def register_user(email: str, password: str, db: Session):
    existing = db.query(User).filter(User.email == email).first()
    if existing:
        raise ValueError("Email already registered")
    user = User(email=email, password_hash=hash_password(password))
    db.add(user)
    db.commit()
    return user
```
- `{{log_requirements}}`: "Log registration attempt, success, duplicate email. Mask password. Include email (partial mask). Correlation ID via request context."
