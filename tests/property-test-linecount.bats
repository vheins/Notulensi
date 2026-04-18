#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 5: SKILL.md Line Count
# Feature: skill-structure-upgrade, Property 8: Required SKILL.md Sections Preserved
#
# Tests run against all 136 SKILL.md files in .agents/skills/

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"
MAX_LINES=500

setup() {
  cd "$REPO_ROOT"
}

# Helper: get all real SKILL.md paths
all_skill_files() {
  find "$SKILLS_ROOT" -name "SKILL.md" \
    ! -path "*/prop[0-9]-*" ! -path "*/prop1[0-9]-*" | sort
}

# --- Property 5: SKILL.md Line Count ≤ 500 ---

@test "Property 5: no SKILL.md exceeds 500 lines" {
  local failed=()
  while IFS= read -r skill_file; do
    local lines
    lines=$(wc -l < "$skill_file")
    if [ "$lines" -gt "$MAX_LINES" ]; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file"):$lines")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Exceeds 500 lines: ${failed[*]}"; return 1; }
}

@test "Property 5: all SKILL.md are non-empty" {
  local failed=()
  while IFS= read -r skill_file; do
    local lines
    lines=$(wc -l < "$skill_file")
    [ "$lines" -gt 0 ] || failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Empty files: ${failed[*]}"; return 1; }
}

@test "Property 5: maximum line count across all SKILL.md is ≤ 500" {
  local max_lines=0
  local max_file=""
  while IFS= read -r skill_file; do
    local lines
    lines=$(wc -l < "$skill_file")
    if [ "$lines" -gt "$max_lines" ]; then
      max_lines="$lines"
      max_file="$skill_file"
    fi
  done < <(all_skill_files)
  [ "$max_lines" -le 500 ] || { echo "Max lines: $max_lines in $max_file"; return 1; }
}

# --- Property 8: Required SKILL.md Sections Preserved ---

@test "Property 8: all SKILL.md have '## Purpose' section" {
  local failed=()
  while IFS= read -r skill_file; do
    grep -q "^## Purpose" "$skill_file" || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing ## Purpose: ${failed[*]}"; return 1; }
}

@test "Property 8: all SKILL.md have '## Input' section" {
  local failed=()
  while IFS= read -r skill_file; do
    grep -q "^## Input" "$skill_file" || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing ## Input: ${failed[*]}"; return 1; }
}

@test "Property 8: all SKILL.md have '## Prompt' section" {
  local failed=()
  while IFS= read -r skill_file; do
    grep -q "^## Prompt" "$skill_file" || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing ## Prompt: ${failed[*]}"; return 1; }
}

@test "Property 8: all SKILL.md have '## Output Format' section" {
  local failed=()
  while IFS= read -r skill_file; do
    grep -q "^## Output Format" "$skill_file" || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing ## Output Format: ${failed[*]}"; return 1; }
}

@test "Property 8: all SKILL.md have '## Changelog' section" {
  local failed=()
  while IFS= read -r skill_file; do
    grep -q "^## Changelog" "$skill_file" || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing ## Changelog: ${failed[*]}"; return 1; }
}

@test "Property 8: all SKILL.md have frontmatter (--- delimiters)" {
  local failed=()
  while IFS= read -r skill_file; do
    local fm_count
    fm_count=$(grep -c "^---$" "$skill_file" || true)
    [ "$fm_count" -ge 2 ] || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing frontmatter delimiters: ${failed[*]}"; return 1; }
}
