# Example Input: senior-code-review

### Example 1: Go + Gin — Payment Processing Service
**Input:**
- `{{tech_stack}}`: Go + Gin + PostgreSQL + Stripe SDK
- `{{code}}`:
```go
func ProcessPayment(c *gin.Context) {
    var req PaymentRequest
    c.BindJSON(&req)
    
    charge, err := stripe.Charges.New(&stripe.ChargeParams{
        Amount:   stripe.Int64(req.Amount),
        Currency: stripe.String(req.Currency),
        Source:   &stripe.SourceParams{Token: stripe.String(req.CardToken)},
    })
    if err != nil {
        c.JSON(500, gin.H{"error": err.Error()})
        return
    }
    
    db.Exec("INSERT INTO payments VALUES ('" + charge.ID + "', " + strconv.Itoa(int(req.Amount)) + ")")
    c.JSON(200, gin.H{"chargeId": charge.ID})
}
```
- `{{context}}`: "Production payment service. Processes ~500 payments/day. PCI-DSS compliance required. SLA: 99.9% uptime."


### Example 2: Java + Spring Boot — Order Service
**Input:**
- `{{tech_stack}}`: Java 17 + Spring Boot + JPA + Kafka
- `{{code}}`:
```java
@PostMapping("/orders")
public ResponseEntity<Order> createOrder(@RequestBody OrderRequest request) {
    User user = userRepository.findById(request.getUserId()).orElseThrow();
    List<Product> products = productRepository.findAllById(request.getProductIds());
    Order order = new Order(user, products);
    orderRepository.save(order);
    kafkaTemplate.send("order-created", order.getId().toString(), order);
    return ResponseEntity.ok(order);
}
```
- `{{context}}`: "Order service in microservices architecture. ~2000 orders/day. Kafka for downstream notifications. SLA: 99.5%."
