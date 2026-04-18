# Template: monolith-decomposition

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Monolith Decomposition Plan: {{system_name}}

**Monolith Description:** {{monolith_description}}

**Tech Stack:** {{tech_stack}}

**Target Architecture:** {{target_architecture}}

---

### 1. Decomposition Phases

**Phase 1 ({{phase_1_timeline}}): {{phase_1_name}}**
- Services to extract: {{phase_1_services}}
- Goal: {{phase_1_goal}}
- Success criteria: {{phase_1_success}}

**Phase 2 ({{phase_2_timeline}}): {{phase_2_name}}**
- Services to extract: {{phase_2_services}}
- Goal: {{phase_2_goal}}
- Success criteria: {{phase_2_success}}

### 2. Strangler Fig Pattern Application

- Routing layer: {{routing_layer}}
- Incremental cutover: {{cutover_strategy}}
- Parallel running: {{parallel_period}}
- Verification: {{verification_method}}

### 3. Service Extraction Order

1. **{{service_1}}** — coupling score: {{coupling_1}}; effort: {{effort_1}}; tables: {{tables_1}}
2. **{{service_2}}** — coupling score: {{coupling_2}}; effort: {{effort_2}}; tables: {{tables_2}}
3. **{{service_3}}** — coupling score: {{coupling_3}}; effort: {{effort_3}}; tables: {{tables_3}}

### 4. Risk Mitigation per Phase

**Phase 1 risks:**
- Risk: {{risk_1}} → Mitigation: {{mitigation_1}}
- Risk: {{risk_2}} → Mitigation: {{mitigation_2}}
- Go/no-go: {{go_no_go_criteria}}

### 5. Rollback Strategy

- Rollback trigger: {{rollback_trigger}}
- Rollback procedure: {{rollback_procedure}}
- Data consistency: {{data_consistency_approach}}
- Time to rollback: {{rollback_time}}
