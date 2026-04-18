# Skills: Documentation (15 skills)

This category contains skills for writing technical documentation.

## Subdirectory Structure

Each skill in the `documentation` category has the following structure:

```
{skill-name}/
├── SKILL.md          # Core instructions (≤500 lines)
├── references/       # Supporting technical documentation
│   ├── README.md
│   └── compatibility-matrix.md
├── assets/           # Technical document templates
│   └── template.md
└── examples/         # Concrete input/output examples
    ├── input.md
    └── output.md
```

## Skills

| Skill | Description |
|-------|-------------|
| `adr-writing` | Write Architecture Decision Records |
| `api-documentation` | Document APIs (OpenAPI-compatible) |
| `architecture-documentation` | Document system architecture |
| `changelog-generation` | Generate changelogs |
| `database-documentation` | Document database schemas |
| `inline-code-comment-generation` | Generate inline code comments |
| `module-documentation` | Document code modules/packages |
| `onboarding-guide-creation` | Create onboarding guides |
| `postmortem-report-writing` | Write postmortem reports |
| `project-overview-documentation` | Document project overviews |
| `readme-generation` | Generate README.md files |
| `release-notes-generation` | Generate release notes |
| `runbook-creation` | Create operational runbooks |
| `setup-guide-creation` | Create setup guides |
| `troubleshooting-guide-creation` | Create troubleshooting guides |

---

## Mermaid Diagram

```mermaid
flowchart TD
    A([Documentation Task]) --> B{What do you need?}

    B -- Project overview for stakeholders --> C[project-overview-documentation]
    B -- README.md --> D[readme-generation]
    B -- API reference docs --> E[api-documentation]
    B -- Module / package docs --> F[module-documentation]
    B -- Database schema docs --> G[database-documentation]
    B -- Architecture docs --> H[architecture-documentation]
    B -- Inline code comments --> I[inline-code-comment-generation]
    B -- Setup guide --> J[setup-guide-creation]
    B -- Onboarding guide --> K[onboarding-guide-creation]
    B -- Runbook --> L[runbook-creation]
    B -- Troubleshooting guide --> M[troubleshooting-guide-creation]
    B -- Changelog --> N[changelog-generation]
    B -- Release notes --> O[release-notes-generation]
    B -- Architecture Decision Record --> P[adr-writing]
    B -- Postmortem report --> Q[postmortem-report-writing]

    subgraph Pre-Implementation
        P
    end

    subgraph Post-Implementation
        C --> D
        D --> E --> F --> G --> H
        J --> K --> L --> M
        N --> O
    end
```
