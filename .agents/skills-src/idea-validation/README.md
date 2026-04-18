# Skills: Idea Validation (10 skills)

This category contains skills for product idea validation and market analysis.

## Subdirectory Structure

Each skill in the `idea-validation` category has the following structure:

```
{skill-name}/
├── SKILL.md          # Core instructions (≤500 lines)
├── references/       # Supporting technical documentation
│   ├── README.md
│   └── compatibility-matrix.md
├── assets/           # Idea validation document templates
│   └── template.md
└── examples/         # Concrete input/output examples
    ├── input.md
    └── output.md
```

## Skills

| Skill | Description |
|-------|-------------|
| `assumption-mapping` | Map product assumptions |
| `competitor-analysis` | Analyze competitors |
| `feasibility-assessment` | Assess technical/business feasibility |
| `feature-prioritization` | Prioritize features |
| `hypothesis-validation` | Validate product hypotheses |
| `market-sizing` | Estimate market size |
| `mvp-scope-definition` | Define MVP scope |
| `problem-identification` | Identify user problems |
| `target-user-definition` | Define target users |
| `value-proposition-writing` | Write value propositions |

---

## Mermaid Diagram

```mermaid
flowchart TD
    A([Raw Idea]) --> B[problem-identification\nWhat problem? Who has it?]
    B --> C[target-user-definition\nWho is the user?]
    C --> D[value-proposition-writing\nWhy choose this solution?]
    D --> E{New product?}
    E -- Yes --> F[market-sizing\nTAM → SAM → SOM]
    F --> G[competitor-analysis\nCompare existing solutions]
    E -- No / Feature --> H
    G --> H[assumption-mapping\nRisk-rank all assumptions]
    H --> I{High-risk\nassumptions?}
    I -- Yes --> J[hypothesis-validation\nDesign lean experiments]
    I -- No --> K
    J --> K[feasibility-assessment\nTechnical + financial + time\nGo / Conditional / No-Go]
    K --> L{Verdict}
    L -- No-Go --> Z([Stop: summarize blockers])
    L -- Go / Conditional --> M[mvp-scope-definition\nMoSCoW prioritization]
    M --> N[feature-prioritization\nRICE scoring + build order]
    N --> O([Validated Concept ✅\nReady for requirements-planning])
```
