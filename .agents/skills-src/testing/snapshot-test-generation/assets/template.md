# Snapshot Test Specification Template

> Fill in all fields before activating the `snapshot-test-generation` skill.

---

## Component / Output to Snapshot

**Name:** `{{e.g. ProductCard, UserProfilePage, API response shape}}`

**Type:** {{UI component / API response / serialized object / CLI output}}

**Tech Stack:** {{e.g. React + Jest, Vue + Vitest, Node.js + Jest}}

---

## Component / Function

```{{language}}
{{paste the component or function to snapshot}}
```

---

## Snapshot Scenarios

| Scenario | Props / Input | Description |
|----------|---------------|-------------|
| Default state | `{{e.g. { name: "Product", price: 99 }}}` | {{renders with minimal props}} |
| Loading state | `{{e.g. { loading: true }}}` | {{shows skeleton/spinner}} |
| Error state | `{{e.g. { error: "Not found" }}}` | {{shows error message}} |
| Empty state | `{{e.g. { items: [] }}}` | {{shows empty state UI}} |
| Full data | `{{e.g. all props populated}}` | {{renders with all data}} |

---

## Snapshot Update Policy

**When to update snapshots:** {{e.g. intentional UI change, reviewed by team}}

**Update command:** `{{e.g. jest --updateSnapshot, vitest --update}}`

**Review process:** {{e.g. diff must be reviewed in PR, not auto-approved}}

---

## Serializer / Config

**Custom serializer:** {{yes/no — e.g. enzyme-to-json, @testing-library/jest-dom}}

**Inline snapshots:** {{yes/no — prefer inline for small outputs}}

**Snapshot file location:** `{{e.g. __snapshots__/ next to test file}}`

---

## What NOT to Snapshot

- Dynamic values (timestamps, random IDs) → mock or strip before snapshot
- Third-party component internals → test behavior, not implementation
- {{other exclusions}}
