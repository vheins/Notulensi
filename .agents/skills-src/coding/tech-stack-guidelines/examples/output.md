# Example Output: tech-stack-guidelines

## Example 1: Laravel — Multi-tenant SaaS

**Folder Structure**
```
app/
├── Http/
│   ├── Controllers/        # thin — delegate to services
│   ├── Requests/           # FormRequest validation
│   └── Middleware/         # auth, tenant resolution
├── Services/               # business logic
├── Repositories/           # DB queries (optional, for complex queries)
├── Models/                 # Eloquent models
├── Events/ + Listeners/    # domain events
└── Policies/               # authorization
```

**Service Layer Pattern**
```php
// Controller — thin, delegates to service
class OrderController extends Controller {
    public function store(CreateOrderRequest $request, OrderService $service) {
        $order = $service->create($request->validated());
        return new OrderResource($order);
    }
}

// Service — business logic
class OrderService {
    public function create(array $data): Order {
        return DB::transaction(function () use ($data) {
            // business logic here
        });
    }
}
```

**Multi-tenancy Convention**
- Resolve tenant from subdomain in middleware: `TenantMiddleware`
- Scope all queries: `Order::where('tenant_id', tenant()->id)`
- Use `GlobalScope` on models for automatic tenant scoping

**Auth Conventions**
- `sanctum` for API tokens, `breeze`/`jetstream` for web
- Policies for authorization: `$this->authorize('update', $order)`
- Never check roles in controllers — use policies

---

## Example 2: Next.js — E-commerce with App Router

**Folder Structure**
```
app/
├── (shop)/                 # route group — public storefront
│   ├── products/[slug]/
│   └── cart/
├── (auth)/                 # route group — auth pages
├── api/                    # API routes
└── layout.tsx
components/
├── ui/                     # shadcn/ui primitives
├── shop/                   # domain components
└── shared/                 # cross-domain
lib/
├── db.ts                   # Prisma client
└── auth.ts                 # NextAuth config
```

**Data Fetching Patterns**
- Server Components: fetch directly in component (no useEffect)
- Client Components: only for interactivity (cart, forms)
- `cache()` for deduplication, `revalidatePath()` for mutations
