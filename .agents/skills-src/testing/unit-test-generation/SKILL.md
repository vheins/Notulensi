---
name: unit-test-generation
description: >
  Generates comprehensive unit tests for a given function, class, or module with proper mocking and edge case coverage. Do NOT use for integration or E2E tests.
version: "1.1.0"
time_saved: "5-10 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2500
tags: [unit-testing, mocks, assertions, test-coverage]
author: vheins
---

# Skill: Unit Test Generation

## Purpose
Generates production-quality unit tests with proper mocking of external dependencies, meaningful assertions, edge case coverage, and clear descriptions, following best practices for the specified tech stack.

## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `{{tech_stack}}` | string | yes | Tech stack and test framework (e.g., "TypeScript + Jest") |
| `{{code_context}}` | string | yes | Function, class, or module code |
| `{{test_framework}}` | string | no | Specific test framework (e.g., "Vitest") |

## Prompt

Act as a senior test engineer.

> **4-Concern Rule** (`.agents/rules/test-architecture.md`): Ensure tests exist in all layers (database, services, states, ui). This skill covers the **services layer**.

Code:
```
{{code_context}}
```
Stack: {{tech_stack}}
Framework: {{test_framework}}

Generate comprehensive unit tests that:

1. **Test happy path** — valid inputs.
2. **Test edge cases** — boundary values, empty inputs, null/undefined, zero, negative, maximum values.
3. **Test error conditions** — invalid inputs, exceptions, error messages.
4. **Mock external dependencies** — DB calls, API requests, FS ops, third-party services.
5. **Descriptive names** — clearly state scenario and expected outcome.
6. **Include setup/teardown** — for test isolation.
7. **Follow AAA pattern** — Arrange, Act, Assert.
8. **Verify side effects** — logging, state changes.

For each test:
- Write a clear description.
- Use appropriate matchers/assertions.
- Mock only necessary dependencies (prefer real implementations).
- Ensure isolated and order-independent execution.

Add inline comments for complex test logic. Output complete test file with imports, mocks, and test cases.

## Examples

@examples/input.md
@examples/output.md

## Edge Cases
- **No external dependencies**: Test with real implementations.
- **Async code**: Properly await results and handle promise rejections.
- **Stateful classes**: Reset state between runs or use fresh instances.

## Output Format
Complete test file (300-600 lines) with imports, setup/teardown, grouped suites, individual test cases, and inline comments.

## Senior Review Checklist
- [ ] Edge cases covered?
- [ ] Dependencies mocked properly?
- [ ] Tests isolated and order-independent?
- [ ] Descriptive names and AAA pattern?
- [ ] Side effects verified?

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |

## Output Path

```
.agents/documents/application/testing/{module-slug}/
```

## Mermaid Diagram

```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C[Analyze code/dependencies]
    C --> D{External dependencies?}
    D -- Yes --> E[Mock dependencies]
    D -- No --> F[Use real implementations]
    E & F --> G[Happy Path Tests (AAA)]
    G --> H[Edge Case Tests]
    H --> I[Error Condition Tests]
    I --> J{Side effects?}
    J -- Yes --> K[Assert side effects]
    J -- No --> L{Async code?}
    K --> L
    L -- Yes --> M[Await results/handle rejections]
    L -- No --> N{Stateful class?}
    M --> N
    N -- Yes --> O[Reset state/fresh instances]
    N -- No --> P[Write descriptive names]
    O --> P
    P --> Q[Setup/teardown for isolation]
    Q --> R([Output: Complete Test File])
```