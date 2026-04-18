---
name: dockerfile-containerization
description: >
  Use to containerize an application with an optimized Dockerfile and
  docker-compose configuration. Activate for creating Docker images,
  multi-stage builds, or local development container setups.
  Do NOT use for Kubernetes manifests, CI/CD pipeline configuration, or cloud container service setup.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [docker, dockerfile, containerization, docker-compose, multi-stage-build]
author: vheins
---

# Skill: Dockerfile Containerization

## Purpose
Generate optimized, production-ready container setups (Dockerfile + Compose) with health checks, signal handling, and multi-stage builds.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + TypeScript" |
| `app_description` | string | Yes | Purpose, entry point, port, runtime needs |
| `deployment_target` | string | Yes | e.g., "AWS ECS", "Kubernetes", "Local" |

## Instructions
- **Dockerfile**: Use multi-stage builds. Optimize layer ordering (Copy deps BEFORE code). Include `HEALTHCHECK`, non-root users, and proper signal handling (`exec` form).
- **Compose**: Create a local development setup with volume mounts (hot reload), backing services (DB, cache), and environment injection. Use `service_healthy` dependencies.
- **Optimization**: Select minimal base images (Alpine/Slim/Distroless). Document size choices and excluded artifacts.
- **Production**: Provide target-specific notes on resource limits, secrets injection (no ENVs in Dockerfile), and logging (stdout/stderr).

## Edge Cases
| Case | Strategy |
|------|----------|
| Compiled (Go/Rust) | Use `scratch` or `distroless` production stages for <20MB images. |
| Native Dependencies | Ensure build and production base images are compatible; copy binaries correctly. |
| Monorepo | Use build context filtering or separate Dockerfiles per service. |

## Container Logic
```mermaid
flowchart TD
    A([Start: tech_stack + app_description + deployment_target]) --> B{Compiled language?\nGo, Rust}
    B -- Yes --> C[Use scratch or distroless\nproduction stage\nimage < 20MB]
    B -- No --> D{Native dependencies?\nsharp, bcrypt, psycopg2}
    D -- Yes --> E[Ensure build + production stages\nuse compatible base images\ncopy native binaries correctly]
    D -- No --> F[Select base image:\nalpine vs slim vs distroless\nbased on size vs compatibility]
    C & E & F --> G[Multi-Stage Dockerfile\nBuild stage:\ninstall deps + compile/build\nLayer order: package files BEFORE source\nfor cache efficiency]
    G --> H[Production stage:\nMinimal base image\nOnly runtime artifacts\nNon-root user for security\nHEALTHCHECK instruction\nExec form CMD + tini for signals]
    H --> I[.dockerignore\nExclude: node_modules, .git\nbuild artifacts, .env files\ntest files, docs]
    I --> J{Monorepo?}
    J -- Yes --> K[Docker build context filtering\n--build-arg to select service\nor separate Dockerfiles per service]
    J -- No --> L
    K & L --> M[docker-compose.yml\nApp service + volume mounts for hot reload\nBacking services: DB, cache, queue\nEnv vars from .env file\nNamed volumes for persistent data\ndepends_on with service_healthy]
    M --> N[Image Size Optimization\nBase image rationale\nWhat excluded from production\nExpected final image size]
    N --> O[Production Considerations\nfor deployment_target:\nResource limits: CPU, memory\nSecrets injection: NOT via ENV in Dockerfile\nLogging: stdout/stderr for log drivers]
    O --> P([Output: Dockerfile + .dockerignore\n+ docker-compose.yml + Size optimization + Prod notes])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the Dockerfile multi-stage?
2. Are layers optimized for caching?
3. Is a non-root user used?
4. Is the production image minimal?
5. is the Compose file runnable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|----------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
