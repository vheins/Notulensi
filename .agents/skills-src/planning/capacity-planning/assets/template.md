# Template: capacity-planning

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Capacity Plan: {{system_name}}

**System Description:** {{system_description}}

**Expected Load:** {{expected_load}}

**Tech Stack:** {{tech_stack}}

---

### 1. Load Analysis

- Peak RPS: {{peak_rps}}; Average RPS: {{avg_rps}}
- Read/write ratio: {{read_write_ratio}}
- Data ingestion: {{data_ingestion_rate}}
- Concurrent users at peak: {{concurrent_users}}
- Assumptions: {{assumptions}}

### 2. Resource Requirements

| Component | CPU (vCPUs) | Memory (GB) | Storage | Bandwidth |
|-----------|-------------|-------------|---------|-----------|
| {{component_1}} | {{cpu_1}} | {{memory_1}} | {{storage_1}} | {{bandwidth_1}} |
| {{component_2}} | {{cpu_2}} | {{memory_2}} | {{storage_2}} | {{bandwidth_2}} |

### 3. Scaling Strategy

- {{component_1}}: {{scaling_type_1}}; trigger: {{trigger_1}}; max: {{max_1}}
- {{component_2}}: {{scaling_type_2}}; trigger: {{trigger_2}}; max: {{max_2}}

### 4. Cost Estimate ({{cloud_provider}}, approximate)

- {{service_1}}: ~${{cost_1}}/month
- {{service_2}}: ~${{cost_2}}/month
- Total at launch: ~${{total_launch}}/month
- Total at {{scale_milestone}}: ~${{total_scaled}}/month

### 5. Bottleneck Identification

1. **{{bottleneck_1}}** — bottlenecks at {{load_level_1}}; mitigate with {{mitigation_1}}
2. **{{bottleneck_2}}** — bottlenecks at {{load_level_2}}; mitigate with {{mitigation_2}}
3. **{{bottleneck_3}}** — bottlenecks at {{load_level_3}}; mitigate with {{mitigation_3}}
