---
name: changelog-generation
description: >
  Generate a CHANGELOG.md following the Keep a Changelog format from git logs or lists of changes.
  Do NOT use for release notes in a different format, API docs, or commit message generation.
version: "1.1.0"
time_saved: "Manual: 1-2 hours | With skill: 5–10 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Beginner
tokens: ~5000
tags: [changelog, release-notes, keep-a-changelog, semver, documentation, versioning]
author: vheins
---

# Agent Optimized: Changelog Generation

## Directives
- **Format**: Strictly follow "Keep a Changelog" (GFM).
- **Structure**:
    - **Header**: Standard intro and SEMVER statement.
    - **Sections**: `## [Unreleased]` followed by versioned blocks `## [X.Y.Z] - YYYY-MM-DD`.
    - **Order**: Reverse chronological.
    - **Categories**: Added, Changed, Deprecated, Removed, Fixed, Security.
- **Categorization Logic**:
    - `feat:`/`add` -> **Added**
    - `fix:`/`bug` -> **Fixed**
    - `chore:`/`refactor:`/`perf:`/`update` -> **Changed**
    - `security:`/`cve` -> **Security**
    - `deprecate:`/`remove:` -> **Deprecated/Removed**
- **Content**: Concise past-tense bullets. Exclude SHAs and PR numbers.
- **Diff Links**: If `{{repo_url}}` provided, append comparison links at EOF.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B[Group commits by Version/Tag]
    B --> C[Classify commits by prefix/type]
    C --> D[Identify & Filter Bot/Merge commits]
    D --> E[Convert to past-tense bullets]
    E --> F[Generate Unreleased section]
    F --> G[Generate Versioned sections]
    G --> H{Repo URL?}
    H -- Yes --> I[Append comparison diff links]
    H -- No --> J[Finalize markdown]
    I --> J
    J --> K([Final CHANGELOG.md])
```

## Constraints
| Rule | Description |
|------|-------------|
| Formatting | Use bold category headers (`### Added`). |
| Dates | Use `YYYY-MM-DD`. Use placeholders if dates are missing. |
| Versions | Default to `{{current_version}}` if no tags found in log. |
| Scope | Changelog transformation only; do not generate commit messages. |

## Review Criteria
- [ ] No raw SHAs/PR numbers in bullets.
- [ ] All commits categorized correctly per logic.
- [ ] Comparison links valid for the repo structure.
- [ ] Header/Introduction matches standard spec.

## Metadata
- **Output Path**: `.agents/documents/operations/changelogs/`
- **Changelog**: 1.1.0 (Added metadata, refined categorization); 1.0.0 (Initial).
