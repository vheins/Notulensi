---
name: atomic-testing
description: >
  Run tests file-by-file with automated failure recovery. Ensures each test file passes in isolation.
  Use for test suites with mixed failures requiring deterministic execution and fix-and-retry loops.
  Do NOT use for full test suite runs or writing new tests.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2000
tags: [testing, atomic, per-file, recovery-loop, regression, isolation]
author: vheins
---

# Skill: Atomic Testing

## Purpose
Orchestrates deterministic, per-file testing. Ensures every test file passes in isolation; enters recovery loops on failure to analyze and fix.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `test_directory` | string | Yes | Root test directory (e.g., `tests/`) |
| `test_runner` | string | Yes | Test command (e.g., `pytest`, `jest`) |
| `scope` | string | No | Subdirectory or pattern limit |

## Instructions
- **Discovery**: Scan `test_directory` for matching files and build execution queue.
- **Isolated Execution**: Run `test_runner` on each file individually.
- **Recovery Loop**: On failure:
  1. Identify root cause (Test vs App bug).
  2. Apply minimal fix to the CORRECT location (never both).
  3. Re-run until passing.
- **Reporting**: Summarize passed/failed/fixed counts and architectural failure patterns.
- **Constraint**: NEVER skip failing files; NEVER disable assertions.

## Edge Cases
| Case | Strategy |
|------|----------|
| Total Failure | Check global configuration or environment setup first. |
| Missing File | Verify path patterns and runner config. |
| Infinite Loop | Kill after 30s; mark timeout; investigate async issues. |

## Workflow
```mermaid
flowchart TD
    A([Start: Atomic Testing]) --> B[Parse inputs]
    B --> C[Step 1: Discover test files]
    C --> D[Step 2: Pick next file]
    D --> E{Queue empty?}
    E -- Yes --> K[Step 4: Generate Report]
    E -- No --> F[Run test in isolation]
    F --> G{Result?}
    G -- PASS --> H[Log: PASS\nMove to next file]
    H --> D
    G -- FAIL --> I[Step 3: Recovery Loop]
    I --> J{Root cause?}
    J -- Test bug --> JA[Fix TEST]
    J -- App bug --> JB[Fix APPLICATION]
    J -- Config error --> JC[Fix configuration]
    JA & JB & JC --> L[Apply MINIMAL fix]
    L --> M[Re-run SAME file]
    M --> N{Result?}
    N -- PASS --> O[Log: FIXED\nMove to next file]
    O --> D
    N -- FAIL --> P{Timeout?}
    P -- Yes --> Q[Kill after 30s\nInvestigate]
    P -- No --> I
    Q --> I
    K --> R([Output: Test Run Report])
```

## Quality Gate
- [ ] Failures analyzed before fixes.
- [ ] Fixes are minimal and targeted.
- [ ] No skipped tests in final run.
- [ ] Fixes committed separately.
- [ ] Run report is accurate.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
