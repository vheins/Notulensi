# Release Checklist Template

**Version:** {new_version}
**Release Type:** major | minor | patch
**Date:** {date}

---

## Pre-Release

- [ ] All tests passing
- [ ] No open critical bugs
- [ ] Migration scripts tested on staging
- [ ] CHANGELOG.md entry written
- [ ] Version bumped in all files

## Version Files to Update

| File | Field | Before | After |
|------|-------|--------|-------|
| `package.json` | `version` | | |
| `composer.json` | `version` | | |

## CHANGELOG Entry

```markdown
## [{new_version}] - {date}

### Added
-

### Changed
-

### Fixed
-

### Migration Required
-
```

## Git Commands

```bash
git add .
git commit -m "chore: bump version to {new_version}"
git tag -a v{new_version} -m "Release v{new_version}"
git push origin {branch} --tags
```

## Post-Release

- [ ] Tag pushed to remote
- [ ] Release notes published
- [ ] Team notified
