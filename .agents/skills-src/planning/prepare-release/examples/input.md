# Example Input: prepare-release

## Example 1: Minor release

| Variable | Value |
|----------|-------|
| `{{current_version}}` | `1.4.2` |
| `{{release_type}}` | `minor` |
| `{{changelog_file}}` | `CHANGELOG.md` |
| `{{version_files}}` | `package.json, package-lock.json` |

---

## Example 2: Patch release

| Variable | Value |
|----------|-------|
| `{{current_version}}` | `2.1.0` |
| `{{release_type}}` | `patch` |
| `{{changelog_file}}` | `CHANGELOG.md` |
| `{{version_files}}` | `composer.json` |
