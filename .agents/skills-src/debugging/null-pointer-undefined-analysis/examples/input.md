# Example Input: null-pointer-undefined-analysis

### Example 1: TypeScript + React + REST API
**Input:**
- `{{tech_stack}}`: TypeScript + React
- `{{error_message}}`: `TypeError: Cannot read properties of undefined (reading 'firstName')`
- `{{code}}`: `const UserCard = ({ userId }) => { const user = useUser(userId); return <div>{user.profile.firstName}</div>; }`
- `{{context}}`: useUser hook returns undefined while the API request is in flight; profile is an optional nested object


### Example 2: Java + Spring Boot + JPA
**Input:**
- `{{tech_stack}}`: Java + Spring Boot + JPA
- `{{error_message}}`: `NullPointerException at OrderService.java:45: order.getCustomer().getEmail()`
- `{{code}}`: `Order order = orderRepo.findById(id).get();\nString email = order.getCustomer().getEmail();`
- `{{context}}`: Some legacy orders in the database have a null customer_id foreign key; findById().get() throws if not found
