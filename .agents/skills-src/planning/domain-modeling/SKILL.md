---
name: domain-modeling
description: Generates a DDD domain model (entities, value objects, aggregates, domain events, repositories, glossary). DO NOT use for DB schema design or API design.
version: "1.1.0"
time_saved: "Manual: 6–12 hours | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [domain-modeling, DDD, entities, aggregates, value-objects, domain-events, ubiquitous-language]
author: vheins
---

# Skill: Domain Modeling

## Purpose
Produces a Domain-Driven Design (DDD) model for a bounded context. Identifies entities, value objects, aggregates, domain events, repository interfaces, and a ubiquitous language glossary.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{domain_description}}` | string | yes | Business domain and rules |
| `{{tech_stack}}` | string | yes | Target tech stack |
| `{{bounded_context}}` | string | yes | Specific bounded context to model |

## Prompt
> **Anti-Hallucination:** Follow `.agents/rules/anti-hallucination.md`. Show chain-of-thought. State assumptions. Say "I don't know" if uncertain. Use provided context only.

Act as a senior DDD architect.

Domain: {{domain_description}}
Stack: {{tech_stack}}
Context: {{bounded_context}}

Produce 6 sections:

**1. Entity Definitions**
For each entity: Name (PascalCase), Identity, Key attributes, Invariants, Lifecycle states.

**2. Value Objects**
For each value object: Name (PascalCase), Attributes, Why it is a VO, Validation rules.

**3. Aggregate Roots**
For each aggregate: Root name, Contained entities/VOs, Enforced invariants, Why boundary chosen.

**4. Domain Events**
For each event: Name (PastTense), Trigger, Payload, Consumers.

**5. Repository Interfaces**
For each aggregate root: Interface name, Method signatures (pseudocode/target language), Query methods.

**6. Ubiquitous Language Glossary**
8–12 domain terms defined in business language, avoiding technical jargon.

Ask for clarification if context is unclear/overlapping. Do not model outside the bounded context.

## Examples
@examples/input.md
@examples/output.md

## Edge Cases
1. **Context too broad**: Identify natural boundaries, model the clearest one, list others as candidates.
2. **Anemic model**: Ask for business rules/invariants before modeling.
3. **Tech stack conflict (Active Record)**: Note tension, model domain correctly, suggest ORM-compatible implementation.

## Output Format
Six markdown sections. Sections 1-4 use lists. Section 5 uses code blocks. Section 6 uses definition list. 700–1200 words.

## Senior Review Checklist
1. Is this solution the simplest that could work?
2. What are the failure modes and how are they handled?
3. How does this scale to 10x load or 10x codebase size?
4. Are there security implications that need to be addressed?
5. Is the output testable and observable in production?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: examples/ and references/, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |

## MCP Dependencies
- `@modelcontextprotocol/server-sequential-thinking`
- `@modelcontextprotocol/server-memory`

## Output Path
`.agents/documents/design/domain/`

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start: Domain Modeling]) --> B{bounded_context\nclear and scoped?}
    B -- Too broad --> C[Identify natural context boundaries\nmodel only most clearly defined one\nlist others as separate candidates]
    C --> B
    B -- Yes --> D{domain_description\nhas business rules/invariants?}
    D -- No rules, only data --> E[Ask for invariants before modeling\nanemic domain model has no DDD value]
    D -- Yes --> F[Define Entities\nname + identity + attributes\ninvariants + lifecycle states]
    E --> F
    F --> G[Define Value Objects\nimmutable + no identity\nequality by value\nvalidation rules]
    G --> H[Identify Aggregate Roots\nboundary + contained entities/VOs\ninvariants enforced by root\nwhy this boundary chosen]
    H --> I{tech_stack uses\nActive Record pattern?}
    I -- Yes --> J[Note tension with aggregate boundaries\nmodel correctly\nsuggest implementation within ORM constraints]
    I -- No --> K[Define Domain Events\nPastTense naming\ntrigger + payload + consumers]
    J --> K
    K --> L[Define Repository Interfaces\nper aggregate root\nmethods with signatures\nquery methods needed]
    L --> M[Write Ubiquitous Language Glossary\n8–12 domain terms\nprecise definitions in domain expert language]
    M --> N([Output: 6-section domain model\n700–1200 words])
```