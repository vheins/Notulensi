# Example Output: null-pointer-undefined-analysis

**Expected Output Shape:**
```
1. Null Source Identification
Two null sources:
- user is undefined during loading (async data not yet fetched)
- user.profile may be null/undefined (optional nested object)

2. Access Point
user.profile.firstName — fails when user is undefined (loading state) or when profile is not set

3. Fix with Defensive Pattern
Before:
  return <div>{user.profile.firstName}</div>;

After (optional chaining + loading guard):
  if (!user) return <div>Loading...</div>;
  return <div>{user?.profile?.firstName ?? 'Unknown'}</div>;

TypeScript type improvement:
  interface User { profile?: { firstName?: string } | null }

4. Null Object Pattern
Consider a default user object for loading state:
  const DEFAULT_USER = { profile: { firstName: 'Loading...' } };
  const user = useUser(userId) ?? DEFAULT_USER;

5. Type Safety
Enable strictNullChecks in tsconfig.json — TypeScript will flag user.profile.firstName as a compile error when profile is typed as optional.
```


**Expected Output Shape:**
```
1. Null Source Identification
Two null sources:
- orderRepo.findById(id).get() throws NoSuchElementException if order not found
- order.getCustomer() returns null for legacy orders with null customer_id

2. Access Point
order.getCustomer().getEmail() — NullPointerException when getCustomer() returns null

3. Fix with Defensive Pattern
Before:
  Order order = orderRepo.findById(id).get();
  String email = order.getCustomer().getEmail();

After (Optional + null-safe chain):
  Order order = orderRepo.findById(id)
      .orElseThrow(() -> new OrderNotFoundException(id));
  String email = Optional.ofNullable(order.getCustomer())
      .map(Customer::getEmail)
      .orElse("no-email@unknown.com");

4. Null Object Pattern
Create a GuestCustomer null object:
  Customer customer = order.getCustomer() != null ? order.getCustomer() : GuestCustomer.INSTANCE;
  String email = customer.getEmail();  // GuestCustomer.getEmail() returns "guest@unknown.com"

5. Type Safety
Add @NonNull/@Nullable annotations (Lombok/JetBrains) to getCustomer() return type.
Consider making customer_id NOT NULL in the schema for new orders.
```
