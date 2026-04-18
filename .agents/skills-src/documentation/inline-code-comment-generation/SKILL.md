---
name: inline-code-comment-generation
description: >
  Add inline comments to existing code explaining non-obvious logic, business rules, performance trade-offs, security, and TODO/FIXME markers.
  Do NOT use for generating API documentation, READMEs, or commenting self-explanatory code.
version: "1.1.0"
time_saved: "Manual: 30-60 minutes | With skill: 5 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Beginner
tokens: ~3500
tags: [inline-comments, code-documentation, code-clarity, technical-debt, developer-experience]
author: vheins
---

# Agent Optimized: Inline Code Comment Generation

## Directives
- **Reasoning over Description**: Comment the "why", not the "what".
- **Business Logic**: Name rules and rationale for constants/thresholds.
- **Performance**: Explain trade-offs for algorithms or data structures.
- **Security**: Detail mitigated threats or invariants for auth/PII.
- **Markers**: Add `TODO`/`FIXME` with context and deferral reason.
- **Preservation**: Return full snippet verbatim with comments inserted; no refactoring.

## Constraints
- **Style**: Apply `{{comment_style}}` (e.g., JSDoc, PEP 8) consistently.
- **Filtering**: Skip standard library calls, simple getters, and descriptive declarations.
- **Language**: Use `{{tech_stack}}` appropriate syntax.

## Strategy: Edge Cases
| Case | Strategy |
|------|----------|
| Over-commented | Flag redundant comments for removal in Notes. |
| Missing context | Insert `// TODO: document origin` for magic numbers. |
| Minified/Generated | Refuse and request original source. |
| Mixed styles | Apply requested style; note inconsistencies in existing code. |

## Format
- Original code block verbatim with inline comments.
- Specified comment syntax only.
- Optional "Notes" list following the code block.

## Verification: Senior Review
- [ ] Reasoning explained for non-obvious blocks?
- [ ] Magic numbers have named rules/rationale?
- [ ] Algorithm trade-offs documented?
- [ ] Verification: Verbatim code preserved?

## Metadata
- **Path**: `.agents/documents/application/modules/{module-slug}/`
- **Mermaid**:
```mermaid
flowchart TD
    A([Start]) --> B{minified or
auto-generated?}
    B -- Yes --> C[Refuse: ask for original]
    B -- No --> D{context provided?}
    D -- Yes --> E[Load domain rules]
    D -- No --> F[Proceed without context]
    E & F --> G[Scan for comment-worthy patterns]
    G --> H{Pattern type?}
    H -- Business rule --> I[Add comment naming rule]
    H -- Performance trade-off --> J[Explain algorithm choice]
    H -- Security check --> K[Name threat mitigated]
    H -- Known limitation --> L[Add contextual TODO/FIXME]
    H -- Self-evident --> M[Skip]
    I & J & K & L --> N{context missing for threshold?}
    N -- Yes --> O[Insert TODO: document origin]
    N -- No --> P[Apply comment_style]
    O --> P
    P --> Q{Existing comments low-value?}
    Q -- Yes --> R[Flag redundant comments in Notes]
    Q -- No --> S[Return commented code verbatim]
    R --> S
    S --> T([Output: annotated code + Notes])
```
