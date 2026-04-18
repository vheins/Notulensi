# Monorepo Setup Specification Template

> Fill in all fields before activating the `monorepo-setup` skill.

---

## Monorepo Overview

**Monorepo Tool:** {{Turborepo / Nx / pnpm workspaces / Lerna / Bazel}}

**Package Manager:** {{pnpm / npm / yarn}}

**Primary Language:** {{TypeScript / JavaScript / Go / Python}}

---

## Packages / Apps

| Name | Type | Path | Description |
|------|------|------|-------------|
| `{{app-name}}` | app | `apps/{{app-name}}` | {{e.g. Next.js frontend}} |
| `{{api-name}}` | app | `apps/{{api-name}}` | {{e.g. Express API}} |
| `{{pkg-name}}` | package | `packages/{{pkg-name}}` | {{e.g. shared UI components}} |
| `{{pkg-name}}` | package | `packages/{{pkg-name}}` | {{e.g. shared types/interfaces}} |
| `{{pkg-name}}` | package | `packages/{{pkg-name}}` | {{e.g. shared utilities}} |

---

## Shared Config

| Config | Shared? | Package |
|--------|---------|---------|
| TypeScript config | {{yes/no}} | `packages/tsconfig` |
| ESLint config | {{yes/no}} | `packages/eslint-config` |
| Prettier config | {{yes/no}} | root `prettier.config.js` |
| Tailwind config | {{yes/no}} | `packages/tailwind-config` |
| Jest / Vitest config | {{yes/no}} | `packages/jest-config` |

---

## Pipeline / Task Runner

| Task | Command | Depends On |
|------|---------|------------|
| `build` | `tsc / next build` | `^build` (deps first) |
| `test` | `jest / vitest` | `build` |
| `lint` | `eslint` | — |
| `dev` | `next dev / nodemon` | — |

---

## CI Strategy

**CI Platform:** {{GitHub Actions / GitLab CI}}

**Affected-only builds:** {{yes/no — only build/test changed packages}}

**Cache strategy:** {{e.g. Turborepo remote cache, Nx Cloud, none}}
