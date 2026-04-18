---
name: adr-writing
description: >
  Generates an Architecture Decision Record (ADR) capturing context, chosen option, alternatives, and consequences.
  Do NOT use for feature planning, bug reports, or general design documents.
version: "1.1.0"
time_saved: "Manual: 1-2 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~7500
tags: [adr, architecture, decision-record, documentation, madr, nygard]
author: ai-dev-toolkit
---

# Agent Optimized: ADR Writing

## Directives
- **Format**: Use MADR/Nygard standard.
- **Sections**:
    - **Header**: `# {{decision_title}}`, ISO date, Status (Proposed|Accepted|Deprecated|Superseded).
    - **Context**: Problem statement, constraints (cost/scale), and assumptions.
    - **Decision**: Chosen option, rationale, and accepted trade-offs.
    - **Consequences**: Categorized lists (Positive, Negative, Neutral).
    - **Alternatives**: Table or list of rejected options with specific reasons.
- **Traceability**: If superseding, reference the prior ADR ID in Context.
- **Precision**: Do not invent context or rejection rationale. Ask for missing details.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B{Inputs Valid?}
    B -- No --> C[Request missing data]
    C --> B
    B -- Yes --> D[Set Status & Header]
    D --> E[Draft Context & Constraints]
    E --> F[Draft Decision & Rationale]
    F --> G[Draft Consequences: +/-]
    G --> H[Process Alternatives Table]
    H --> I{Superseding?}
    I -- Yes --> J[Reference prior ADR]
    I -- No --> K[Finalize]
    J --> K
    K --> L([Final ADR Markdown])
```

## Constraints
| Rule | Description |
|------|-------------|
| Title | Short, imperative, prefixed with "ADR-XXX:" if applicable. |
| Consequences | Surface tension/conflicts in "Negative Consequences". |
| Status | Default to "Proposed" unless explicit confirmation of acceptance. |
| Scope | Technical architecture decisions only. |

## Review Criteria
- [ ] Rationale for rejection of alternatives is clear.
- [ ] All primary constraints are addressed in context.
- [ ] Trade-offs are explicitly acknowledged.
- [ ] Output is prose for context/decision and bullets for consequences.

## Metadata
- **Output Path**: `.agents/documents/decisions/`
- **Changelog**: 1.1.0 (MADR alignment, added metadata); 1.0.0 (Initial).
