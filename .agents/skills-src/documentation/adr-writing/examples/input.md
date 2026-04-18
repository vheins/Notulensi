# Example Input: adr-writing

### Example 1: Message Queue — Kafka vs RabbitMQ vs SQS
**Input:**
- `{{decision_title}}`: "Use Kafka for async event streaming between microservices"
- `{{context_description}}`: "Our platform processes 50k+ order events per minute across 12 microservices. We need durable, replayable event streams with at-least-once delivery. The team has experience with JVM-based tooling. We are on AWS but want to avoid deep vendor lock-in."
- `{{chosen_option}}`: "Apache Kafka, self-managed on Kubernetes using Strimzi operator"
- `{{alternatives}}`: "RabbitMQ (traditional message broker), Amazon SQS (managed AWS queue service)"
- `{{tech_stack}}`: "Java/Spring Boot microservices, Kubernetes on AWS EKS, PostgreSQL"


### Example 2: Frontend State Management — Redux vs Zustand vs Context API
**Input:**
- `{{decision_title}}`: "Adopt Zustand for global state management in React frontend"
- `{{context_description}}`: "React SPA with 40+ components sharing auth state, cart, and user preferences. Redux was considered too boilerplate-heavy for team size of 3. Context API caused re-render performance issues."
- `{{chosen_option}}`: "Zustand — minimal boilerplate, built-in devtools, no provider wrapping"
- `{{alternatives}}`: "Redux Toolkit (mature but verbose), React Context + useReducer (no extra deps but performance issues)"
