# Example Output: inline-code-comment-generation

**Expected Output Shape:**
```typescript
export class LeakyBucket {
  private queue: Request[] = [];
  // Single flag avoids spawning multiple concurrent leak loops if add() is
  // called rapidly before the first loop iteration completes.
  private processing = false;

  /**
   * @param capacity  Max requests held in the bucket at once. Set below the
   *                  provider's hard limit to reserve headroom for retries.
   * @param leakRateMs Interval between dispatched requests in ms.
   *                   Derived from provider rate limit: 100 req/min → 600ms/req.
   */
  constructor(
    private readonly capacity: number,
    private readonly leakRateMs: number
  ) {}

  async add(request: Request): Promise<void> {
    // Reject early rather than queue indefinitely — callers must implement
    // their own retry with backoff. Silently dropping requests here would
    // cause data loss in the payment flow.
    if (this.queue.length >= this.capacity) {
      throw new RateLimitError('Bucket full');
    }
    this.queue.push(request);
    // Only start the leak loop once; subsequent add() calls rely on the
    // already-running loop to drain the queue.
    if (!this.processing) {
      this.processing = true;
      this.leak();
    }
  }

  private async leak(): Promise<void> {
    while (this.queue.length > 0) {
      const req = this.queue.shift()!;
      await req.execute();
      // Fixed delay enforces the outbound rate regardless of how fast
      // execute() resolves. If the provider raises its limit, update
      // leakRateMs at the call site — do not change this logic.
      await sleep(this.leakRateMs);
    }
    // Reset flag so the next add() call can restart the loop cleanly.
    this.processing = false;
  }
}
```


**Expected Output Shape:**
```python
def normalize_user_records(records: list[dict]) -> list[dict]:
    """
    Normalize and deduplicate raw CRM export records for loyalty platform import.

    Deduplication is email-based (case-insensitive). Records with missing or
    duplicate emails are silently dropped — callers should log the input count
    vs. output count to detect unexpected data loss upstream.

    Args:
        records: Raw dicts from CRM export. Expected keys: email, dob, spend.

    Returns:
        List of normalized dicts with keys: email, age, tier.
    """
    # Set lookup is O(1) vs O(n) for list — necessary because CRM exports
    # can contain tens of thousands of records with ~15% duplicate rate.
    seen_emails = set()
    result = []

    for record in records:
        # Normalize to lowercase to treat "User@Example.com" and
        # "user@example.com" as the same identity across CRM sources.
        email = record.get("email", "").strip().lower()
        if not email or email in seen_emails:
            # Skip rather than raise — malformed CRM exports are common;
            # a single bad record should not abort the entire import batch.
            continue
        seen_emails.add(email)

        dob = record.get("dob")
        age = None
        if dob:
            try:
                birth_date = datetime.strptime(dob, "%Y-%m-%d")
                # Integer division gives age in whole years. Using utcnow()
                # for consistency with the loyalty platform's UTC-based
                # birthday reward trigger — do not switch to local time.
                age = (datetime.utcnow() - birth_date).days // 365
            except ValueError:
                # Leave age as None rather than crashing; the loyalty platform
                # accepts null age and skips age-gated offers for that user.
                pass

        result.append({
            "email": email,
            "age": age,
            # $500 threshold defined in loyalty program contract v3, Section 4.2.
            # Update this value only after contract amendment — coordinate with
            # the loyalty team before changing.
            "tier": "premium" if record.get("spend", 0) >= 500 else "standard",
        })

    return result
```
