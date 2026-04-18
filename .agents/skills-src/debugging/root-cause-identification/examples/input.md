# Example Input: root-cause-identification

### Example 1: Java + Spring Boot + MySQL
**Input:**
- `{{tech_stack}}`: Java + Spring Boot + MySQL
- `{{bug_description}}`: Users intermittently receive 500 errors on the checkout endpoint
- `{{symptoms}}`: DB connection pool exhaustion errors in logs; errors spike during peak traffic; no errors in off-peak hours
- `{{context}}`: Checkout service opens a DB connection per request; connection pool size is 10; average checkout takes 800ms


### Example 2: Go + Gin + Redis
**Input:**
- `{{tech_stack}}`: Go + Gin + Redis
- `{{bug_description}}`: Session tokens are invalidated unexpectedly, logging users out randomly
- `{{symptoms}}`: Redis TTL on session keys is shorter than expected; issue occurs only on certain server instances
- `{{context}}`: Session TTL is set to 24 hours; two app instances share the same Redis cluster; recent deployment changed session middleware
