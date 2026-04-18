---
name: debugging-pipeline
description: >
  Use to diagnose, fix, and regression-test failures. Covers error analysis, root cause, fix, and regression testing. Do NOT use for new features or code review.
version: "1.0.0"
license: Proprietary — Personal Use Only
category: workflows
type: Pipeline
complexity: Intermediate
tags: [workflow, debugging-pipeline]
author: vheins
---

# Skill: Debugging Pipeline

## Purpose
Diagnoses and resolves failures, regressions, and performance bottlenecks.

## Operations

### 🔴 GATE 0 (ask_user)
- **Question**: "Start Debugging Pipeline (Analysis, Root Cause, Fix, Regression Test)?"

### Classification & Step Mapping

| Type | Symptom | Action |
|------|---------|--------|
| Runtime | Stack trace | `error-analysis` + `root-cause-id` |
| Silent | Anomalous behavior| `log-interpretation` |
| Build | CI/CD Fail | `build-failure-analysis` |
| Perf | Slow/High Usage | `performance-bottleneck-analysis` |
| Arch | Layer Violation | `deep-audit` |

## Fix & Verification
1. **Suggest Fix**: `fix-suggestion` (Before/After).
2. **Review**: `code-review`.
3. **Apply**: `refactoring`.
4. **Regression**: `unit-test-generation` (Reproduce first).
5. **Verify**: Full suite run.
6. **Sync**: `update-documentation` (if behavior changed).

## 🔴 GATES
- **Gate 1**: Confirm Root Cause.
- **Gate 2**: Confirm Fix implementation.
- **Gate Final**: Fixed + Verified + Documented.

## Mermaid Diagram
```mermaid
flowchart TD
    A([Failure]) --> B[1-2. Diagnose]
    B --> G1{🔴 G1}
    G1 -- Yes --> C[3-5. Fix & Review]
    C --> G2{🔴 G2}
    G2 -- Yes --> D[6-7. Regression & Verify]
    D --> E[8. Doc Sync]
    E --> GF{🔴 Gate Final}
    GF -- Done --> F([System Stable ✅])
```
