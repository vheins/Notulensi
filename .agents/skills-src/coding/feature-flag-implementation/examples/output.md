# Example Output: feature-flag-implementation

**Expected Output Shape:**
```typescript
// Flag definition
interface FeatureFlag {
  name: string;
  enabled: boolean;
  rolloutPercentage: number;  // 0-100
  allowlist: string[];        // User IDs always in the flag
  denylist: string[];         // User IDs always excluded
  owner: string;
  plannedRemovalDate: string; // ISO date — triggers cleanup reminder
}

// Flag storage (Redis-backed)
class FeatureFlagService {
  private cache = new Map<string, { value: boolean; expiresAt: number }>();
  private CACHE_TTL = 30_000; // 30 seconds

  async isEnabled(flagName: string, context: { userId: string }): Promise<boolean> {
    const flag = await this.getFlag(flagName);
    if (!flag) return false; // Default: disabled if flag doesn't exist

    if (!flag.enabled) return false;
    if (flag.denylist.includes(context.userId)) return false;
    if (flag.allowlist.includes(context.userId)) return true;

    // Deterministic percentage rollout: same user always gets same result
    const hash = this.hashUserId(context.userId, flagName);
    return (hash % 100) < flag.rolloutPercentage;
  }

  private hashUserId(userId: string, flagName: string): number {
    // Simple deterministic hash — use murmurhash or similar in production
    const str = `${flagName}:${userId}`;
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      hash = ((hash << 5) - hash) + str.charCodeAt(i);
      hash |= 0;
    }
    return Math.abs(hash);
  }

  private async getFlag(name: string): Promise<FeatureFlag | null> {
    // Check in-memory cache first
    const cached = this.cache.get(name);
    if (cached && cached.expiresAt > Date.now()) {
      return JSON.parse(cached.value as unknown as string);
    }
    try {
      const raw = await redis.get(`flag:${name}`);
      if (!raw) return null;
      const flag = JSON.parse(raw);
      this.cache.set(name, { value: raw as unknown as boolean, expiresAt: Date.now() + this.CACHE_TTL });
      return flag;
    } catch {
      return null; // Graceful degradation: Redis unavailable → return null (use default)
    }
  }
}

// Application integration — clean, centralized flag checks
const flags = new FeatureFlagService();

router.get('/checkout', async (req, res) => {
  const useNewCheckout = await flags.isEnabled('new-checkout-flow', { userId: req.user.id });

  if (useNewCheckout) {
    return res.render('checkout-v2');
  }
  return res.render('checkout-v1');
});
```

Flag configuration (stored in Redis as JSON):
```json
{
  "name": "new-checkout-flow",
  "enabled": true,
  "rolloutPercentage": 10,
  "allowlist": ["user_beta_1", "user_beta_2"],
  "denylist": [],
  "owner": "checkout-team",
  "plannedRemovalDate": "2026-06-01"
}
```

Cleanup Checklist (when removing `new-checkout-flow` after 100% rollout):
1. Search codebase for `'new-checkout-flow'` references
2. Remove all `if (useNewCheckout)` branches — keep the new behavior
3. Delete the flag from Redis
4. Delete the flag definition from code
5. Remove old checkout-v1 template


**Expected Output Shape:**
```python
from dataclasses import dataclass
from enum import Enum

class FlagType(str, Enum):
    BOOLEAN = "boolean"
    PERCENTAGE = "percentage"
    ATTRIBUTE = "attribute"

@dataclass
class EvaluationContext:
    user_id: str
    attributes: dict  # e.g., {"subscription_tier": "premium", "country": "US"}

class FeatureFlagService:
    def __init__(self, db: Session):
        self.db = db

    def is_enabled(self, flag_name: str, context: EvaluationContext) -> bool:
        flag = self.db.query(FeatureFlag).filter_by(name=flag_name).first()
        if not flag or not flag.enabled:
            return False

        if flag.flag_type == FlagType.BOOLEAN:
            return True

        if flag.flag_type == FlagType.ATTRIBUTE:
            # Check if user attributes match the targeting rules
            rules = flag.targeting_rules  # e.g., {"subscription_tier": "premium"}
            return all(context.attributes.get(k) == v for k, v in rules.items())

        if flag.flag_type == FlagType.PERCENTAGE:
            import hashlib
            hash_val = int(hashlib.md5(f"{flag_name}:{context.user_id}".encode()).hexdigest(), 16)
            return (hash_val % 100) < flag.rollout_percentage

        return False

# Usage in endpoint
@router.get("/products/{id}/recommendations")
def get_recommendations(product_id: str, user=Depends(get_current_user), db=Depends(get_db)):
    flags = FeatureFlagService(db)
    ctx = EvaluationContext(user_id=user.id, attributes={"subscription_tier": user.tier})

    if flags.is_enabled("ai-recommendations", ctx):
        return ai_recommendation_service.get(product_id, user.id)
    return basic_recommendation_service.get(product_id)
```
