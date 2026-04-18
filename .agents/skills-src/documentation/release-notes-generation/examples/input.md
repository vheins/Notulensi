# Example Input: release-notes-generation

### Example 1: SaaS Product — End User Release Notes
**Input:**
- `{{product_name}}`: "Acme Dashboard"
- `{{version}}`: "3.2.0"
- `{{release_date}}`: "January 15, 2025"
- `{{changelog_or_commits}}`: "feat: add dark mode toggle to user settings; fix: dashboard charts not loading on Safari 16; perf: reduce initial page load time by 40%; feat: export reports to CSV; chore: upgrade webpack to v5"
- `{{audience}}`: "end users"


### Example 2: Mobile App — iOS/Android v3.0 Major Release
**Input:**
- `{{project_name}}`: "TaskFlow Mobile"
- `{{version}}`: "3.0.0"
- `{{audience}}`: "end users (non-technical)"
- `{{changes}}`: "New: offline mode, dark theme, widget support; Improved: 60% faster sync; Fixed: notification badge count; Removed: legacy import format"
