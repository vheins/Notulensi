---
name: mock-stub-generation
description: >
  Use to generate mocks and stubs for external dependencies like APIs, databases, or third-party services in unit tests.
  Do NOT use for integration tests or E2E tests where real dependencies should be used.
version: "1.1.0"
time_saved: "Manual: 1-2 hours | With skill: 5-10 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2500
tags: [mocking, stubs, test-doubles, unit-testing]
author: vheins
---

# Skill: Mock and Stub Generation

## Purpose
Generate mocks, stubs, or fakes for external dependencies to enable isolated unit testing with proper type safety.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `dependency_interface` | string | Yes | Interface/Class to mock |
| `tech_stack` | string | Yes | e.g., "TypeScript + Jest" |
| `mock_behavior` | string | No | e.g., "return success on call 1" |

## Instructions
- **Pattern Matching**: Implement all original interface methods using the correct pattern (Stub, Mock, Spy, or Fake).
- **Type Safety**: Ensure signatures match perfectly (TypeScript/Typed Python).
- **Realism**: Return data structures matching production format with realistic values, not just empty objects.
- **Async**: Properly handle `Promise` or `await` matching the original interface.
- **Configurability**: Support success/error scenarios and configurable return values per test.
- **Reusability**: Provide factory functions and extract mock data into fixtures.

## Edge Cases
| Case | Strategy |
|------|----------|
| Complex Types | Extract nested/large data into separate fixture files. |
| Stateful | Use `side_effect` or state variables to simulate behavior changes across calls. |
| Async | Ensure returned Promises resolve/reject as the original service would. |

## Workflow
```mermaid
flowchart TD
    A([Start: Mock and Stub Generation]) --> B[Parse dependency_interface
tech_stack, mock_behavior]
    B --> C[Analyze interface:
all methods, type signatures
async vs sync operations]
    C --> D{What pattern fits
the use case?}
    D -- Returns fixed values
no logic needed --> E[Stub
Predefined return values]
    D -- Need to verify
calls were made --> F[Mock
Records calls + allows verification]
    D -- Wrap real impl
track calls --> G[Spy
Wraps real implementation]
    D -- Simplified working
implementation --> H[Fake
In-memory DB / fake service]
    E & F & G & H --> I[Implement all methods
from original interface
with correct type signatures]
    I --> J{Async operations
in interface?}
    J -- Yes --> K[Return Promises/coroutines
matching original interface
not plain values]
    J -- No --> L
    K & L --> M[Provide Realistic Defaults
not empty objects or 'test'
realistic field values
proper data formats]
    M --> N{mock_behavior
specified?}
    N -- Yes --> O[Configure specific behavior:
success on first call
error on second call
state changes across calls]
    N -- No --> P[Provide configurable
return values per test]
    O & P --> Q[Add Success Scenario
configuration method]
    Q --> R[Add Error Scenario
configuration method]
    R --> S{Complex return types
or large data structures?}
    S -- Yes --> T[Extract mock data
into separate fixture files]
    S -- No --> U
    T & U --> V[Create factory functions
for common mock configurations
Document limitations]
    V --> W[Show example usage
in 2-3 tests]
    W --> X([Output: Complete Mock Code
Factory + config methods + realistic data + examples])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Complete interface implemented.
- [ ] Type signatures are accurate.
- [ ] Success/Error scenarios supported.
- [ ] Realistic data values used.
- [ ] Factory functions provided.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
