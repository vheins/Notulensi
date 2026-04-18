# _tasks/

Task files for active workflow and skill executions.

Each file tracks step progress, output paths, gate decisions, and context snapshots for a single workflow run.

## Naming Convention

```
{workflow-slug}.md          # e.g., idea-to-blueprint.md
{workflow-slug}-{date}.md   # if running the same workflow multiple times
```

## Lifecycle

1. **Created** — before Step 1 of any workflow
2. **Updated** — after every step and every gate
3. **Archived** — move to `_tasks/archive/` when workflow is complete

## Why This Exists

- Prevents agent from losing track of progress across sessions
- Eliminates reliance on conversation history (which can be lost or truncated)
- Provides a single source of truth for "what step are we on"
- Enables resuming a workflow after interruption without re-doing completed steps
