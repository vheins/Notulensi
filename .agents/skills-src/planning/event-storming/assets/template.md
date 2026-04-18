# Template: event-storming

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Event Storming: {{business_process}}

**Domain:** {{domain_description}}

---

### 1. Domain Events (Orange)

- **{{event_1}}** — {{when_1}}; payload: {{payload_1}}
- **{{event_2}}** — {{when_2}}; payload: {{payload_2}}
- **{{event_3}}** — {{when_3}}; payload: {{payload_3}}

### 2. Commands (Blue)

- **{{command_1}}** — issued by: {{actor_1}}; produces: {{event_1}}; precondition: {{precondition_1}}
- **{{command_2}}** — issued by: {{actor_2}}; produces: {{event_2}}; precondition: {{precondition_2}}

### 3. Aggregates (Yellow)

- **{{aggregate_1}}** — handles: {{commands_1}}; emits: {{events_1}}; invariant: {{invariant_1}}
- **{{aggregate_2}}** — handles: {{commands_2}}; emits: {{events_2}}; invariant: {{invariant_2}}

### 4. Bounded Contexts

- **{{context_1}}**: {{aggregates_1}}; produces: {{produced_events_1}}; consumes: {{consumed_events_1}}
- **{{context_2}}**: {{aggregates_2}}; produces: {{produced_events_2}}; consumes: {{consumed_events_2}}

### 5. Event Flow Timeline

1. {{actor_1}} issues {{command_1}} → {{aggregate_1}} processes → {{event_1}} emitted
2. {{actor_2}} issues {{command_2}} → {{aggregate_2}} processes → {{event_2}} emitted ⚠️ ({{hotspot_note}})

**Pivotal Events:** {{pivotal_events}}

**Hotspots:** {{hotspots}}
