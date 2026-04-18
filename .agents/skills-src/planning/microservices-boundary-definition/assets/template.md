# Template: microservices-boundary-definition

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Microservices Boundary Definition: {{system_name}}

**Domain Description:** {{domain_description}}

**Tech Stack:** {{tech_stack}}

**Team Structure:** {{team_structure}}

---

### 1. Service List

| Service | Responsibility | Key Operations | Data Owned | Team |
|---------|---------------|----------------|------------|------|
| {{service_1}} | {{responsibility_1}} | {{operations_1}} | {{data_1}} | {{team_1}} |
| {{service_2}} | {{responsibility_2}} | {{operations_2}} | {{data_2}} | {{team_2}} |

### 2. Boundary Rationale

**{{service_1}} boundary**: Maps to "{{bounded_context_1}}" bounded context. {{rationale_1}}

### 3. Inter-Service Communication

| Source | Target | Pattern | Contract | Rationale |
|--------|--------|---------|----------|-----------|
| {{source_1}} | {{target_1}} | {{pattern_1}} | {{contract_1}} | {{rationale_1}} |
| {{source_2}} | {{target_2}} | {{pattern_2}} | {{contract_2}} | {{rationale_2}} |

### 4. Data Ownership Map

- **{{entity_1}}**: owned by {{owner_1}}; read by {{readers_1}} via {{access_method_1}}; consistency: {{consistency_1}}
- **{{entity_2}}**: owned by {{owner_2}}; read by {{readers_2}} via {{access_method_2}}; consistency: {{consistency_2}}

### 5. Migration Strategy

- Extraction order: {{extraction_order}}
- Strangler fig: {{strangler_fig_approach}}
- Database decomposition: {{db_decomposition}}
- Rollback: {{rollback_strategy}}
