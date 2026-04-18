# Example Input: inline-code-comment-generation

### Example 1: TypeScript — Complex Algorithm (Leaky Bucket Rate Limiter)
**Input:**
- `{{code_snippet}}`:
  ```typescript
  export class LeakyBucket {
    private queue: Request[] = [];
    private processing = false;

    constructor(
      private readonly capacity: number,
      private readonly leakRateMs: number
    ) {}

    async add(request: Request): Promise<void> {
      if (this.queue.length >= this.capacity) {
        throw new RateLimitError('Bucket full');
      }
      this.queue.push(request);
      if (!this.processing) {
        this.processing = true;
        this.leak();
      }
    }

    private async leak(): Promise<void> {
      while (this.queue.length > 0) {
        const req = this.queue.shift()!;
        await req.execute();
        await sleep(this.leakRateMs);
      }
      this.processing = false;
    }
  }
  ```
- `{{tech_stack}}`: "TypeScript / Node.js 20"
- `{{comment_style}}`: "TSDoc + inline"
- `{{context}}`: "Used to throttle outbound calls to a third-party payment API that enforces 100 req/min. Bucket capacity is set to 50 to leave headroom for retries."


### Example 2: Python — Data Transformation Pipeline
**Input:**
- `{{code_snippet}}`:
  ```python
  def normalize_user_records(records: list[dict]) -> list[dict]:
      seen_emails = set()
      result = []

      for record in records:
          email = record.get("email", "").strip().lower()
          if not email or email in seen_emails:
              continue
          seen_emails.add(email)

          dob = record.get("dob")
          age = None
          if dob:
              try:
                  birth_date = datetime.strptime(dob, "%Y-%m-%d")
                  age = (datetime.utcnow() - birth_date).days // 365
              except ValueError:
                  pass

          result.append({
              "email": email,
              "age": age,
              "tier": "premium" if record.get("spend", 0) >= 500 else "standard",
          })

      return result
  ```
- `{{tech_stack}}`: "Python 3.11 / Django 4.2"
- `{{comment_style}}`: "Python docstrings + inline"
- `{{context}}`: "Processes raw CRM export data before import into the loyalty platform. The $500 spend threshold maps to the Premium tier definition in the loyalty program contract (v3, Section 4.2)."
