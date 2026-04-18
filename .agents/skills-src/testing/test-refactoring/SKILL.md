---
name: test-refactoring
description: >
  Refactors brittle, slow, or duplicated tests for maintainability and reliability.
  Do NOT use for new tests or changing coverage.
version: "1.1.0"
time_saved: "Manual: 2-3h | With skill: 10-15m"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~3000
tags: [test-refactoring, test-quality, dry-tests, test-maintainability]
author: vheins
---

# Skill: Test Refactoring

## Purpose
Refactor tests to improve maintainability, reduce duplication, and increase reliability. Identify smells (brittle selectors, magic numbers, duplicated setup, over-mocking) and apply refactoring patterns. Maintain original coverage.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{test_code}}` | string | yes | Test code to refactor |
| `{{tech_stack}}` | string | yes | Tech stack and test framework |
| `{{refactoring_goals}}` | string | no | "reduce duplication", "improve readability", "fix brittleness", "improve speed" |

## Prompt

You are a senior test engineer refactoring tests.

Test code:
```
{{test_code}}
```

Tech stack: {{tech_stack}}
Goals: {{refactoring_goals}}

Fix test smells:

**1. Test Duplication (DRY)**
- Extract setup to beforeEach/setUp
- Create helper functions for assertions
- Use parameterized tests
- Extract shared fixtures

**2. Brittle Tests**
- Replace hardcoded IDs with dynamic values
- Replace CSS classes with data-testid
- Replace exact strings with partial matches
- Remove order dependency

**3. Magic Numbers/Strings**
- Extract to named constants
- Use descriptive variable names

**4. Over-Mocking**
- Remove unnecessary mocks
- Replace mocks with real implementations
- Simplify mock setup

**5. Poor Test Names**
- Rename to "should [behavior] when [condition]"
- Describe behavior, not implementation
- Group in describe blocks

**6. Slow Tests**
- Parallelize tests
- Replace slow I/O
- Reduce setup/teardown

**7. Assertion Quality**
- Replace weak assertions (toBeTruthy) with specific ones (toBe, toEqual)
- Add meaningful error messages
- Assert proper detail level

**8. Test Independence**
- Remove shared mutable state
- Ensure independent execution
- Fix order dependency

For each refactoring:
- Show before/after code
- Explain smell fixed
- Explain improvement

Output complete refactored file.

## Examples

@examples/input.md
@examples/output.md

## Edge Cases
- **Implementation testing**: Refactor to test behavior.
- **Complex setup**: Check if code needs refactoring.
- **Large tests**: Split into focused tests.

## Output Format
Refactored file with:
- Inline comments explaining refactorings
- Before/after for major changes
- Smell summary
- Same coverage
- 200-500 lines

## Senior Review Checklist
- [ ] Coverage maintained?
- [ ] Smells addressed?
- [ ] Readable and understandable?
- [ ] Independent execution?
- [ ] Parameterized tests used?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |

## Output Path

```
.agents/documents/application/testing/{module-slug}/
```

## Mermaid Diagram

```mermaid
flowchart TD
    A([Start: Test Refactoring]) --> B[Parse inputs]
    B --> C[Scan Smells]
    C --> D{Duplicated setup?}
    D -- Yes --> E[Extract setup/helpers/fixtures/params]
    D -- No --> F
    C --> G{Brittle selectors?}
    G -- Yes --> H[Use data-testid/dynamic IDs/remove order]
    G -- No --> I
    C --> J{Magic values?}
    J -- Yes --> K[Extract named constants/variables]
    J -- No --> L
    C --> M{Over-mocking?}
    M -- Yes --> N[Remove/replace/simplify mocks]
    M -- No --> O
    C --> P{Poor names?}
    P -- Yes --> Q[Rename should/when, describe blocks]
    P -- No --> R
    C --> S{Weak assertions?}
    S -- Yes --> T[Use specific assertions/messages]
    S -- No --> U
    C --> V{Dependencies?}
    V -- Yes --> W[Remove shared state/fix order]
    V -- No --> X
    E & F & H & I & K & L & N & O & Q & R & T & U & W & X --> Y[Verify coverage]
    Y --> Z{Maintained?}
    Z -- No --> AA[Add missing cases]
    Z -- Yes --> AB[Add comments/show before/after]
    AA --> AB
    AB --> AC([Output: Refactored Test File])
```