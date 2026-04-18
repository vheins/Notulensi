# INSTALL.md

## 1. Scope
| Scope | Visibility | Best For |
|-------|------------|----------|
| Project | Current repo | Per-project config |
| User | All repos | Personal setup |
| System | All users | Shared machines |

## 2. Link Skills
Replace `/path/to/vibe` with absolute path.

### macOS / Linux
```bash
ln -s "/path/to/vibe/.agents/skills" .cursor/skills
ln -s "/path/to/vibe/.agents/skills" .windsurf/skills
ln -s "/path/to/vibe/.agents/skills" .claude/skills
```

### Windows (PowerShell)
```powershell
New-Item -ItemType Junction -Path .cursor\skills -Target "C:\path\to\vibe\.agents\skills"
```

## 3. Validate
```bash
bash scripts/validate-skill-structure.sh
```

## 4. Update
```bash
git pull origin master
```
(Symlinks update automatically).

```