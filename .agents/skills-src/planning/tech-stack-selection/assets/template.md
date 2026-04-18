# Template: tech-stack-selection

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Tech Stack Selection: {{project_name}}

**Project Type:** {{project_type}}

**Requirements:** {{requirements}}

**Constraints:** {{constraints}}

---

### 1. Recommended Stack

- **Frontend**: {{frontend_choice}} — {{frontend_rationale}}
- **Backend**: {{backend_choice}} — {{backend_rationale}}
- **Database**: {{database_choice}} — {{database_rationale}}
- **Infrastructure**: {{infra_choice}} — {{infra_rationale}}

### 2. Alternative Stacks

**Alt 1: {{alt1_name}}**
- Strengths: {{alt1_strengths}}
- Weaknesses: {{alt1_weaknesses}}
- Choose when: {{alt1_when}}

**Alt 2: {{alt2_name}}**
- Strengths: {{alt2_strengths}}
- Weaknesses: {{alt2_weaknesses}}
- Choose when: {{alt2_when}}

### 3. Decision Matrix

| Criterion | Weight | {{recommended}} | {{alt1}} | {{alt2}} |
|-----------|--------|-----------------|----------|----------|
| {{criterion_1}} | {{weight_1}}% | {{score_r1}} | {{score_a1_1}} | {{score_a2_1}} |
| {{criterion_2}} | {{weight_2}}% | {{score_r2}} | {{score_a1_2}} | {{score_a2_2}} |
| {{criterion_3}} | {{weight_3}}% | {{score_r3}} | {{score_a1_3}} | {{score_a2_3}} |
| **Weighted Total** | **100%** | **{{total_r}}** | **{{total_a1}}** | **{{total_a2}}** |

### 4. Migration Path

- **Trigger**: {{migration_trigger}}
- **Sequence**: {{migration_sequence}}
- **Estimated effort**: {{migration_effort}}
