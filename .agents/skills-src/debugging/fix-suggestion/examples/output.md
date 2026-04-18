# Example Output: fix-suggestion

**Expected Output Shape:**
```
1. Fix Explanation
TypeORM does not cascade deletes by default. Without cascade: ['remove'], deleting a User entity leaves Order records with a dangling foreign key. Adding cascade: ['remove'] instructs TypeORM to issue DELETE statements for related orders before deleting the user.

2. Before Code
@OneToMany(() => Order, order => order.user)  // missing cascade
orders: Order[];

3. After Code
@OneToMany(() => Order, order => order.user, { cascade: ['remove'] })  // cascade delete added
orders: Order[];

4. Fix Checklist
- No migration needed (cascade is handled at ORM level, not DB schema level)
- Verify ON DELETE behavior in DB schema matches expected behavior
- Update API documentation to note that user deletion removes all orders

5. Test Case
it('deletes associated orders when user is deleted', async () => {
  const user = await userRepo.save({ name: 'Test' });
  await orderRepo.save({ user, total: 100 });
  await userRepo.remove(user);
  const orders = await orderRepo.find({ where: { user: { id: user.id } } });
  expect(orders).toHaveLength(0);
});

6. Regression Risk
Any code that relies on orders persisting after user deletion (e.g., audit logs, analytics) must be reviewed.
```


**Expected Output Shape:**
```
1. Fix Explanation
The check-then-act pattern without a lock creates a race condition. Two requests can both pass the used? check before either writes. The fix uses a database-level advisory lock (with_lock) to serialize access to the coupon record.

2. Before Code
coupon = Coupon.find_by(code: coupon_code)
return false if coupon.used?       # race window here
coupon.update!(used: true)

3. After Code
coupon = Coupon.find_by(code: coupon_code)
coupon.with_lock do                # acquires row-level lock
  return false if coupon.used?
  coupon.update!(used: true)
end

4. Fix Checklist
- Ensure the coupons table has an index on the code column for lock performance
- Add a unique constraint on code column if not already present

5. Test Case
it 'prevents double redemption under concurrent requests' do
  coupon = create(:coupon, code: 'SAVE10', used: false)
  threads = 2.times.map { Thread.new { CouponService.redeem('SAVE10') } }
  results = threads.map(&:value)
  expect(results.count(true)).to eq(1)
  expect(coupon.reload.used).to be true
end

6. Regression Risk
Any other coupon operations (transfer, expiry) that read-then-write should be audited for the same race condition.
```
