# Template: architecture-planning

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Architecture Plan: {{project_name}}

**Project Description:** {{project_description}}

**Tech Stack:** {{tech_stack}}

**Scale Requirements:** {{scale_requirements}}

---

### 1. Component Overview

| Component | Responsibility | Technology | Interfaces |
|-----------|---------------|------------|------------|
| {{component_1}} | {{responsibility_1}} | {{technology_1}} | {{interfaces_1}} |
| {{component_2}} | {{responsibility_2}} | {{technology_2}} | {{interfaces_2}} |

### 2. Data Flow Description

**Critical Journey — {{journey_name}}:**
1. {{step_1}}
2. {{step_2}}
3. {{step_3}}

### 3. Technology Decisions

- **{{technology_1}}**: Chosen for {{reason_1}}. Rejected: {{alternative_1}} ({{rejection_reason_1}}).
- **{{technology_2}}**: Chosen for {{reason_2}}. Rejected: {{alternative_2}} ({{rejection_reason_2}}).

### 4. Scalability Considerations

- {{component_1}}: {{scaling_strategy_1}}
- {{component_2}}: {{scaling_strategy_2}}
- Bottleneck: {{bottleneck}} → Mitigation: {{mitigation}}

### 5. Architecture Diagram

```
{{ascii_diagram}}
```
