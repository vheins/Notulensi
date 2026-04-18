# Example Output: graphql-schema-generation

**Expected Output Shape:**
```graphql
# schema.graphql

# Pagination
type PageInfo {
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
  endCursor: String
}

# Core types
type User {
  id: ID!
  email: String!
  name: String!
  orders(first: Int, after: String): OrderConnection!
  reviews: [Review!]!
  createdAt: DateTime!
}

type Product {
  id: ID!
  name: String!
  description: String
  price: Float!
  category: Category!
  reviews(first: Int, after: String): ReviewConnection!
  averageRating: Float
  inStock: Boolean!
}

type Order {
  id: ID!
  user: User!
  items: [OrderItem!]!
  total: Float!
  status: OrderStatus!
  createdAt: DateTime!
  updatedAt: DateTime!
}

type OrderItem {
  product: Product!
  quantity: Int!
  unitPrice: Float!
}

type Review {
  id: ID!
  author: User!
  product: Product!
  rating: Int!  # 1-5
  body: String
  createdAt: DateTime!
}

enum OrderStatus { PENDING CONFIRMED SHIPPED DELIVERED CANCELLED }

# Connection types for pagination
type ProductConnection { edges: [ProductEdge!]! pageInfo: PageInfo! totalCount: Int! }
type ProductEdge { node: Product! cursor: String! }
type OrderConnection { edges: [OrderEdge!]! pageInfo: PageInfo! totalCount: Int! }
type OrderEdge { node: Order! cursor: String! }

# Mutation inputs
input CreateOrderInput {
  items: [OrderItemInput!]!  # min 1 item
}
input OrderItemInput {
  productId: ID!
  quantity: Int!  # min 1
}
input AddReviewInput {
  productId: ID!
  rating: Int!  # 1-5
  body: String
}

# Mutation payloads — include errors for client-side error handling
type CreateOrderPayload {
  order: Order
  errors: [UserError!]!
}
type UserError { field: String message: String! code: String! }

# Queries
type Query {
  product(id: ID!): Product
  products(categoryId: ID, first: Int, after: String): ProductConnection!
  order(id: ID!): Order
  me: User
}

# Mutations
type Mutation {
  createOrder(input: CreateOrderInput!): CreateOrderPayload!
  addReview(input: AddReviewInput!): Review!
  updateProduct(id: ID!, input: UpdateProductInput!): Product!
}

# Subscriptions
type Subscription {
  orderStatusUpdated(orderId: ID!): Order!
}

scalar DateTime
```

Resolver Outline:
- `Query.products`: Use DataLoader for category batch loading
- `Order.items`: N+1 risk — use DataLoader keyed by orderId
- `Product.averageRating`: Computed field — aggregate query or cached value
- Auth: Check `context.user` in `Query.me`, `Mutation.createOrder`, `Mutation.addReview`


**Expected Output Shape:**
```python
import strawberry
from typing import Optional, List
from datetime import datetime

@strawberry.enum
class PostStatus:
    DRAFT = "draft"
    PUBLISHED = "published"

@strawberry.type
class Author:
    id: strawberry.ID
    name: str
    bio: Optional[str]
    posts: List["Post"]

@strawberry.type
class Post:
    id: strawberry.ID
    title: str
    slug: str
    body: str
    status: PostStatus
    author: Author
    tags: List[str]
    comments: List["Comment"]
    published_at: Optional[datetime]
    created_at: datetime

@strawberry.type
class Comment:
    id: strawberry.ID
    body: str
    author_name: str
    post: Post
    created_at: datetime

@strawberry.input
class CreatePostInput:
    title: str
    body: str
    tags: List[str] = strawberry.field(default_factory=list)

@strawberry.input
class AddCommentInput:
    post_id: strawberry.ID
    body: str
    author_name: str

@strawberry.type
class Query:
    @strawberry.field
    def posts(self, first: int = 20, after: Optional[str] = None) -> List[Post]: ...
    @strawberry.field
    def post(self, slug: str) -> Optional[Post]: ...
    @strawberry.field
    def author(self, id: strawberry.ID) -> Optional[Author]: ...

@strawberry.type
class Mutation:
    @strawberry.mutation
    def create_post(self, input: CreatePostInput, info: strawberry.types.Info) -> Post: ...
    @strawberry.mutation
    def publish_post(self, id: strawberry.ID, info: strawberry.types.Info) -> Post: ...
    @strawberry.mutation
    def add_comment(self, input: AddCommentInput) -> Comment: ...

schema = strawberry.Schema(query=Query, mutation=Mutation)
```
