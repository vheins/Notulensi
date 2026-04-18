# Example Output: caching-strategy-implementation

### Example 1: Node.js + Redis — User Profile Cache

**Expected Output:**
```typescript
import Redis from 'ioredis';

const redis = new Redis(process.env.REDIS_URL);
const CACHE_TTL = 3600; // 1 hour in seconds
const LOCK_TTL = 5;     // 5 second lock for stampede prevention

class UserProfileCache {
  private keyFor(userId: string) { return `user:profile:${userId}`; }
  private lockKeyFor(userId: string) { return `user:profile:${userId}:lock`; }

  async get(userId: string): Promise<UserProfile | null> {
    try {
      const cached = await redis.get(this.keyFor(userId));
      if (cached) {
        metrics.increment('cache.hit', { entity: 'user_profile' });
        return JSON.parse(cached);
      }
      metrics.increment('cache.miss', { entity: 'user_profile' });
      return null;
    } catch (err) {
      // Cache unavailable — graceful degradation, log and continue
      logger.warn({ err, userId }, 'Redis unavailable, bypassing cache');
      return null;
    }
  }

  async set(userId: string, profile: UserProfile): Promise<void> {
    try {
      await redis.setex(this.keyFor(userId), CACHE_TTL, JSON.stringify(profile));
    } catch (err) {
      logger.warn({ err, userId }, 'Failed to write to cache');
    }
  }

  async invalidate(userId: string): Promise<void> {
    await redis.del(this.keyFor(userId));
    logger.debug({ userId }, 'Cache invalidated for user profile');
  }

  // Cache-aside with stampede prevention using distributed lock
  async getOrLoad(userId: string, loader: () => Promise<UserProfile>): Promise<UserProfile> {
    const cached = await this.get(userId);
    if (cached) return cached;

    // Acquire lock to prevent multiple concurrent DB reads for same key
    const lockAcquired = await redis.set(this.lockKeyFor(userId), '1', 'EX', LOCK_TTL, 'NX');
    if (!lockAcquired) {
      // Another process is loading — wait briefly and retry from cache
      await new Promise(r => setTimeout(r, 100));
      return this.getOrLoad(userId, loader);
    }

    try {
      const profile = await loader();
      await this.set(userId, profile);
      return profile;
    } finally {
      await redis.del(this.lockKeyFor(userId));
    }
  }
}

// Usage in service layer
class UserService {
  constructor(private cache: UserProfileCache, private db: UserRepository) {}

  async getProfile(userId: string): Promise<UserProfile> {
    return this.cache.getOrLoad(userId, () => this.db.findById(userId));
  }

  async updateProfile(userId: string, data: UpdateProfileInput): Promise<UserProfile> {
    const updated = await this.db.update(userId, data);
    await this.cache.invalidate(userId); // Invalidate on write
    return updated;
  }
}
```

---

### Example 2: Python + Redis — API Response Cache

**Expected Output:**
```python
import redis
import json
import time
from functools import wraps

r = redis.from_url(os.environ["REDIS_URL"], decode_responses=True)

CACHE_TTL = 300       # 5 minutes
STALE_TTL = 360       # 6 minutes — serve stale for 1 min while refreshing

def cache_exchange_rates(base_currency: str) -> dict | None:
    key = f"exchange_rates:{base_currency}"
    cached = r.get(key)
    if cached:
        return json.loads(cached)
    return None

def set_exchange_rates(base_currency: str, rates: dict) -> None:
    key = f"exchange_rates:{base_currency}"
    r.setex(key, CACHE_TTL, json.dumps(rates))

async def get_exchange_rates(base_currency: str) -> dict:
    # Try cache first
    cached = cache_exchange_rates(base_currency)
    if cached:
        return cached

    # Cache miss — fetch from external API
    try:
        rates = await external_api.get_rates(base_currency)
        set_exchange_rates(base_currency, rates)
        return rates
    except ExternalAPIError:
        # If external API fails, try to serve stale data
        stale = r.get(f"exchange_rates:{base_currency}:stale")
        if stale:
            logger.warning("Serving stale exchange rates due to API failure")
            return json.loads(stale)
        raise
```
