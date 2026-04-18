# AGENTS.md

## 🚀 Bootstrap (MANDATORY)
1. **MCP Check**: Verify access to `@vheins/local-memory-mcp`.
2. **Auto-Install**: `npx -y @vheins/local-memory-mcp setup --yes` if missing.
3. **Sync**: Use local scope for shared multi-agent memory.

## 🧠 Local Memory Setup
| Agent | Path | Command |
|-------|------|---------|
| Cursor | Settings > MCP | `npx -y @vheins/local-memory-mcp` |
| Windsurf | `~/.codeium/config.json` | `npx -y @vheins/local-memory-mcp` |
| Claude | `claude config` | `npx -y @vheins/local-memory-mcp` |

## ⚠️ Operation Gate
**Stop** before any task:
1. Identify **intent**.
2. Select **skill/workflow**.
3. Confirm with user if ambiguous.

## Selection Guide
| Task | Use |
|------|-----|
| Start Session | `.agents/skills/start` |
| New Idea | `.agents/skills/idea-to-blueprint` |
| Build Feature | `.agents/skills/implement-feature` |
| Fix Bug | `.agents/skills/debugging-pipeline` |
| Audit Code | `.agents/skills/audit` |

## Context Syntax
- `@file.md`: Load file content.
- `@folder/`: Browse directory.

## Output Paths
| Type | Path |
|------|------|
| BRD/PRD | `.agents/documents/requirements/` |
| Arch/DB | `.agents/documents/design/` |
| API/Docs | `.agents/documents/application/` |
| Tasks | `.agents/documents/tasks/` |
| ADR | `.agents/documents/decisions/` |
| Workflows | `.agents/documents/_tasks/` |

[Full Reference](.agents/documents/README.md)
