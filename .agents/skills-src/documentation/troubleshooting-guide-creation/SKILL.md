---
name: troubleshooting-guide-creation
description: >
  Use when a developer or ops team needs a structured troubleshooting guide for a system,
  covering common errors, symptoms, root causes, diagnostic steps, resolutions, and prevention.
  Do NOT use for setup guides, architecture documentation, or API reference generation.
version: "1.1.0"
time_saved: "Manual: 3–4 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~4000
tags: [troubleshooting, debugging, error-resolution, runbook, operations, developer-experience]
author: vheins
---

# Agent Optimized: Troubleshooting Guide Creation

## Directives
- **Content Structure**: Provide min 6 entries. Each MUST include:
    - **Symptom**: Visible observation.
    - **Error Message**: Exact log/UI text in `code blocks`.
    - **Root Cause**: 1–2 sentence technical explanation.
    - **Diagnostic Steps**: Numbered commands to confirm.
    - **Resolution**: Step-by-step fix with commands.
    - **Prevention**: Actionable monitoring/config change.
- **Audience Adaptation**: Adjust technical depth based on `{{target_audience}}`.
- **Stack Context**: If `{{known_issues}}` missing, generate top 6 common issues for `{{tech_stack}}`.
- **Observability**: Recommend missing tools if diagnosis is hindered by stack gaps.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B{Issues Provided?}
    B -- Yes --> C[Use provided issues]
    B -- No --> D[Generate top 6 stack-specific issues]
    C & D --> E[Select Audience Tone]
    E --> F[Process Entry: Symptom -> Error -> Root Cause]
    F --> G[Diagnostic Steps + reproduction notes]
    G --> H[Resolution + commands]
    H --> I[Prevention + monitoring]
    I --> J{More issues?}
    J -- Yes --> F
    J -- No --> K([Final Troubleshooting Guide])
```

## Constraints
| Rule | Description |
|------|-------------|
| Precision | Use exact error messages and valid command syntax. |
| Scope | Startup, runtime, performance, and configuration issues. |
| Intermittency | Explicitly note conditions required for intermittent bugs. |
| Formatting | Use horizontal rules (`---`) between entries. |

## Review Criteria
- [ ] Simplest working resolution provided.
- [ ] Diagnostic steps are verifiable.
- [ ] Prevention is actionable.
- [ ] No assumed default paths/ports without verification.

## Metadata
- **Output Path**: `.agents/documents/operations/runbooks/`
- **Changelog**: 1.1.0 (Refined structure, added metadata); 1.0.0 (Initial).
