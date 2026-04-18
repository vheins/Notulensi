---
name: accessibility-test-case-writing
description: >
  Write accessibility test cases for WCAG 2.1 AA compliance.
  Do NOT use for performance or functional testing.
version: "1.1.0"
time_saved: "Manual: 3-4 hours | With skill: 10-15 mins"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~3000
tags: [accessibility, wcag, a11y, screen-reader, keyboard-navigation]
author: vheins
---

# Skill: Accessibility Test Case Writing

## Purpose
Generate accessibility test cases verifying UI compliance with WCAG 2.1 AA standards. Produces automated (axe-core) and manual (screen reader/keyboard) tests.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `component_or_page` | string | Yes | Target UI to test |
| `tech_stack` | string | Yes | e.g., "React + jest-axe" |
| `wcag_level` | string | No | "A", "AA", or "AAA" (default: AA) |

## Instructions
- **Coverage**: Address Perceivable (contrast, alt text), Operable (keyboard, focus), Understandable (labels, errors), and Robust (ARIA) criteria.
- **Automation**: Write axe-core or Playwright tests for detectable violations.
- **Manual Checklist**: Include screen reader and keyboard navigation verification steps.
- **References**: Map every test to a specific WCAG criterion.
- **Components**: Handle dynamic content (modals, toasts) and custom ARIA widgets.

## Edge Cases
| Case | Strategy |
|------|----------|
| Dynamic content | Test modals, toasts, and live regions for focus/announcements. |
| Custom widgets | Apply manual ARIA verification for custom non-native elements. |
| Third-party | Identify violations; provide workarounds or upstream reports. |

## Workflow
```mermaid
flowchart TD
    A([Start: Accessibility Test Case Writing]) --> B[Parse inputs]
    B --> C{WCAG level?}
    C -- No --> D[Default to AA]
    C -- Yes --> E
    D --> E[Analyze component structure]
    E --> F[Map to WCAG 2.1 criteria]
    F --> G[Perceivable 1.x]
    F --> H[Operable 2.x]
    F --> I[Understandable 3.x]
    F --> J[Robust 4.x]
    G & H & I & J --> K{Automate?}
    K -- Yes --> L[Write automated test]
    K -- No --> M[Write manual checklist]
    L & M --> N{Dynamic content?}
    N -- Yes --> O[Test modals, live regions]
    N -- No --> P
    O --> P{Custom components?}
    P -- Yes --> Q[Add manual ARIA testing]
    P -- No --> R
    Q --> R[Add WCAG references]
    R --> S([Output: Test File + Checklist])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Automated axe-core tests included.
- [ ] Keyboard navigation fully tested.
- [ ] ARIA attributes verified.
- [ ] Manual checklist provided.
- [ ] WCAG criteria referenced.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
