# Template: dependency-mapping

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Dependency Map: {{system_name}}

**Modules/Services:** {{module_list}}

**Tech Stack:** {{tech_stack}}

**Context:** {{context}}

---

### 1. Dependency Graph

```
{{module_1}} → {{module_2}} ({{coupling_type_1}})
{{module_2}} → {{module_3}} ({{coupling_type_2}})
```

**Dependency Matrix:**

| Module | Depends On | Depended On By | Coupling Type |
|--------|-----------|----------------|---------------|
| {{module_1}} | {{depends_on_1}} | {{depended_by_1}} | {{coupling_1}} |
| {{module_2}} | {{depends_on_2}} | {{depended_by_2}} | {{coupling_2}} |

### 2. Circular Dependency Identification

{{circular_dependencies_or_none}}

### 3. Risk Assessment

| Dependency | Risk Level | Risk Reason | Impact if Fails |
|------------|------------|-------------|-----------------|
| {{dep_1}} | {{risk_1}} | {{reason_1}} | {{impact_1}} |
| {{dep_2}} | {{risk_2}} | {{reason_2}} | {{impact_2}} |

### 4. Decoupling Recommendations

1. **{{high_risk_dep_1}}**
   - Current: {{current_pattern_1}}
   - Recommended: {{recommended_pattern_1}}
   - Steps: {{migration_steps_1}}
   - Trade-off: {{tradeoff_1}}
