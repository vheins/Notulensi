# Template: acceptance-criteria-writing

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Acceptance Criteria: {{feature_name}}

**User Story:** {{user_story}}

**Tech Stack:** {{tech_stack}}

**Context:** {{context}}

---

### 1. Happy Path Criteria

- When {{trigger_1}}, the system shall {{response_1}}.
- When {{trigger_2}}, the system shall {{response_2}}.
- The system shall {{unconditional_behavior}}.

### 2. Edge Case Criteria

- When {{edge_condition_1}}, the system shall {{edge_response_1}}.
- When {{edge_condition_2}}, the system shall {{edge_response_2}}.

### 3. Error and Failure Criteria

- When {{error_condition_1}}, the system shall display: "{{error_message_1}}".
- When {{error_condition_2}}, the system shall {{error_behavior_2}}.

### 4. Non-Functional Criteria

- The {{endpoint_or_feature}} shall respond within {{threshold}} at {{percentile}}.
- {{security_requirement}}.
- {{accessibility_requirement}}.

---

**Testability Notes:** {{testability_notes}}
