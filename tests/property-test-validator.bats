#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 12: Validator Accuracy
# Feature: skill-structure-upgrade, Property 13: Scaffold Generator Round-Trip
#
# Tests:
#   Property 12 — for any known non-compliant skill, validator reports all issues and exits non-zero
#   Property 13 — generate then validate must exit code 0

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
VALIDATOR="$REPO_ROOT/scripts/validate-skill-structure.sh"
SCAFFOLD="$REPO_ROOT/scripts/generate-skill-scaffold.sh"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"
TMP_SKILL=""

setup() {
  cd "$REPO_ROOT"
}

teardown() {
  # Cleanup any temp skills created during tests
  if [[ -n "$TMP_SKILL" && -d "$TMP_SKILL" ]]; then
    rm -rf "$TMP_SKILL"
  fi
}

# --- Property 12: Validator Accuracy ---

@test "Property 12: validator exits non-zero for skill missing required subdirectory" {
  local tmp_dir
  tmp_dir=$(mktemp -d "$SKILLS_ROOT/coding/prop12-test-XXXXXX")
  TMP_SKILL="$tmp_dir"
  local skill_name
  skill_name=$(basename "$tmp_dir")

  # Create minimal SKILL.md with valid frontmatter but no subdirectories
  cat > "$tmp_dir/SKILL.md" << 'EOF'
---
name: prop12-test
description: >
  Test skill for property 12 validation.
version: "1.1.0"
license: MIT
compatibility: >
  Compatible with Kiro, Cursor, Windsurf, GitHub Copilot, OpenCode, TRAE, Claude Code.
category: coding
complexity: Beginner
tags: [test]
author: test
---
# Skill: prop12-test
## Purpose
Test.
## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
## Prompt
Test prompt.
## Output Format
Test output.
## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-01-01 | Initial |
EOF

  run bash "$VALIDATOR" --category coding
  [ "$status" -ne 0 ]
}

@test "Property 12: validator reports missing subdirectory in output" {
  local tmp_dir
  tmp_dir=$(mktemp -d "$SKILLS_ROOT/coding/prop12-report-XXXXXX")
  TMP_SKILL="$tmp_dir"

  cat > "$tmp_dir/SKILL.md" << 'EOF'
---
name: prop12-report
description: >
  Test skill.
version: "1.1.0"
license: MIT
compatibility: >
  Compatible with Kiro, Cursor, Windsurf, GitHub Copilot, OpenCode, TRAE, Claude Code.
category: coding
complexity: Beginner
tags: [test]
author: test
---
# Skill: prop12-report
## Purpose
Test.
## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
## Prompt
Test.
## Output Format
Test.
## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-01-01 | Initial |
EOF

  run bash "$VALIDATOR" --category coding
  [[ "$output" == *"Missing subdirectory"* ]]
}

@test "Property 12: validator exits non-zero for skill missing frontmatter field" {
  local tmp_dir
  tmp_dir=$(mktemp -d "$SKILLS_ROOT/debugging/prop12-fm-XXXXXX")
  TMP_SKILL="$tmp_dir"
  mkdir -p "$tmp_dir/references" "$tmp_dir/examples"

  # Missing 'license' field
  cat > "$tmp_dir/SKILL.md" << 'EOF'
---
name: prop12-fm
description: >
  Test skill.
version: "1.1.0"
category: debugging
complexity: Beginner
tags: [test]
author: test
---
# Skill: prop12-fm
## Purpose
Test.
## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
## Prompt
Test.
## Output Format
Test.
## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-01-01 | Initial |
EOF

  run bash "$VALIDATOR" --category debugging
  [ "$status" -ne 0 ]
}

@test "Property 12: validator reports missing frontmatter field in output" {
  local tmp_dir
  tmp_dir=$(mktemp -d "$SKILLS_ROOT/debugging/prop12-fmrep-XXXXXX")
  TMP_SKILL="$tmp_dir"
  mkdir -p "$tmp_dir/references" "$tmp_dir/examples"

  cat > "$tmp_dir/SKILL.md" << 'EOF'
---
name: prop12-fmrep
description: >
  Test skill.
version: "1.1.0"
category: debugging
complexity: Beginner
tags: [test]
author: test
---
# Skill: prop12-fmrep
## Purpose
Test.
## Input
| Variable | Type | Required | Description |
|----------|------|----------|-------------|
## Prompt
Test.
## Output Format
Test.
## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-01-01 | Initial |
EOF

  run bash "$VALIDATOR" --category debugging
  [[ "$output" == *"Missing frontmatter field"* ]]
}

@test "Property 12: validator exits 0 for fully compliant skill" {
  # Use an existing known-compliant skill
  run bash "$VALIDATOR" --category debugging
  [ "$status" -eq 0 ]
}

# --- Property 13: Scaffold Generator Round-Trip ---

@test "Property 13: scaffold + validate exits 0 for category coding" {
  local skill_name="prop13-coding-$$"
  TMP_SKILL="$SKILLS_ROOT/coding/$skill_name"

  run bash "$SCAFFOLD" coding "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category coding
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category debugging" {
  local skill_name="prop13-debug-$$"
  TMP_SKILL="$SKILLS_ROOT/debugging/$skill_name"

  run bash "$SCAFFOLD" debugging "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category debugging
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category testing" {
  local skill_name="prop13-testing-$$"
  TMP_SKILL="$SKILLS_ROOT/testing/$skill_name"

  run bash "$SCAFFOLD" testing "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category testing
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category planning" {
  local skill_name="prop13-planning-$$"
  TMP_SKILL="$SKILLS_ROOT/planning/$skill_name"

  run bash "$SCAFFOLD" planning "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category planning
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category documentation" {
  local skill_name="prop13-docs-$$"
  TMP_SKILL="$SKILLS_ROOT/documentation/$skill_name"

  run bash "$SCAFFOLD" documentation "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category documentation
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category design" {
  local skill_name="prop13-design-$$"
  TMP_SKILL="$SKILLS_ROOT/design/$skill_name"

  run bash "$SCAFFOLD" design "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category design
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold + validate exits 0 for category idea-validation" {
  local skill_name="prop13-idea-$$"
  TMP_SKILL="$SKILLS_ROOT/idea-validation/$skill_name"

  run bash "$SCAFFOLD" idea-validation "$skill_name"
  [ "$status" -eq 0 ]

  run bash "$VALIDATOR" --category idea-validation
  [ "$status" -eq 0 ]
}
