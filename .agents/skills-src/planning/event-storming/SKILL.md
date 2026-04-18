---
name: event-storming
description: Produces an event storming output for a business domain (events, commands, aggregates, contexts, timeline). DO NOT use for domain modeling of a single context or API design.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [event-storming, DDD, domain-events, commands, aggregates, bounded-contexts, event-driven]
author: vheins
---

# Skill: Event Storming

## Purpose
Produces structured event storming documentation identifying domain events, commands, aggregates, bounded contexts, and timeline. Replicates workshop outputs for distributed teams.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{domain_description}}` | string | yes | Business domain (e.g., "Food delivery") |
| `{{business_process}}` | string | yes | Process to storm (e.g., "Customer orders food") |

## Prompt
Act as a senior DDD facilitator.

Domain: {{domain_description}}
Process: {{business_process}}

Produce 5 sections:

**1. Domain Events (Orange)**
Domain Events represent something that happened in the system. Names must be **past tense verbs** (e.g., `OrderPlaced`, `UserRegistered`, `PaymentFailed`).
List domain events. For each:
- Event name (PastTense)
- Trigger condition
- Payload fields
- Business significance

**2. Commands (Blue)**
Commands represent intentions to change state. Names must be **present tense imperative** (e.g., `PlaceOrder`, `RegisterUser`, `ProcessPayment`).
List commands triggering events. For each:
- Command name (PresentTenseImperative)
- Issuer
- Event produced
- Preconditions

**3. Aggregates (Yellow)**
Identify processing aggregates. For each:
- Name
- Handled commands
- Emitted events
- Key invariants

**4. Bounded Contexts**
Group aggregates and events. For each:
- Name
- Aggregates contained
- Upstream/downstream events
- Integration points

**5. Event Flow Timeline**
Create a numbered chronological timeline:
Step N: [Actor] issues [Command] → [Aggregate] processes → [Event] emitted → [Next step trigger]

Identify:
- Hotspots: Mark high complexity/risk steps with ⚠️.
- Pivotal events: Events triggering most downstream reactions.

If process is too broad, identify sub-processes and ask to select one.

## Examples
@examples/input.md
@examples/output.md

## Edge Cases
1. **Process too large**: Identify 3–5 sub-processes, ask developer to pick one.
2. **Missing business rules**: Make assumptions, label them, ask developer to validate.
3. **Naming conflicts**: Prefix with context name (e.g., "Order.OrderUpdated"), explain reasoning.

## Output Format
Five markdown sections. Sections 1–4 use structured lists. Section 5 uses numbered timeline with annotations. 600–1000 words.

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

## Output Path
`.agents/documents/design/domain/`

## Mermaid Diagram
```mermaid
flowchart TD
    A([Start: Event Storming]) --> B{business_process\ntoo broad?}
    B -- Yes --> C[Identify 3–5 natural sub-processes\nask developer to select one\nbefore proceeding]
    C --> B
    B -- No --> D[Identify Domain Events\nPastTense naming\ntrigger + payload + business significance]
    D --> E[Identify Commands\nPresentTenseImperative\nwho issues + what event produced\npreconditions]
    E --> F[Identify Aggregates\ncommands handled + events emitted\nkey invariants enforced]
    F --> G{Missing business rules\nor preconditions?}
    G -- Yes --> H[Make reasonable assumptions\nlabel as assumptions\nask developer to validate with domain expert]
    G -- No --> I[Define Bounded Contexts\ngroup aggregates + events\nupstream/downstream events\nintegration points]
    H --> I
    I --> J{Event naming conflicts\nacross contexts?}
    J -- Yes --> K[Prefix with context name\ne.g. OrderManagement.OrderUpdated\nexplain why context-scoped naming needed]
    J -- No --> L[Build Event Flow Timeline\nnumbered steps:\nActor → Command → Aggregate → Event → Next trigger]
    K --> L
    L --> M[Annotate Hotspots ⚠️\nhigh complexity/risk/uncertainty steps]
    M --> N[Identify Pivotal Events\nevents triggering most downstream reactions]
    N --> O([Output: 5-section event storming doc\n600–1000 words])
```