#!/usr/bin/env bats
# Feature: skill-structure-upgrade, Property 3: Required Subdirectories per Category
# Feature: skill-structure-upgrade, Property 4: Required Files in Subdirectories
# Feature: skill-structure-upgrade, Property 7: Script Headers
#
# Tests run against all skill folders in .agents/skills/

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
SKILLS_ROOT="$REPO_ROOT/.agents/skills"

setup() {
  cd "$REPO_ROOT"
}

# Helper: list real skill dirs for a category (exclude temp/scaffold test dirs)
skill_dirs() {
  local cat="$1"
  find "$SKILLS_ROOT/$cat" -mindepth 1 -maxdepth 1 -type d \
    ! -name "prop[0-9]*" ! -name "prop1[0-9]*" | sort
}

# --- Property 3: Required Subdirectories per Category ---

@test "Property 3: all coding skills have scripts/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/scripts" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs coding)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing scripts/: ${failed[*]}"; return 1; }
}

@test "Property 3: all coding skills have references/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/references" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs coding)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing references/: ${failed[*]}"; return 1; }
}

@test "Property 3: all coding skills have assets/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/assets" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs coding)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing assets/: ${failed[*]}"; return 1; }
}

@test "Property 3: all coding skills have examples/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/examples" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs coding)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing examples/: ${failed[*]}"; return 1; }
}

@test "Property 3: all testing skills have scripts/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/scripts" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs testing)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing scripts/: ${failed[*]}"; return 1; }
}

@test "Property 3: all testing skills have references/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/references" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs testing)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing references/: ${failed[*]}"; return 1; }
}

@test "Property 3: all testing skills have assets/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/assets" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs testing)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing assets/: ${failed[*]}"; return 1; }
}

@test "Property 3: all testing skills have examples/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/examples" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs testing)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing examples/: ${failed[*]}"; return 1; }
}

@test "Property 3: all debugging skills have references/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/references" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs debugging)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing references/: ${failed[*]}"; return 1; }
}

@test "Property 3: all debugging skills have examples/ subdirectory" {
  local failed=()
  while IFS= read -r d; do
    [ -d "$d/examples" ] || failed+=("$(basename "$d")")
  done < <(skill_dirs debugging)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing examples/: ${failed[*]}"; return 1; }
}

@test "Property 3: all planning skills have references/, assets/, examples/" {
  local failed=()
  while IFS= read -r d; do
    { [ -d "$d/references" ] && [ -d "$d/assets" ] && [ -d "$d/examples" ]; } \
      || failed+=("$(basename "$d")")
  done < <(skill_dirs planning)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing subdirs: ${failed[*]}"; return 1; }
}

@test "Property 3: all documentation skills have references/, assets/, examples/" {
  local failed=()
  while IFS= read -r d; do
    { [ -d "$d/references" ] && [ -d "$d/assets" ] && [ -d "$d/examples" ]; } \
      || failed+=("$(basename "$d")")
  done < <(skill_dirs documentation)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing subdirs: ${failed[*]}"; return 1; }
}

@test "Property 3: all design skills have references/, assets/, examples/" {
  local failed=()
  while IFS= read -r d; do
    { [ -d "$d/references" ] && [ -d "$d/assets" ] && [ -d "$d/examples" ]; } \
      || failed+=("$(basename "$d")")
  done < <(skill_dirs design)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing subdirs: ${failed[*]}"; return 1; }
}

@test "Property 3: all idea-validation skills have references/, assets/, examples/" {
  local failed=()
  while IFS= read -r d; do
    { [ -d "$d/references" ] && [ -d "$d/assets" ] && [ -d "$d/examples" ]; } \
      || failed+=("$(basename "$d")")
  done < <(skill_dirs idea-validation)
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing subdirs: ${failed[*]}"; return 1; }
}

# --- Property 4: Required Files in Subdirectories ---

@test "Property 4: all examples/ have input.md" {
  local failed=()
  for cat in coding debugging testing planning documentation design idea-validation; do
    while IFS= read -r d; do
      [ -f "$d/examples/input.md" ] || failed+=("$cat/$(basename "$d")")
    done < <(skill_dirs "$cat")
  done
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing examples/input.md: ${failed[*]}"; return 1; }
}

@test "Property 4: all examples/ have output.md" {
  local failed=()
  for cat in coding debugging testing planning documentation design idea-validation; do
    while IFS= read -r d; do
      [ -f "$d/examples/output.md" ] || failed+=("$cat/$(basename "$d")")
    done < <(skill_dirs "$cat")
  done
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing examples/output.md: ${failed[*]}"; return 1; }
}

@test "Property 4: all references/ have README.md" {
  local failed=()
  for cat in coding debugging testing planning documentation design idea-validation; do
    while IFS= read -r d; do
      [ -f "$d/references/README.md" ] || failed+=("$cat/$(basename "$d")")
    done < <(skill_dirs "$cat")
  done
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing references/README.md: ${failed[*]}"; return 1; }
}

@test "Property 4: all references/ have compatibility-matrix.md" {
  local failed=()
  for cat in coding debugging testing planning documentation design idea-validation; do
    while IFS= read -r d; do
      [ -f "$d/references/compatibility-matrix.md" ] || failed+=("$cat/$(basename "$d")")
    done < <(skill_dirs "$cat")
  done
  [ "${#failed[@]}" -eq 0 ] || { echo "Missing compatibility-matrix.md: ${failed[*]}"; return 1; }
}

# --- Property 7: Script Headers ---

@test "Property 7: all .sh files in scripts/ start with #!/usr/bin/env bash" {
  local bad_scripts
  bad_scripts=$(find "$SKILLS_ROOT" -path "*/scripts/*.sh" -exec bash -c '
    first=$(head -1 "$1")
    [[ "$first" != "#!/usr/bin/env bash" ]] && echo "$1"
  ' _ {} \;)
  [ -z "$bad_scripts" ] || { echo "Bad shebang in: $bad_scripts"; return 1; }
}
