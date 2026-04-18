# AI Dev Toolkit — Skills

A collection of 144 AI skills for developers, organized across 7 categories. Each skill contains structured instructions compatible with 7 IDEs/agents: Kiro, Cursor, Windsurf, GitHub Copilot, OpenCode, TRAE, Claude Code.

## Categories

| Category | Skills | Subdirectories |
|----------|--------|----------------|
| [coding](coding/) | 31 | `scripts/` `references/` `assets/` `examples/` |
| [debugging](debugging/) | 26 | `references/` `examples/` |
| [testing](testing/) | 27 | `scripts/` `references/` `assets/` `examples/` |
| [planning](planning/) | 23 | `references/` `assets/` `examples/` |
| [documentation](documentation/) | 15 | `references/` `assets/` `examples/` |
| [design](design/) | 11 | `references/` `assets/` `examples/` |
| [idea-validation](idea-validation/) | 10 | `references/` `assets/` `examples/` |

## Subdirectory Structure

### Full Stack (coding & testing)
```
{skill-name}/
├── SKILL.md          # Core instructions (≤500 lines)
├── scripts/          # Executable scripts and automation
├── references/       # Supporting technical documentation
├── assets/           # Ready-to-use templates and configurations
└── examples/         # Concrete input/output examples
```

### Standard (planning, documentation, design, idea-validation)
```
{skill-name}/
├── SKILL.md
├── references/
├── assets/
└── examples/
```

### Minimal (debugging)
```
{skill-name}/
├── SKILL.md
├── references/
├── assets/        # (optional — only for skills that provide templates)
└── examples/
```

## Contributing

To create a new skill, use the scaffold generator:

```bash
bash scripts/generate-skill-scaffold.sh <category> <skill-name>
# Example:
bash scripts/generate-skill-scaffold.sh coding my-new-skill
```

Valid categories: `coding`, `debugging`, `testing`, `planning`, `documentation`, `design`, `idea-validation`

## Validation

To validate the structure of all skills:

```bash
bash scripts/validate-skill-structure.sh
# Exit code 0 = all skills compliant
# Exit code 1 = one or more skills non-compliant

# Filter by category:
bash scripts/validate-skill-structure.sh --category coding
```

## Compatibility

All skills are compatible with:

| Agent | Path |
|-------|------|
| Kiro | `.kiro/skills/` |
| Cursor | `.cursor/skills/` |
| Windsurf | `.windsurf/skills/` |
| GitHub Copilot | `.github/skills/` |
| OpenCode | `.agents/skills/` |
| TRAE | `.trae/skills/` |
| Claude Code | `.claude/skills/` |

---

## Mermaid Diagram

```mermaid
flowchart TD
    A([User Task]) --> B{Task Category}

    B -- Implement / Refactor / Review --> C[coding\n31 skills]
    B -- Diagnose / Fix / Analyze --> D[debugging\n26 skills]
    B -- Write Tests / QA / Strategy --> E[testing\n27 skills]
    B -- Architecture / Sprint / Backlog --> F[planning\n23 skills]
    B -- Write Docs / ADR / Runbook --> G[documentation\n15 skills]
    B -- Wireframe / Component / Design System --> H[design\n11 skills]
    B -- Validate Idea / Market / MVP --> I[idea-validation\n10 skills]

    C --> C1[api-implementation\nboilerplate-generation\ncode-review\nsenior-code-review\nrefactoring\nerror-handling-patterns\nlogging-instrumentation\n+ 24 more]

    D --> D1[error-analysis\nroot-cause-identification\nfix-suggestion\nlog-interpretation\nbuild-failure-analysis\nperformance-bottleneck-analysis\ndeep-audit\n+ 19 more]

    E --> E1[unit-test-generation\nintegration-test-generation\nbdd-scenario-writing\nqa-design\nqa-execution\ntest-pyramid-strategy\nsmoke-test-suite\n+ 20 more]

    F --> F1[architecture-planning\ndomain-modeling\napi-contract-design\ndatabase-schema-planning\nsprint-planning\nuser-story-generation\nroadmap-creation\n+ 16 more]

    G --> G1[api-documentation\nmodule-documentation\nreadme-generation\nrunbook-creation\nadr-writing\nchangelog-generation\nsetup-guide-creation\n+ 8 more]

    H --> H1[screen-wireframe-generation\ncomponent-inventory-generation\ndesign-system-specification\nnavigation-structure-design\nuser-flow-diagram-description\n+ 6 more]

    I --> I1[problem-identification\ntarget-user-definition\nvalue-proposition-writing\nfeasibility-assessment\nmvp-scope-definition\nfeature-prioritization\n+ 4 more]
```
