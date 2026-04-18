# Example Input: fix-suggestion

### Example 1: TypeScript + NestJS + TypeORM
**Input:**
- `{{tech_stack}}`: TypeScript + NestJS + TypeORM
- `{{bug_description}}`: Deleting a user does not cascade-delete their associated orders, leaving orphaned records in the orders table
- `{{code}}`: `@Entity() export class User { @OneToMany(() => Order, order => order.user) orders: Order[]; }`
- `{{root_cause}}`: The OneToMany relationship is missing the cascade delete option


### Example 2: Ruby on Rails + PostgreSQL
**Input:**
- `{{tech_stack}}`: Ruby on Rails + PostgreSQL
- `{{bug_description}}`: Race condition in coupon redemption — two concurrent requests can both redeem the same single-use coupon
- `{{code}}`: `def redeem(coupon_code)\n  coupon = Coupon.find_by(code: coupon_code)\n  return false if coupon.used?\n  coupon.update!(used: true)\nend`
- `{{root_cause}}`: No database-level lock between the read (find_by) and write (update!) operations
