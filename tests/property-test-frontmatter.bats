#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 1: Frontmatter Completeness
# Feature: skill-structure-upgrade, Property 2: Compatibility Field Contains All 7 IDEs
# Feature: skill-structure-upgrade, Property 9: Changelog Updated
#
# Tests run against all 136 SKILL.md files in .agents/skills/

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"

REQUIRED_FIELDS=(name description version license compatibility category complexity tags author)
REQUIRED_IDES=(Kiro Cursor Windsurf "GitHub Copilot" OpenCode TRAE "Claude Code")
CATEGORIES=(coding debugging testing planning documentation design idea-validation)

setup() {
  cd "$REPO_ROOT"
}

# Helper: get all SKILL.md paths (excluding scaffold-generated temp skills)
all_skill_files() {
  find "$SKILLS_ROOT" -name "SKILL.md" -not -path "*/prop1[0-9]-*" -not -path "*/prop[0-9]-*" | sort
}

# --- Property 1: Frontmatter Completeness ---

@test "Property 1: all SKILL.md files have a frontmatter block" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -q "^---" "$skill_file"; then
      failed+=("$skill_file")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || {
    echo "Missing frontmatter in: ${failed[*]}"
    return 1
  }
}

@test "Property 1: all SKILL.md files have 'name' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^name:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'name': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'description' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^description:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'description': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'version' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^version:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'version': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'license' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^license:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'license': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'compatibility' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^compatibility:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'compatibility': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'category' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^category:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'category': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have 'author' field" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^author:" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 'author': ${failed[*]}"; return 1; }
}

@test "Property 1: all SKILL.md files have license value MIT" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -qE "^license: MIT" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "license != MIT: ${failed[*]}"; return 1; }
}

# --- Property 2: Compatibility Field Contains All 7 IDEs ---

@test "Property 2: all SKILL.md compatibility field mentions Kiro" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "kiro"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing Kiro: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions Cursor" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "cursor"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing Cursor: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions Windsurf" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "windsurf"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing Windsurf: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions GitHub Copilot" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "github.copilot\|github copilot"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing GitHub Copilot: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions OpenCode" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "opencode"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing OpenCode: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions TRAE" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "trae"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing TRAE: ${failed[*]}"; return 1; }
}

@test "Property 2: all SKILL.md compatibility field mentions Claude Code" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -A5 "^compatibility:" "$skill_file" | grep -qi "claude.code\|claude code"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing Claude Code: ${failed[*]}"; return 1; }
}

# --- Property 9: Changelog Updated ---

@test "Property 9: all SKILL.md have a Changelog section" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -q "## Changelog" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing Changelog: ${failed[*]}"; return 1; }
}

@test "Property 9: all SKILL.md Changelog contains version 1.1.0 entry" {
  local failed=()
  while IFS= read -r skill_file; do
    if ! grep -q "1\.1\.0" "$skill_file"; then
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file")")
    fi
  done < <(all_skill_files)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing 1.1.0 in Changelog: ${failed[*]}"; return 1; }
}

@test "Property 9: total SKILL.md count is 136" {
  local count
  count=$(all_skill_files | wc -l)
  [ "$count" -eq 136 ]
}
