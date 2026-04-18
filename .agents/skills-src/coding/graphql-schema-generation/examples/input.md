# Example Input: graphql-schema-generation

### Example 1: Node.js + Apollo Server — E-Commerce
**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + Apollo Server 4 + Prisma
- `{{domain_description}}`: "E-commerce platform with Users, Products (with categories), Orders (with line items), and Reviews. Users can place orders and write reviews."
- `{{operations}}`: "Queries: get product, list products by category, get order, user's order history. Mutations: create order, add review, update product. Subscriptions: order status updates."


### Example 2: Python + Strawberry — Blog Platform
**Input:**
- `{{tech_stack}}`: Python + Strawberry + FastAPI + SQLAlchemy
- `{{domain_description}}`: "Blog platform with Authors, Posts (with tags), Comments. Posts can be published or draft."
- `{{operations}}`: "Queries: list published posts, post by slug, author profile. Mutations: create post, publish post, add comment. No subscriptions needed."
