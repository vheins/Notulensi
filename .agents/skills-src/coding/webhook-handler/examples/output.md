# Example Output: webhook-handler

**Expected Output Shape:**
```typescript
import Stripe from 'stripe';
import Redis from 'ioredis';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!);
const redis = new Redis(process.env.REDIS_URL);
const WEBHOOK_SECRET = process.env.STRIPE_WEBHOOK_SECRET!;

// CRITICAL: Use express.raw() for webhook routes — JSON parsing breaks signature verification
app.post('/webhooks/stripe',
  express.raw({ type: 'application/json' }),
  async (req: Request, res: Response) => {
    // 1. Signature verification
    let event: Stripe.Event;
    try {
      event = stripe.webhooks.constructEvent(req.body, req.headers['stripe-signature']!, WEBHOOK_SECRET);
    } catch (err) {
      logger.warn({ err }, 'Stripe webhook signature verification failed');
      return res.status(401).json({ error: 'Invalid signature' });
    }

    // 2. Idempotency check
    const idempotencyKey = `webhook:stripe:${event.id}`;
    const alreadyProcessed = await redis.get(idempotencyKey);
    if (alreadyProcessed) {
      logger.debug({ eventId: event.id }, 'Duplicate webhook event — skipping');
      return res.status(200).json({ received: true });
    }

    // 3. Acknowledge immediately, process async
    res.status(200).json({ received: true });

    // 4. Process event
    try {
      await processStripeEvent(event);
      // Mark as processed with 24h TTL (Stripe retries for up to 3 days)
      await redis.setex(idempotencyKey, 86400, 'processed');
    } catch (err) {
      logger.error({ err, eventId: event.id, eventType: event.type }, 'Webhook processing failed');
      await moveToDeadLetterQueue(event, err as Error);
    }
  }
);

async function processStripeEvent(event: Stripe.Event) {
  switch (event.type) {
    case 'payment_intent.succeeded':
      await handlePaymentSucceeded(event.data.object as Stripe.PaymentIntent);
      break;
    case 'payment_intent.payment_failed':
      await handlePaymentFailed(event.data.object as Stripe.PaymentIntent);
      break;
    case 'customer.subscription.deleted':
      await handleSubscriptionCancelled(event.data.object as Stripe.Subscription);
      break;
    default:
      // Unknown event type — log and ignore (don't fail)
      logger.info({ eventType: event.type }, 'Unhandled Stripe event type');
  }
}

async function moveToDeadLetterQueue(event: Stripe.Event, error: Error) {
  await db.query(
    'INSERT INTO webhook_dead_letters (provider, event_id, event_type, payload, error, created_at) VALUES ($1,$2,$3,$4,$5,NOW())',
    ['stripe', event.id, event.type, JSON.stringify(event), error.message]
  );
}
```


**Expected Output Shape:**
```python
import hmac
import hashlib
from fastapi import Request, HTTPException, BackgroundTasks

GITHUB_WEBHOOK_SECRET = os.environ["GITHUB_WEBHOOK_SECRET"].encode()

async def verify_github_signature(request: Request) -> bytes:
    """Verify GitHub webhook signature. Returns raw body."""
    body = await request.body()
    signature = request.headers.get("X-Hub-Signature-256", "")
    expected = "sha256=" + hmac.new(GITHUB_WEBHOOK_SECRET, body, hashlib.sha256).hexdigest()
    # Constant-time comparison prevents timing attacks
    if not hmac.compare_digest(signature, expected):
        raise HTTPException(status_code=401, detail="Invalid signature")
    return body

@router.post("/webhooks/github")
async def github_webhook(request: Request, background_tasks: BackgroundTasks):
    body = await verify_github_signature(request)
    payload = json.loads(body)

    event_type = request.headers.get("X-GitHub-Event")
    delivery_id = request.headers.get("X-GitHub-Delivery")

    # Idempotency check
    if await redis.get(f"webhook:github:{delivery_id}"):
        return {"received": True}

    # Acknowledge immediately
    background_tasks.add_task(process_github_event, event_type, payload, delivery_id)
    return {"received": True}

async def process_github_event(event_type: str, payload: dict, delivery_id: str):
    try:
        handlers = {
            "push": handle_push,
            "pull_request": handle_pull_request,
            "check_run": handle_check_run,
        }
        handler = handlers.get(event_type)
        if handler:
            await handler(payload)
        await redis.setex(f"webhook:github:{delivery_id}", 86400, "processed")
    except Exception as e:
        logger.error(f"GitHub webhook failed: {e}", extra={"delivery_id": delivery_id})
        await save_dead_letter(event_type, payload, delivery_id, str(e))
```
