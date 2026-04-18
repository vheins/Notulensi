# Example Output: rate-limiting

**Expected Output Shape:**
```typescript
import Redis from 'ioredis';

const redis = new Redis(process.env.REDIS_URL);

interface RateLimitConfig {
  windowMs: number;
  max: number;
  keyPrefix: string;
}

function createRateLimiter(config: RateLimitConfig) {
  return async (req: Request, res: Response, next: NextFunction) => {
    // Bypass for internal services
    if (req.headers['x-internal-secret'] === process.env.INTERNAL_SECRET) {
      return next();
    }

    // Key: authenticated users by userId, anonymous by IP
    const identifier = req.user?.id ?? req.ip;
    const key = `${config.keyPrefix}:${identifier}`;
    const windowSec = Math.floor(config.windowMs / 1000);
    const now = Date.now();
    const windowStart = now - config.windowMs;

    // Sliding window counter using Redis sorted set (atomic via pipeline)
    const pipeline = redis.pipeline();
    pipeline.zremrangebyscore(key, 0, windowStart);  // Remove expired entries
    pipeline.zadd(key, now, `${now}-${Math.random()}`);  // Add current request
    pipeline.zcard(key);  // Count requests in window
    pipeline.expire(key, windowSec + 1);
    const results = await pipeline.exec();

    const count = results![2][1] as number;
    const resetTime = Math.floor((now + config.windowMs) / 1000);

    res.setHeader('X-RateLimit-Limit', config.max);
    res.setHeader('X-RateLimit-Remaining', Math.max(0, config.max - count));
    res.setHeader('X-RateLimit-Reset', resetTime);

    if (count > config.max) {
      res.setHeader('Retry-After', windowSec);
      return res.status(429).json({
        error: 'Too many requests',
        retryAfter: windowSec,
      });
    }

    next();
  };
}

// Per-endpoint configuration
const generalLimiter = createRateLimiter({ windowMs: 60_000, max: 100, keyPrefix: 'rl:general' });
const authLimiter = createRateLimiter({ windowMs: 60_000, max: 10, keyPrefix: 'rl:auth' });
const uploadLimiter = createRateLimiter({ windowMs: 60_000, max: 5, keyPrefix: 'rl:upload' });

// Apply to routes
app.use('/api', generalLimiter);
app.use('/auth', authLimiter);
app.use('/upload', uploadLimiter);
```


**Expected Output Shape:**
```python
import redis.asyncio as aioredis
from fastapi import Request, HTTPException
from fastapi.responses import JSONResponse

r = aioredis.from_url(os.environ["REDIS_URL"])

async def rate_limit_middleware(request: Request, call_next):
    # Bypass for premium API keys
    api_key = request.headers.get("X-API-Key")
    if api_key and await is_premium_key(api_key):
        return await call_next(request)

    # Determine identifier
    user_id = getattr(request.state, "user_id", None)
    identifier = user_id or request.client.host
    limit = 300 if user_id else 60
    window = 60  # seconds

    key = f"rl:{identifier}"
    count = await r.incr(key)
    if count == 1:
        await r.expire(key, window)

    ttl = await r.ttl(key)

    if count > limit:
        return JSONResponse(
            status_code=429,
            content={"error": "Too many requests", "retry_after": ttl},
            headers={
                "X-RateLimit-Limit": str(limit),
                "X-RateLimit-Remaining": "0",
                "X-RateLimit-Reset": str(int(time.time()) + ttl),
                "Retry-After": str(ttl),
            }
        )

    response = await call_next(request)
    response.headers["X-RateLimit-Limit"] = str(limit)
    response.headers["X-RateLimit-Remaining"] = str(max(0, limit - count))
    return response

app.middleware("http")(rate_limit_middleware)
```
