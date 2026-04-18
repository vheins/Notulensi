# Example Output: performance-optimization

**Expected Output Shape:**
```
Bottleneck Analysis:
1. Nested loop: O(n²) comparisons — 10,000 users = 50M iterations
2. Array.includes() inside inner loop: O(n) scan on duplicates array — makes it O(n³) in worst case
3. Called on every request with no caching

Optimized Implementation:
```typescript
function findDuplicateUsers(users: User[]): User[] {
  // Use Map for O(1) email lookup instead of O(n) nested loop
  const emailCount = new Map<string, number>();
  for (const user of users) {
    emailCount.set(user.email, (emailCount.get(user.email) ?? 0) + 1);
  }

  // Single pass to collect duplicates — O(n) total
  const seen = new Set<string>();
  return users.filter(user => {
    if (emailCount.get(user.email)! > 1 && !seen.has(user.email)) {
      seen.add(user.email);
      return true;
    }
    return false;
  });
}
```

Complexity: O(n) time, O(n) space — vs O(n³) original
Expected improvement: 10,000 users: 8s → <1ms

Benchmark (Node.js):
```typescript
import { performance } from 'perf_hooks';
const users = Array.from({ length: 10000 }, (_, i) => ({
  email: i % 100 === 0 ? `dup${i % 10}@test.com` : `user${i}@test.com`
}));
const start = performance.now();
findDuplicateUsers(users);
console.log(`${performance.now() - start}ms`);
```
```


**Expected Output Shape:**
```
Bottleneck Analysis:
1. N+1 query pattern: 1 query for orders + N queries for items + N*M queries for products
   With 50 orders × 5 items each = 1 + 50 + 250 = 301 queries per request
2. No deduplication: same product fetched multiple times if ordered more than once

Optimized Implementation:
```go
func GetProductRecommendations(c *gin.Context) {
    userID := c.Param("userId")

    // Single query with joins — replaces 301 queries with 1
    var productIDs []uint
    db.Model(&OrderItem{}).
        Joins("JOIN orders ON orders.id = order_items.order_id").
        Where("orders.user_id = ?", userID).
        Distinct("order_items.product_id").
        Pluck("order_items.product_id", &productIDs)

    if len(productIDs) == 0 {
        c.JSON(200, []Product{})
        return
    }

    // Fetch all unique products in one query
    var recommendations []Product
    db.Where("id IN ?", productIDs).Find(&recommendations)

    c.JSON(200, recommendations)
}
```

Complexity: O(1) queries (2 total) vs O(n*m) original
Expected improvement: 2.3s → ~15ms

Further Opportunities:
- Add Redis cache with 5-minute TTL (worthwhile if recommendations are requested frequently)
- Add database index on order_items.order_id (check if missing)
```
