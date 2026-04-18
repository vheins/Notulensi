# Template: domain-modeling

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Domain Model: {{bounded_context}}

**Domain Description:** {{domain_description}}

**Tech Stack:** {{tech_stack}}

---

### 1. Entity Definitions

**{{entity_name}} (Aggregate Root)**
- Identity: {{identity_field}} ({{identity_type}})
- Attributes: {{attribute_list}}
- Invariants: {{invariants}}
- Lifecycle: {{lifecycle_states}}

### 2. Value Objects

**{{value_object_name}}**
- Attributes: {{vo_attributes}}
- Why value object: {{vo_rationale}}
- Validation: {{vo_validation}}

### 3. Aggregate Roots

**{{aggregate_name}} Aggregate**
- Root: {{root_entity}}
- Contains: {{contained_entities}}
- Invariants enforced: {{aggregate_invariants}}
- Boundary rationale: {{boundary_rationale}}

### 4. Domain Events

**{{event_name}}**
- Trigger: {{event_trigger}}
- Payload: {{event_payload}}
- Consumers: {{event_consumers}}

### 5. Repository Interfaces

```{{language}}
interface {{repository_name}} {
  findById(id: {{id_type}}): Promise<{{entity_type}} | null>
  save(entity: {{entity_type}}): Promise<void>
}
```

### 6. Ubiquitous Language Glossary

- **{{term_1}}**: {{definition_1}}
- **{{term_2}}**: {{definition_2}}
- **{{term_3}}**: {{definition_3}}
