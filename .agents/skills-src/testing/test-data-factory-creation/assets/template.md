# Test Data Factory Specification Template

> Fill in all fields before activating the `test-data-factory-creation` skill.

---

## Entity to Factory

**Entity Name:** `{{e.g. User, Order, Product}}`

**Tech Stack:** {{e.g. TypeScript + Jest, Python + pytest, PHP + Laravel}}

**Factory Library:** {{e.g. fishery (TS), factory_boy (Python), Laravel factories, custom}}

---

## Entity Schema

```{{language}}
{{paste the model/interface/schema definition}}
```

| Field | Type | Default in Factory | Notes |
|-------|------|-------------------|-------|
| `id` | uuid | auto-generated | |
| `{{field}}` | {{type}} | {{e.g. faker.name()}} | {{notes}} |
| `{{field}}` | {{type}} | {{e.g. "active"}} | {{e.g. enum: active/inactive}} |
| `createdAt` | Date | `new Date()` | |

---

## Factory Traits / States

| Trait | Description | Overrides |
|-------|-------------|-----------|
| `withAdmin` | Admin user | `{ role: "admin" }` |
| `inactive` | Deactivated user | `{ status: "inactive", deletedAt: new Date() }` |
| `{{trait}}` | {{description}} | `{{ field overrides }}` |

---

## Relationships

| Relation | Type | Factory |
|----------|------|---------|
| `{{e.g. orders}}` | has many | `OrderFactory` |
| `{{e.g. organization}}` | belongs to | `OrganizationFactory` |

---

## Usage Examples

```{{language}}
// Single instance
const user = UserFactory.build();

// With overrides
const admin = UserFactory.build({ role: "admin" });

// With trait
const inactive = UserFactory.inactive().build();

// Persist to DB
const savedUser = await UserFactory.create();

// Multiple
const users = UserFactory.buildList(5);
```

---

## Faker Locale

**Locale:** {{e.g. en, id, ja}}

**Seed (for reproducibility in CI):** {{e.g. faker.seed(12345)}}
