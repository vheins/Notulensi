---
name: onboarding-guide-creation
description: >
  Create structured developer onboarding guides for new hires or contributors, covering setup, architecture, codebase tour, workflow, and first tasks.
  Do NOT use for API reference generation, operational runbooks, or architecture decision records.
version: "1.1.0"
time_saved: "15–20 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~10000
tags: [onboarding, developer-experience, documentation, setup, architecture, workflow, first-task]
author: vheins
---

# Agent Optimized: Onboarding Guide Creation

## Directives
- **Welcome**: Outline project impact, system integration, and 2-week success metrics.
- **Setup**: Provide Checklist (8-12 items) for tools/access tailored to `{{tech_stack}}`.
- **Architecture**: List 4-8 Key Components and trace primary Data Flow (6-10 steps).
- **Tour**: Detail Directory Tree, 5-8 Key Files, and Naming Conventions.
- **Workflow**: Specify Branching, PR Process, Review Standards, and CI/CD.
- **First Task**: Walkthrough Goal, Files to change, Commands, and DoD.
- **Contacts**: Provide Table (Key Contacts) and list 6-10 essential Resource links.

## Constraints
- **Missing URL**: If `{{repo_url}}` is missing, use `https://github.com/your-org/{{project_name}}`.
- **Missing Task**: If `{{first_task_description}}` is missing, generate a stack-appropriate beginner task.
- **Tone**: Professional, encouraging, and clear.

## Strategy: Edge Cases
| Case | Strategy |
|------|----------|
| Pre-launch/Empty | Generate placeholder tour; note to update later. |
| Large monorepo | Scope tour to relevant subdirectory. |
| Remote/Async | Include async communication guidance and documentation norms. |
| Open-source | Replace internal tools with public equivalents. |

## Format
- Seven numbered sections (`##`) separated by `---`.
- Markdown tables and checklists (`- [ ]`).
- Code commands in fenced blocks.
- Word Count: 900–1,500 words.

## Verification: Senior Review
- [ ] Welcome section defines success for the first 2 weeks?
- [ ] Architecture overview includes both components and flow?
- [ ] First task is atomic and verifiable?
- [ ] Repo URLs are consistent throughout?

## Metadata
- **Path**: `.agents/documents/operations/runbooks/`
- **Mermaid**:
```mermaid
flowchart TD
    A([Start: Onboarding Guide Request]) --> B{project_name +\ntech_stack + team_name\nprovided?}
    B -- No --> C[Ask for missing\nrequired inputs]
    C --> B
    B -- Yes --> D[Write Welcome section\nproject purpose + team role\n+ 2-week success definition]
    D --> E[Generate Environment Setup\nchecklist tailored to tech_stack]
    E --> F{repo_url\nprovided?}
    F -- No --> G[Use placeholder URL\nadd replacement note]
    F -- Yes --> H[Use actual repo URL\nin all references]
    G & H --> I[Write Architecture Overview\ncomponents + data flow]
    I --> J{Is project\npre-launch / empty repo?}
    J -- Yes --> K[Generate placeholder structure\nadd prominent note to update later]
    J -- No --> L[Write Codebase Tour\ndirectory structure + key files\n+ naming conventions]
    K --> M
    L --> M[Write Development Workflow\nbranching + PR process\n+ code review + CI/CD]
    M --> N{first_task_description\nprovided?}
    N -- No --> O[Generate suitable beginner task\nfor tech_stack\nLabel as suggestion]
    N -- Yes --> P[Use provided task\nfor First Task Walkthrough]
    O & P --> Q[Write step-by-step walkthrough\nwith exact commands\n+ verification + DoD]
    Q --> R{Is guide for\nopen-source contributors?}
    R -- Yes --> S[Replace internal tools\nwith public equivalents]
    R -- No --> T[Write Key Contacts table\n+ Resources list]
    S --> T
    T --> U([Output: 7-section onboarding guide\n900–1500 words])
```
