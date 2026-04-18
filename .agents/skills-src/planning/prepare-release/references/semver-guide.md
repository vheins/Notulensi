# References: prepare-release

## Semantic Versioning

Format: `MAJOR.MINOR.PATCH`

| Increment | When |
|-----------|------|
| `MAJOR` | Breaking change — existing integrations must update |
| `MINOR` | New feature — backward-compatible |
| `PATCH` | Bug fix — backward-compatible |

## CHANGELOG Format (Keep a Changelog)

```markdown
## [VERSION] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes to existing functionality

### Deprecated
- Features that will be removed in a future release

### Removed
- Features removed in this release

### Fixed
- Bug fixes

### Security
- Security vulnerability fixes
```

Reference: [keepachangelog.com](https://keepachangelog.com)

## Git Tag Convention

```bash
git tag -a v1.2.3 -m "Release v1.2.3"
git push origin v1.2.3
```

Always use annotated tags (`-a`) not lightweight tags for releases.
