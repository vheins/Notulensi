# Example Output: rest-to-graphql-migration

**Expected Output Shape:**
```
REST to GraphQL Mapping:
GET /users/:id          → Query.user(id: ID!): User
GET /users/:id/posts    → User.posts (nested resolver, eliminates separate endpoint)
POST /posts             → Mutation.createPost(input: CreatePostInput!): Post
PUT /posts/:id          → Mutation.updatePost(id: ID!, input: UpdatePostInput!): Post
DELETE /posts/:id       → Mutation.deletePost(id: ID!): Boolean!
GET /posts?userId=...   → Query.posts(userId: ID, first: Int, after: String): PostConnection!
```

```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts(first: Int, after: String): PostConnection!
  createdAt: DateTime!
}

type Post {
  id: ID!
  title: String!
  body: String!
  author: User!
  publishedAt: DateTime
  createdAt: DateTime!
}

type PostConnection { edges: [PostEdge!]! pageInfo: PageInfo! totalCount: Int! }
type PostEdge { node: Post! cursor: String! }

input CreatePostInput { title: String! body: String! userId: ID! }
input UpdatePostInput { title: String body: String }

type Query {
  user(id: ID!): User
  posts(userId: ID, first: Int, after: String): PostConnection!
}

type Mutation {
  createPost(input: CreatePostInput!): Post!
  updatePost(id: ID!, input: UpdatePostInput!): Post!
  deletePost(id: ID!): Boolean!
}
```

Resolver sharing existing service layer:
```typescript
// Resolvers call the SAME PostService used by REST handlers
const resolvers = {
  Query: {
    user: (_, { id }) => userService.findById(id),
    posts: (_, { userId, first, after }) => postService.findPaginated({ userId, first, after }),
  },
  User: {
    posts: (user, { first, after }) => postService.findByUser(user.id, { first, after }),
  },
  Mutation: {
    createPost: (_, { input }, { user }) => postService.create({ ...input, authorId: user.id }),
    updatePost: (_, { id, input }, { user }) => postService.update(id, input, user.id),
    deletePost: (_, { id }, { user }) => postService.delete(id, user.id),
  },
};
```

Coexistence: REST endpoints remain active. Add header to REST responses:
`Deprecation: true` and `Sunset: Sat, 01 Jan 2026 00:00:00 GMT`

Client Migration (before/after):
```
Before: GET /users/123/posts?page=2&limit=10
After:  query { user(id: "123") { posts(first: 10, after: "cursor_from_prev_page") { edges { node { id title } } pageInfo { hasNextPage endCursor } } } }
```


**Expected Output Shape:**
```python
# GraphQL schema consolidates /products and /categories into nested types
@strawberry.type
class Category:
    id: strawberry.ID
    name: str
    products: List["Product"]  # Eliminates GET /categories/:id/products

@strawberry.type
class Product:
    id: strawberry.ID
    name: str
    price: float
    category: Category  # Eliminates separate category lookup

@strawberry.input
class CreateProductInput:
    name: str
    price: float
    category_id: strawberry.ID

@strawberry.type
class Query:
    @strawberry.field
    def products(self) -> List[Product]:
        return product_service.find_all()  # Reuses existing service

    @strawberry.field
    def product(self, id: strawberry.ID) -> Optional[Product]:
        return product_service.find_by_id(id)

    @strawberry.field
    def categories(self) -> List[Category]:
        return category_service.find_all()

@strawberry.type
class Mutation:
    @strawberry.mutation
    def create_product(self, input: CreateProductInput) -> Product:
        return product_service.create(input)
```

Client Migration:
```
Before: GET /products/123 + GET /categories/456 (2 requests)
After:  query { product(id: "123") { name price category { name } } } (1 request)
```
