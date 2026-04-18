# Template: sla-slo-definition

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## SLA/SLO Definition: {{service_name}}

**Service Description:** {{service_description}}

**Tech Stack:** {{tech_stack}}

**Business Requirements:** {{business_requirements}}

---

### 1. SLI Definitions

- **Availability SLI**: Percentage of HTTP requests returning non-5xx responses in a {{measurement_window}} rolling window. Source: {{monitoring_tool}} metrics.
- **Latency SLI**: p{{latency_percentile}} response time for {{critical_endpoint}} in a {{measurement_window}} rolling window. Source: {{monitoring_tool}} latency histogram.
- **Error Rate SLI**: Percentage of requests returning 5xx in a {{measurement_window}} rolling window. Source: {{monitoring_tool}} error rate.

### 2. SLO Targets

| SLI | SLO Target | Window | Rationale |
|-----|-----------|--------|-----------|
| Availability | {{availability_target}}% | 30-day rolling | {{availability_rationale}} |
| Latency p{{latency_percentile}} | < {{latency_target}}ms | 30-day rolling | {{latency_rationale}} |
| Error Rate | < {{error_rate_target}}% | 30-day rolling | {{error_rate_rationale}} |

### 3. Error Budget Calculation

- Availability ({{availability_target}}%): {{error_budget_pct}}% error budget = **{{error_budget_minutes}} minutes/month**
- Burn rate at 1x: budget depletes in 30 days
- Burn rate at {{fast_burn_rate}}x: budget depletes in 1 hour (major outage threshold)

### 4. Alerting Thresholds

**Alert 1: Critical Burn (Page)**
- Condition: Burn rate > {{fast_burn_rate}}x for {{fast_window}} minutes
- Severity: Page

**Alert 2: Slow Burn (Ticket)**
- Condition: Burn rate > {{slow_burn_rate}}x for {{slow_window}} hours
- Severity: Ticket

### 5. Escalation Policy

- On-call: {{oncall_team}}
- Escalation: If not acknowledged in {{escalation_timeout}} minutes → escalate to {{escalation_target}}
- Stakeholder notification: {{stakeholder_notification_criteria}}
- Postmortem required: {{postmortem_criteria}}
