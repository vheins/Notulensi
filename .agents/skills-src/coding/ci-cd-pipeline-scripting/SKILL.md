---
name: ci-cd-pipeline-scripting
description: >
  Use to generate a CI/CD pipeline configuration for building, testing,
  and deploying an application. Activate for GitHub Actions, GitLab CI,
  CircleCI, or similar pipeline tools for any tech stack.
  Do NOT use for infrastructure provisioning, Dockerfile creation, or deployment strategy design.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [ci-cd, github-actions, gitlab-ci, pipeline, automation, deployment]
author: vheins
---

# Skill: CI/CD Pipeline Scripting

## Purpose
Generate production-ready CI/CD configurations (GitHub Actions, GitLab CI, etc.) for any stack and deployment target, including caching, security scans, and environment promotion.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | App stack (e.g., "Node.js + Docker") |
| `deployment_target` | string | Yes | e.g., "AWS ECS", "Kubernetes", "Vercel" |
| `pipeline_requirements` | string | Yes | Platform, environments, tests, branch strategy |

## Instructions
- **Stages**: Define Build (lint/compile), Test (unit/integration), Security (scan vulnerabilities), and Deploy (environment-specific gates).
- **Configuration**: Generate the YAML/config file with dependency caching and artifact creation.
- **Secrets**: Provide a table of required secrets (Name, Purpose, Source).
- **Branch Strategy**: Define triggers (feature branches = build/test; main = staging; tags = production).
- **Optimization**: Include notes on caching efficiency and estimated duration.

## Edge Cases
| Case | Strategy |
|------|----------|
| Monorepo | Use path-filtered triggers and parallel matrix builds. |
| Non-Docker deployment | Generate artifact-based logic (S3 sync, serverless package). |
| Self-hosted runners | Add runner tags and credential mounting requirements. |

## Pipeline Flow
```mermaid
flowchart TD
    A([Start: tech_stack + deployment_target + pipeline_requirements]) --> B{CI platform?}
    B -- GitHub Actions --> C[Generate .github/workflows/ci.yml]
    B -- GitLab CI --> D[Generate .gitlab-ci.yml]
    B -- CircleCI --> E[Generate .circleci/config.yml]
    C & D & E --> F{Monorepo?}
    F -- Yes --> G[Add path-filtered triggers
matrix jobs for parallel builds]
    F -- No --> H[Single service pipeline]
    G & H --> I[Stage: Build
lint + type-check + compile
with dependency cache]
    I --> J[Stage: Test
unit + integration
service containers if needed]
    J --> K[Stage: Security Scan
npm audit / trivy / safety]
    K --> L{Docker needed?}
    L -- Yes --> M[Build + push Docker image
to registry]
    L -- No --> N[Build artifact
zip / S3 sync / serverless package]
    M & N --> O{Branch?}
    O -- feature/* --> P[Stop here
build + test only]
    O -- main/develop --> Q[Deploy to Staging
auto]
    O -- tag/release --> R[Deploy to Production
manual approval gate]
    Q --> S[List required secrets
name + purpose + which stage]
    R --> S
    S --> T[Optimization notes
cache strategy + estimated duration]
    T --> U([Output: Pipeline YAML
+ Secrets table + Branch strategy])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes handled?
3. Does it scale 10x in load/size?
4. Are security implications addressed?
5. is it testable and observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
