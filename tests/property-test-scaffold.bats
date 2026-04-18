#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 13: Scaffold Generator Round-Trip
# Feature: skill-structure-upgrade, Property 11: Kebab-Case Filenames
#
# Tests:
#   Property 13 — for any valid (category, skill-name), generate then validate exits 0
#   Property 11 — all files created by scaffold use kebab-case naming

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
SCAFFOLD="$REPO_ROOT/scripts/generate-skill-scaffold.sh"
VALIDATOR="$REPO_ROOT/scripts/validate-skill-structure.sh"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"

VALID_CATEGORIES=(coding debugging testing planning documentation design idea-validation)
CREATED_SKILLS=()

setup() {
  cd "$REPO_ROOT"
}

teardown() {
  for skill_path in "${CREATED_SKILLS[@]}"; do
    [[ -d "$skill_path" ]] && rm -rf "$skill_path"
  done
  CREATED_SKILLS=()
}

# Helper: register skill for cleanup
register_cleanup() {
  CREATED_SKILLS+=("$1")
}

# --- Property 13: Scaffold Generator Round-Trip ---

@test "Property 13: scaffold exits 0 for valid category and kebab-case name" {
  local skill="prop11-round-trip-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  run bash "$SCAFFOLD" coding "$skill"
  [ "$status" -eq 0 ]
}

@test "Property 13: scaffold creates SKILL.md" {
  local skill="prop11-has-skillmd-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -f "$SKILLS_ROOT/coding/$skill/SKILL.md" ]
}

@test "Property 13: scaffold coding creates all 4 required subdirs" {
  local skill="prop11-coding-subdirs-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -d "$SKILLS_ROOT/coding/$skill/scripts" ]
  [ -d "$SKILLS_ROOT/coding/$skill/references" ]
  [ -d "$SKILLS_ROOT/coding/$skill/assets" ]
  [ -d "$SKILLS_ROOT/coding/$skill/examples" ]
}

@test "Property 13: scaffold debugging creates references and examples only" {
  local skill="prop11-debug-subdirs-$$"
  register_cleanup "$SKILLS_ROOT/debugging/$skill"
  bash "$SCAFFOLD" debugging "$skill"
  [ -d "$SKILLS_ROOT/debugging/$skill/references" ]
  [ -d "$SKILLS_ROOT/debugging/$skill/examples" ]
  [ ! -d "$SKILLS_ROOT/debugging/$skill/scripts" ]
  [ ! -d "$SKILLS_ROOT/debugging/$skill/assets" ]
}

@test "Property 13: scaffold testing creates all 4 required subdirs" {
  local skill="prop11-testing-subdirs-$$"
  register_cleanup "$SKILLS_ROOT/testing/$skill"
  bash "$SCAFFOLD" testing "$skill"
  [ -d "$SKILLS_ROOT/testing/$skill/scripts" ]
  [ -d "$SKILLS_ROOT/testing/$skill/references" ]
  [ -d "$SKILLS_ROOT/testing/$skill/assets" ]
  [ -d "$SKILLS_ROOT/testing/$skill/examples" ]
}

@test "Property 13: scaffold planning creates references, assets, examples" {
  local skill="prop11-planning-subdirs-$$"
  register_cleanup "$SKILLS_ROOT/planning/$skill"
  bash "$SCAFFOLD" planning "$skill"
  [ -d "$SKILLS_ROOT/planning/$skill/references" ]
  [ -d "$SKILLS_ROOT/planning/$skill/assets" ]
  [ -d "$SKILLS_ROOT/planning/$skill/examples" ]
  [ ! -d "$SKILLS_ROOT/planning/$skill/scripts" ]
}

@test "Property 13: scaffold + validate exits 0 for all 7 categories" {
  for cat in "${VALID_CATEGORIES[@]}"; do
    local skill="prop13-all-${cat}-$$"
    register_cleanup "$SKILLS_ROOT/$cat/$skill"
    bash "$SCAFFOLD" "$cat" "$skill"
    run bash "$VALIDATOR" --category "$cat"
    [ "$status" -eq 0 ]
  done
}

@test "Property 13: scaffold exits non-zero for invalid category" {
  run bash "$SCAFFOLD" invalid-category my-skill
  [ "$status" -ne 0 ]
}

@test "Property 13: scaffold exits non-zero for existing skill" {
  local skill="prop13-existing-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  run bash "$SCAFFOLD" coding "$skill"
  [ "$status" -ne 0 ]
}

# --- Property 11: Kebab-Case Filenames ---

@test "Property 11: all files created by scaffold use kebab-case naming" {
  local skill="prop11-kebab-check-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"

  # Find all files in the skill dir (excluding SKILL.md and README.md which are uppercase by convention)
  local bad_files
  bad_files=$(find "$SKILLS_ROOT/coding/$skill" -type f ! -name "SKILL.md" ! -name "README.md" | while read -r f; do
    fname=$(basename "$f")
    # kebab-case: lowercase letters, digits, hyphens, with extension
    if ! echo "$fname" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*\.[a-z]+$'; then
      echo "$fname"
    fi
  done)

  [ -z "$bad_files" ]
}

@test "Property 11: scaffold creates examples/input.md (kebab-case)" {
  local skill="prop11-input-md-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -f "$SKILLS_ROOT/coding/$skill/examples/input.md" ]
}

@test "Property 11: scaffold creates examples/output.md (kebab-case)" {
  local skill="prop11-output-md-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -f "$SKILLS_ROOT/coding/$skill/examples/output.md" ]
}

@test "Property 11: scaffold creates references/compatibility-matrix.md (kebab-case)" {
  local skill="prop11-compat-md-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -f "$SKILLS_ROOT/coding/$skill/references/compatibility-matrix.md" ]
}

@test "Property 11: scaffold creates assets/template.md (kebab-case)" {
  local skill="prop11-template-md-$$"
  register_cleanup "$SKILLS_ROOT/coding/$skill"
  bash "$SCAFFOLD" coding "$skill"
  [ -f "$SKILLS_ROOT/coding/$skill/assets/template.md" ]
}
