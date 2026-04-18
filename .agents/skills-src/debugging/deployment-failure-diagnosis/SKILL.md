---
name: deployment-failure-diagnosis
description: >
  Diagnoses CI/CD and cloud deployment failures by analyzing logs and configuration. Do NOT use for build failures, runtime application errors, or infrastructure provisioning design.
version: "1.1.0"
time_saved: "20-40 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [deployment, ci-cd, cloud, kubernetes, debugging, devops]
author: vheins
---

# Skill: Deployment Failure Diagnosis

## Purpose
Pinpoint deployment failure stages, identify root causes (Permissions, Config, Resources), and provide fixes or rollback steps.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "GitHub Actions + ECS" |
| `deployment_logs` | string | Yes | Pipeline output |
| `deployment_config` | string | Yes | CI YAML or Terraform |
| `context` | string | Yes | Recent infrastructure changes |

## Instructions
- **Stage ID**: Identify failing step (Checkout, Build, Push, Provision, Deploy, Health Check).
- **Classification**: Categorize as Config, Permission, Resource (OOM), Network, or App crash.
- **Remediation**: Provide targeted configuration snippets or CLI fix commands.
- **Rollback**: List immediate platform-specific recovery commands (e.g., `kubectl rollout undo`).
- **Prevention**: Recommend staging envs, smoke tests, and automated rollback triggers.
- **Fallback**: If no logs, provide retrieval commands and stage-by-stage checklist.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Logs | Provide retrieval commands (`aws logs`, `kubectl logs`) and common stage failures. |
| "False" Success | Recommend post-deploy health probes and app-level log audits. |
| Flaky Deploys | Recommend increased health check grace periods and retry policies. |

## Diagnosis Logic
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C{Logs available?}
    C -- No --> D[Provide retrieval commands & common causes]
    C -- Yes --> F[Identify Failure Stage]
    F --> G{Stage?}
    G -- Checkout --> H[Check git credentials]
    G -- Deploy --> M[Check IAM/quotas/VPC]
    G -- Health check --> N[Check app startup/probes]
    H & M & N --> P{Root cause?}
    P -- Config --> Q[Show fix]
    P -- Permission --> R[IAM command]
    P -- Resource --> S[Adjust limits]
    Q & R & S --> V{Production blocked?}
    V -- Yes --> W[Provide rollback command]
    V -- No --> X
    W --> X[Add Prevention]
    X --> AA([Output: Report])
    D --> BB([Output: Generic diagnosis — retrieve logs & retry])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Failure stage pinpointed.
- [ ] Permissions (IAM) checked.
- [ ] Rollback command included.
- [ ] Fix is platform-specific.
- [ ] Health check addressed.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
