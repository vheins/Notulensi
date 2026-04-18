# vibe-coding-premium

AI Dev Toolkit: 144 skills, rules, and workflows.

## Structure
- `.agents/rules/`: Global constraints.
- `.agents/skills-src/`: 144 on-demand skills (7 cats).
- `.agents/workflows/`: End-to-end chains.
- `.agents/documents/`: Templates/Examples.

## Skill Categories
| Cat | Count | Focus |
|-----|-------|-------|
| coding | 31 | API, Refactor, CI/CD |
| debugging | 26 | Error analysis, OOM |
| testing | 27 | Unit, E2E, Load |
| planning | 23 | Arch, Sprint, Domain |
| documentation | 15 | API docs, ADR, Runbook |
| design | 11 | Wireframes, UX |
| idea-val | 10 | MVP, Market, Comp |

## Core Rules
- `coding-standards.md`
- `database-standards.md`
- `test-architecture.md`
- `business-logic.md`
- `development-quality.md`
- `anti-hallucination.md`

## Scripts
- `bash scripts/validate-skill-structure.sh`
- `bash scripts/generate-skill-scaffold.sh <cat> <name>`

## Agent Paths
| Agent | Path |
|-------|------|
| Kiro | `.kiro/skills/` |
| Cursor | `.cursor/skills/` |
| Windsurf | `.windsurf/skills/` |
| Claude Code | `.claude/skills/` |
| Other | `.agents/skills/` |

[Proprietary](LICENSE.md) — Personal Use Only.
