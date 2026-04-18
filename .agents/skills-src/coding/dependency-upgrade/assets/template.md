# Dependency Upgrade Specification Template

> Fill in all fields before activating the `dependency-upgrade` skill.

---

## Upgrade Scope

**Package Manager:** {{npm / yarn / pnpm / pip / go mod / cargo / composer}}

**Tech Stack:** {{e.g. Node.js 20 + TypeScript, Python 3.11}}

---

## Dependencies to Upgrade

| Package | Current Version | Target Version | Reason |
|---------|----------------|----------------|--------|
| `{{package}}` | `{{current}}` | `{{target or "latest"}}` | {{e.g. security fix, new feature needed}} |

---

## Breaking Changes (known)

| Package | Breaking Change | Impact |
|---------|----------------|--------|
| `{{package}}` | {{e.g. removed API X, changed return type of Y}} | {{e.g. affects 3 files}} |

---

## Test Coverage

**Existing tests:** {{yes/no — describe coverage level}}

**Test command:** `{{e.g. npm test, pytest, go test ./...}}`

**CI pipeline:** {{yes/no — will run automatically on PR}}

---

## Constraints

**Node/Python/Go version:** {{e.g. must stay on Node 18, cannot upgrade runtime}}

**Peer dependency constraints:** {{e.g. package A requires React 17}}

**Deployment freeze:** {{e.g. no deploys until {{date}}}}

---

## Rollback Plan

**Strategy:** {{e.g. revert commit, pin to previous version in package.json}}

**Rollback time estimate:** {{e.g. < 5 minutes}}
