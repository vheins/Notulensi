# Example Input: performance-optimization

### Example 1: TypeScript + Node.js — Array Processing
**Input:**
- `{{tech_stack}}`: TypeScript + Node.js
- `{{code}}`:
```typescript
function findDuplicateUsers(users: User[]): User[] {
  const duplicates: User[] = [];
  for (let i = 0; i < users.length; i++) {
    for (let j = i + 1; j < users.length; j++) {
      if (users[i].email === users[j].email && !duplicates.includes(users[i])) {
        duplicates.push(users[i]);
      }
    }
  }
  return duplicates;
}
```
- `{{performance_issue}}`: "Takes 8 seconds for 10,000 users. Called on every API request."


### Example 2: Go — HTTP Handler Optimization
**Input:**
- `{{tech_stack}}`: Go + Gin
- `{{code}}`:
```go
func GetProductRecommendations(c *gin.Context) {
    userID := c.Param("userId")
    var orders []Order
    db.Where("user_id = ?", userID).Find(&orders)
    
    var recommendations []Product
    for _, order := range orders {
        var items []OrderItem
        db.Where("order_id = ?", order.ID).Find(&items)
        for _, item := range items {
            var product Product
            db.First(&product, item.ProductID)
            recommendations = append(recommendations, product)
        }
    }
    c.JSON(200, recommendations)
}
```
- `{{performance_issue}}`: "P99 latency 2.3 seconds for users with 50+ orders. DB shows 200+ queries per request."
