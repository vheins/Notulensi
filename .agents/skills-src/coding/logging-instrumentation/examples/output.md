# Example Output: logging-instrumentation

**Expected Output Shape:**
```typescript
import pino from 'pino';

// Logger setup — JSON output, level from env
const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  base: { service: 'payment-service', version: process.env.APP_VERSION, env: process.env.NODE_ENV },
  timestamp: pino.stdTimeFunctions.isoTime,
});

// Masking utility
const maskCard = (token: string) => `****${token.slice(-4)}`;

async function processPayment(
  userId: string,
  amount: number,
  cardToken: string,
  correlationId: string
) {
  const log = logger.child({ correlationId, userId, amount });

  log.info({ cardTokenMasked: maskCard(cardToken) }, 'Payment processing started');

  let user;
  try {
    user = await userService.findById(userId);
  } catch (err) {
    log.error({ err }, 'Failed to fetch user for payment');
    throw err;
  }

  let result;
  try {
    result = await paymentGateway.charge(cardToken, amount);
    log.info({ transactionId: result.transactionId }, 'Payment gateway charge successful');
  } catch (err) {
    log.error({ err, cardTokenMasked: maskCard(cardToken) }, 'Payment gateway charge failed');
    throw err;
  }

  try {
    await orderService.markPaid(result.transactionId);
    log.info({ transactionId: result.transactionId }, 'Order marked as paid');
  } catch (err) {
    // Payment succeeded but order update failed — critical inconsistency
    log.error({ err, transactionId: result.transactionId }, 'CRITICAL: Payment succeeded but order update failed');
    throw err;
  }

  return result;
}
```


**Expected Output Shape:**
```python
import structlog

# Logger setup
structlog.configure(
    processors=[
        structlog.contextvars.merge_contextvars,
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.JSONRenderer(),
    ]
)
log = structlog.get_logger()

def mask_email(email: str) -> str:
    local, domain = email.split("@", 1)
    return f"{local[0]}***@{domain}"

def register_user(email: str, password: str, db: Session):
    masked_email = mask_email(email)
    log.info("user_registration_started", email=masked_email)

    existing = db.query(User).filter(User.email == email).first()
    if existing:
        log.warning("user_registration_duplicate_email", email=masked_email)
        raise ValueError("Email already registered")

    try:
        user = User(email=email, password_hash=hash_password(password))
        db.add(user)
        db.commit()
        log.info("user_registration_success", email=masked_email, user_id=str(user.id))
        return user
    except SQLAlchemyError as e:
        log.error("user_registration_db_error", email=masked_email, error=str(e))
        db.rollback()
        raise
```
