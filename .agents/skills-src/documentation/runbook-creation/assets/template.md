# Template: runbook-creation

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

# Runbook: {{service_name}}

**Last Updated:** {{last_updated}}
**Owner:** {{owner_team}}
**On-Call:** {{on_call_rotation}}

## Service Overview

{{service_description}}

## SLOs

| Metric | Target |
|--------|--------|
| Availability | {{availability_target}} |
| p99 Latency | {{latency_target}} |

## Monitoring

- Dashboard: {{dashboard_url}}
- Alerts: {{alerts_url}}

## Standard Operating Procedures

### Restart Service

```bash
{{restart_command}}
```

### Scale Up

```bash
{{scale_command}}
```

## Incident Response Playbook

### Alert: {{alert_name}}

**Symptoms:** {{symptoms}}
**Diagnosis:** {{diagnosis_steps}}
**Resolution:** {{resolution_steps}}
**Escalation:** {{escalation_path}}

## On-Call Checklist

- [ ] {{checklist_item_1}}
- [ ] {{checklist_item_2}}
