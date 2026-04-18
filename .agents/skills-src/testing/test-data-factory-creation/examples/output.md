# Example Output: test-data-factory-creation

## Example 1: User model factory

```typescript
// tests/factories/user.factory.ts
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';
import { prisma } from '../../src/db';
import type { User } from '@prisma/client';

export const UserFactory = Factory.define<User>(({ sequence, transientParams }) => ({
  id: faker.string.uuid(),
  name: faker.person.fullName(),
  email: faker.internet.email({ provider: `test-${sequence}.example.com` }),
  role: 'user',
  status: 'active',
  createdAt: new Date(),
  updatedAt: new Date(),
}));

// Traits
export const AdminUserFactory = UserFactory.params({ role: 'admin' });
export const InactiveUserFactory = UserFactory.params({ status: 'inactive' });
export const LongNameUserFactory = UserFactory.params({ name: 'A'.repeat(255) });

// DB-persisted factory
export const createUser = async (overrides: Partial<User> = {}) => {
  const data = UserFactory.build(overrides);
  return prisma.user.create({ data });
};

// Usage examples:
// const user = UserFactory.build();                          // in-memory
// const admin = AdminUserFactory.build();                    // admin trait
// const users = UserFactory.buildList(5);                   // multiple
// const dbUser = await createUser({ role: 'admin' });       // persisted
// const inactive = InactiveUserFactory.build({ name: 'Bob' }); // trait + override
```

**Usage in tests**

```typescript
import { UserFactory, AdminUserFactory, createUser } from '../factories/user.factory';

describe('UserService', () => {
  it('returns user by id', async () => {
    const user = await createUser();
    const result = await userService.findById(user.id);
    expect(result).toMatchObject({ id: user.id, email: user.email });
  });

  it('admin can access all users', async () => {
    const admin = AdminUserFactory.build();
    expect(admin.role).toBe('admin');
    // use admin.id in auth token generation
  });
});
```
