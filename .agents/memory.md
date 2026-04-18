# Project Memory (READ-ONLY)

⚠️ **ATTENTION AGENTS:** This file is READ-ONLY. Do NOT modify this file directly.
All dynamic memory must be stored, retrieved, and updated via `@vheins/local-memory-mcp`.

---

## Memory Architecture

This project uses a hybrid memory system designed for multi-agent environments:

1. **Active/Dynamic Store (Primary)**: `@vheins/local-memory-mcp`
   - Every task MUST read from this MCP.
   - Every key decision or pattern discovery MUST be saved back to this MCP.
   - Used for sharing state between different agents (Cursor, Windsurf, Claude, etc.) working on the same project.

2. **Static Reference (Secondary)**: `.agents/memory.md` (This file)
   - Contains foundational project rules and architectural anchors.
   - Hand-maintained by humans or initialized once during project setup.
   - **Agents must treat this as a static constraint, not a writeable log.**

---

## Mandatory Agent Workflow

1. **Read MCP Memory**: Call `local-memory:memory-search` or `local-memory:memory-recap` at the start of every task.
2. **Consult Static Memory**: Read this file (`.agents/memory.md`) to load foundational constraints.
3. **Execute Task**: Perform the assigned work.
4. **Update MCP Memory**: Call `local-memory:memory-store` for any:
   - Architectural decisions made.
   - New code patterns established.
   - Critical mistakes found (to avoid repetition).
   - Tech stack choices confirmed.

---

## Foundational Anchors

<!-- Add project-specific static rules/anchors below this line -->
- This project follows the **Vibe Coding Premium** standards.
- All code must adhere to the layers defined in `@.agents/rules/coding-standards.md`.
- Database schemas must use UUIDs as defined in `@.agents/rules/database-standards.md`.
