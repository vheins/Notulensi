---
name: release-notes-generation
description: >
  Transform raw changelog entries or git commit history into polished, user-facing release notes.
  Do NOT use for internal developer changelogs, API reference updates, or sprint retrospectives.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 5–10 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Beginner
tokens: ~4000
tags: [release-notes, changelog, documentation, user-communication, versioning]
author: kiro
---

# Agent Optimized: Release Notes Generation

## Directives
- **Content Sections**:
    1. **Breaking Changes**: Change description, migration steps, urgency. (Always first).
    2. **New Features**: Lead with benefit (1–2 sentences).
    3. **Improvements**: Observable impact (low jargon).
    4. **Bug Fixes**: Resolved symptom in past tense.
    5. **Upgrade Instructions**: Numbered steps (if applicable).
- **Audience Adaptation**:
    - **End users**: Plain language, focus on capabilities.
    - **Developers**: Technical focus, API/method changes.
    - **Enterprise**: Focus on reliability, security, ops impact.
- **Formatting**: Bold short labels per bullet. Exclude internal hashes, PRs, or tickets. Omit vague commits.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B[Parse Changelog/Commits]
    B --> C{Only Internal?}
    C -- Yes --> D[Maintenance note only]
    C -- No --> E[Classify & filter entries]
    E --> F[Select audience tone]
    F --> G[Section: Breaking Changes]
    G --> H[Section: Features & Fixes]
    H --> I{Major Jump?}
    I -- Yes --> J[Explicit Upgrade Guide]
    I -- No --> K[Finalize markdown]
    J --> K
    K --> L([Final Release Notes])
```

## Constraints
| Rule | Description |
|------|-------------|
| Priority | Breaking changes MUST be prominent and at the top. |
| Verification | Major version jumps MUST be audited for breaking changes. |
| Precision | Exclude internal SHAs, PR numbers, or bug tracker IDs. |
| Default | Default to plain language if audience is mixed. |

## Review Criteria
- [ ] User benefits lead the feature descriptions.
- [ ] Migration path for breaking changes is explicit.
- [ ] Jargon level matches `{{audience}}`.
- [ ] Upgrade instructions are verified and step-by-step.

## Metadata
- **Output Path**: `.agents/documents/operations/changelogs/`
- **Changelog**: 1.1.0 (Added metadata, audience rules); 1.0.0 (Initial).
