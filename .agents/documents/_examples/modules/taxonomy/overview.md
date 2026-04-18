# Module: Taxonomy

## Navigation
- [Module List](../../README.md)

## 1. Intro
- **Role:** Entity-agnostic classification (categories, tags, labels).
- **Value:** Ensures consistency; eliminates redundant category logic across domains.

## 2. Features
- **Taxonomy Management:** Hierarchy, tags, and polymorphic attachments. [Details](./taxonomy-management.md)

## 3. Architecture
```mermaid
flowchart LR
    Client["Client"]
    API["Taxonomy API"]
    DB[("Taxonomy Store")]
    Entity["Entity\n(Product, User...)"]
    Client --> API
    API --> DB
    DB --> Entity
```

## 4. Deps
- **Store:** Relational DB (FK integrity required).

```