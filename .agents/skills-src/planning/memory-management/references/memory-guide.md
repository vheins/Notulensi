# References: memory-management

## Memory Entry Types

| Type | Use When |
|------|----------|
| `decision_made` | An architectural or technology decision was finalized |
| `new_pattern` | A new coding pattern was established for the project |
| `config_change` | A tool, environment, or build configuration changed |
| `rule_established` | A project-specific rule was agreed upon by the team |

## What Makes a Good Memory Entry

- **Specific** — "Use CQRS for reporting module" not "use CQRS"
- **Contextual** — explains WHY, not just WHAT
- **Actionable** — includes a "Do NOT" to prevent the most common mistake
- **Dated** — always include the date for traceability

## MCP Memory vs File Memory

See `.agents/memory.md` for the full sync protocol between MCP memory and file-based memory.

Priority: MCP memory is the active store when available. `.agents/memory.md` is the fallback.
