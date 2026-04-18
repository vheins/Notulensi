#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 14: Migration Idempotency
# Feature: skill-structure-upgrade, Property 6: Placeholder Format Consistency
# Feature: skill-structure-upgrade, Property 10: No Broken Links
#
# Tests run against all skill folders in .agents/skills/

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"
SCAFFOLD="$REPO_ROOT/scripts/generate-skill-scaffold.sh"
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

# Helper: all real skill dirs
all_skill_dirs() {
  find "$SKILLS_ROOT" -mindepth 2 -maxdepth 2 -type d \
    ! -name "scripts" ! -name "references" ! -name "assets" ! -name "examples" \
    ! -path "*/prop[0-9]-*" ! -path "*/prop1[0-9]-*" | sort
}

# Helper: all real SKILL.md files
all_skill_files() {
  find "$SKILLS_ROOT" -name "SKILL.md" \
    ! -path "*/prop[0-9]-*" ! -path "*/prop1[0-9]-*" | sort
}

# --- Property 14: Migration Idempotency ---

@test "Property 14: running scaffold twice does not overwrite existing skill" {
  local skill="prop14-idem-$$"
  local skill_path="$SKILLS_ROOT/coding/$skill"
  CREATED_SKILLS+=("$skill_path")

  bash "$SCAFFOLD" coding "$skill"

  # Capture hash of SKILL.md after first scaffold
  local hash1
  hash1=$(md5sum "$skill_path/SKILL.md" | awk '{print $1}')

  # Run scaffold again — should fail (skill exists) and not modify files
  bash "$SCAFFOLD" coding "$skill" 2>/dev/null || true

  local hash2
  hash2=$(md5sum "$skill_path/SKILL.md" | awk '{print $1}')

  [ "$hash1" = "$hash2" ]
}

@test "Property 14: existing subdirectory files are not overwritten by scaffold" {
  local skill="prop14-nooverwrite-$$"
  local skill_path="$SKILLS_ROOT/coding/$skill"
  CREATED_SKILLS+=("$skill_path")

  bash "$SCAFFOLD" coding "$skill"

  # Modify a file
  echo "custom content" >> "$skill_path/examples/input.md"
  local hash1
  hash1=$(md5sum "$skill_path/examples/input.md" | awk '{print $1}')

  # Try scaffold again — should not overwrite
  bash "$SCAFFOLD" coding "$skill" 2>/dev/null || true

  local hash2
  hash2=$(md5sum "$skill_path/examples/input.md" | awk '{print $1}')

  [ "$hash1" = "$hash2" ]
}

@test "Property 14: all existing skill files are stable (no unexpected changes)" {
  # Capture hashes of all SKILL.md files
  local hash_before hash_after
  hash_before=$(find "$SKILLS_ROOT" -name "SKILL.md" ! -path "*/prop*" | sort | xargs md5sum | md5sum)

  # Running validator should not modify any files
  bash "$REPO_ROOT/scripts/validate-skill-structure.sh" > /dev/null 2>&1 || true

  hash_after=$(find "$SKILLS_ROOT" -name "SKILL.md" ! -path "*/prop*" | sort | xargs md5sum | md5sum)

  [ "$hash_before" = "$hash_after" ]
}

# --- Property 6: Placeholder Format Consistency ---

@test "Property 6: no assets/template.md uses {variable} format (single braces, not double)" {
  # Match {word} that is NOT preceded or followed by another brace (i.e., not {{word}})
  local bad_files
  bad_files=$(find "$SKILLS_ROOT" -path "*/assets/template.md" | xargs grep -lP '(?<!\{)\{[a-z_][a-z_]*\}(?!\})' 2>/dev/null || true)
  [ -z "$bad_files" ] || { echo "Single-brace placeholders in: $bad_files"; return 1; }
}

@test "Property 6: no assets/template.md uses <variable> format outside code blocks" {
  # Only flag <word_with_underscore> patterns which are clearly placeholders, not HTML/code
  local bad_files
  bad_files=$(find "$SKILLS_ROOT" -path "*/assets/template.md" | xargs grep -lP '<[a-z]+_[a-z_]+>' 2>/dev/null || true)
  [ -z "$bad_files" ] || { echo "Angle-bracket placeholders in: $bad_files"; return 1; }
}

@test "Property 6: scaffold-generated assets/template.md uses {{variable}} format" {
  local skill="prop6-placeholder-$$"
  local skill_path="$SKILLS_ROOT/coding/$skill"
  CREATED_SKILLS+=("$skill_path")

  bash "$SCAFFOLD" coding "$skill"

  # template.md should contain {{...}} placeholders
  grep -q '{{' "$skill_path/assets/template.md"
}

@test "Property 6: scaffold-generated scripts/README.md uses {{variable}} format" {
  local skill="prop6-scripts-readme-$$"
  local skill_path="$SKILLS_ROOT/coding/$skill"
  CREATED_SKILLS+=("$skill_path")

  bash "$SCAFFOLD" coding "$skill"

  grep -q '{{' "$skill_path/scripts/README.md"
}

# --- Property 10: No Broken Links ---

@test "Property 10: all relative links in SKILL.md point to existing files or dirs" {
  local failed=()
  while IFS= read -r skill_file; do
    local skill_dir
    skill_dir=$(dirname "$skill_file")

    # Extract markdown links: [text](path) — only relative paths (not http/https)
    while IFS= read -r link; do
      # Skip anchors (#...) and external URLs
      [[ "$link" == "#"* ]] && continue
      [[ "$link" == "http"* ]] && continue

      # Strip trailing slash for directory check
      local target="$skill_dir/$link"
      if [[ ! -e "$target" ]]; then
        failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$skill_file"): broken link '$link'")
      fi
    done < <(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$skill_file" | grep -oE '\(([^)]+)\)' | tr -d '()' | grep -v '^http' | grep -v '^#')
  done < <(all_skill_files)

  [ "${#failed[@]}" -eq 0 ] || {
    printf '%s\n' "${failed[@]}"
    return 1
  }
}

@test "Property 10: all references/compatibility-matrix.md files exist" {
  local failed=()
  while IFS= read -r d; do
    [ -f "$d/references/compatibility-matrix.md" ] || \
      failed+=("$(realpath --relative-to="$SKILLS_ROOT" "$d")")
  done < <(all_skill_dirs)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing compatibility-matrix.md: ${failed[*]}"; return 1; }
}
