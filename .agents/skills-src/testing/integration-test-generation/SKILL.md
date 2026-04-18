---
name: integration-test-generation
description: >
  Use to generate integration tests for service interactions, API endpoints, database operations, or multi-component workflows.
  Do NOT use for unit tests or E2E tests.
version: "1.1.0"
time_saved: "Manual: 4-6 hours | With skill: 15-20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4500
tags: [integration-testing, api-testing, service-testing, database-testing]
author: vheins
---

# Skill: Integration Test Generation

## Purpose
Generate tests verifying interactions between multiple components or services using real containers/databases.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Postgres" |
| `integration_scope` | string | Yes | Target: API, DB, or Service flow |
| `code_context` | string | Yes | Code or API spec |
| `test_framework` | string | No | e.g., "TestContainers" |

## Instructions
- **Dependencies**: Use real test databases or containers (e.g., TestContainers); avoid mocks for the integration layer.
- **Workflows**: Test request/response cycles, persistence across layers, and side effects (events, logs).
- **Isolation**: Ensure setup (seeding) and teardown (DB cleaning) occur per test to avoid state leakage.
- **Scenarios**: Cover happy paths, invalid inputs, concurrent requests, and idempotency.
- **Async**: Implement polling or waits for eventually consistent operations.
- **Asserts**: Verify status codes, DB state changes, and external side effects.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Containers | Provide instructions for in-memory DBs or manual test DB setup. |
| External APIs | Use service virtualization or dedicated test accounts. |
| Long-running | Include polling logic with specific timeout thresholds. |

## Workflow
```mermaid
flowchart TD
    A([Start: Integration Test Generation]) --> B[Parse tech_stack
integration_scope
code_context, test_framework]
    B --> C{integration_scope type?}
    C -- API endpoint --> D[Test HTTP request/response cycle
status codes, response bodies
headers, auth]
    C -- Database layer --> E[Test CRUD operations
transaction boundaries
rollback behavior]
    C -- Service interaction --> F[Test multi-component workflow
side effects: emails, events, logs]
    C -- Message queue --> G[Test publish/consume
async processing
idempotency]
    D & E & F & G --> H[Setup: Use Real Dependencies
TestContainers / Docker Compose
in-memory DB / test broker
NOT mocks for integration layer]
    H --> I[beforeEach: Create test data
Seed DB with required state]
    I --> J[Write Happy Path Tests
Valid data, complete workflow
Assert at multiple layers:
HTTP status + DB state + side effects]
    J --> K[Write Error Scenario Tests
Invalid input → correct error response
Transaction rollback on failure
Idempotency: repeat operation safely]
    K --> L{Async operations
in scope?}
    L -- Yes --> M[Poll for state changes
with timeout
Verify eventual consistency]
    L -- No --> N
    M & N --> O{Concurrent requests
relevant?}
    O -- Yes --> P[Test parallel requests
race condition scenarios
DB locking behavior]
    O -- No --> Q
    P & Q --> R[afterEach: Clean DB state
Reset external service state
Clear queues]
    R --> S{No test containers
available?}
    S -- Yes --> T[Provide instructions:
in-memory DB or manual test DB setup]
    S -- No --> U
    T & U --> V([Output: Complete Integration Test File
5-10 tests, multi-layer assertions, real dependencies])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Real dependencies used (no mocks).
- [ ] DB state cleaned per test.
- [ ] Multi-layer assertions included.
- [ ] Rollback behavior tested.
- [ ] Concurrent scenarios considered.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
