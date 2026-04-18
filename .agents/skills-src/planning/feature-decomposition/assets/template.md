# Feature Documentation: {{feature_name}}

> Template untuk mendokumentasikan spesifikasi detail sebuah fitur.

---

## Navigation
- [API Specification](../../api-documentation/)
- [Test Scenarios](../../testing/qa-design/)

---

## 1. Feature Overview

- **Description:** {{feature_description}}
- **Business Value:** {{business_value}}
- **Scope:** {{scope}}

---

## 2. User Stories

### US-01 — {{story_title}}

**As a** {{role}}
**I want** {{goal}}
**So that** {{benefit}}

**Acceptance Criteria:**
- [ ] {{criteria_1}}
- [ ] {{criteria_2}}
- [ ] {{criteria_3}}

---

## 3. Business Flow & Rules

### 3.1 Flow

```mermaid
flowchart TD
    A[{{start}}] --> B{{{decision}}}
    B -->|Yes| C[{{action_yes}}]
    B -->|No| D[{{action_no}}]
    C --> E[{{end}}]
    D --> E
```

### 3.2 Business Rules
- {{rule_1}}
- {{rule_2}}

---

## 4. Data Model

```mermaid
erDiagram
    {{entity_1}} {
        uuid id PK
        string {{field_1}}
        string {{field_2}}
        timestamp created_at
    }
    {{entity_2}} {
        uuid id PK
        uuid {{entity_1_id}} FK
        string {{field_3}}
    }
    {{entity_1}} ||--o{ {{entity_2}} : "has many"
```

---

## 5. Implementation Tasks

### Backend

| Task ID | Component | Status | Description |
|---------|-----------|--------|-------------|
| {{MOD}}-BE-01 | Migration | Todo | Create {{table_name}} table |
| {{MOD}}-BE-02 | Model | Todo | Setup model & relations |
| {{MOD}}-BE-03 | Service | Todo | Implement business logic |
| {{MOD}}-BE-04 | Controller | Todo | Implement API endpoints |
| {{MOD}}-BE-05 | Tests | Todo | Feature tests (Positive/Negative) |

### Frontend

| Task ID | Component | Status | Description |
|---------|-----------|--------|-------------|
| {{MOD}}-FE-01 | State | Todo | Setup store |
| {{MOD}}-FE-02 | API Service | Todo | HTTP wrapper |
| {{MOD}}-FE-03 | Components | Todo | UI components |
| {{MOD}}-FE-04 | Pages | Todo | Assemble pages |
| {{MOD}}-FE-05 | Integration | Todo | Connect & handle errors |
