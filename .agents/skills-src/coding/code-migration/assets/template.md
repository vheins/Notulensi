# Code Migration Specification Template

> Fill in all fields before activating the `code-migration` skill.

---

## Migration Scope

**From:** {{e.g. JavaScript → TypeScript, Express 4 → Express 5, React Class → Hooks, Node 16 → Node 20}}

**To:** {{target version/framework/language}}

**Scope:** {{e.g. entire codebase, single module, specific files}}

---

## Current State

**Files / Modules to Migrate:**
```
{{list key files or directories}}
```

**Current Dependencies (relevant):**
```json
{
  "{{package}}": "{{current version}}"
}
```

**Known Issues / Pain Points:**
- {{e.g. uses deprecated API X}}
- {{e.g. relies on removed feature Y}}

---

## Target State

**Target Dependencies:**
```json
{
  "{{package}}": "{{target version}}"
}
```

**Breaking Changes to Handle:**
| Old API / Pattern | New API / Pattern |
|-------------------|-------------------|
| `{{old}}` | `{{new}}` |

---

## Constraints

**Must preserve:** {{e.g. existing test suite, public API surface, DB schema}}

**Can change:** {{e.g. internal implementation, file structure}}

**Cannot change:** {{e.g. external API contracts, env variable names}}

---

## Rollout Strategy

**Approach:** {{big-bang / incremental / strangler fig}}

**Testing plan:** {{e.g. run existing test suite, add migration-specific tests}}
