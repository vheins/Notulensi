#!/usr/bin/env bash
# validate-skill-structure.sh
# Validates all skills in .agents/skills-src/ against the required subdirectory structure,
# frontmatter completeness, and SKILL.md line count limits.
#
# Usage:
#   bash scripts/validate-skill-structure.sh [--category <name>]
#
# Options:
#   --category <name>   Filter validation to a specific category only
#                       Valid: coding, testing, planning, documentation, design,
#                              idea-validation, debugging
#
# Exit codes:
#   0 = all skills compliant
#   1 = one or more skills non-compliant
#
# Dependencies: bash 4+, find, awk, grep

SKILLS_ROOT=".agents/skills"
MAX_SKILL_LINES=500
REQUIRED_FRONTMATTER_FIELDS=("name" "description" "version" "license" "compatibility" "category")

# Associative array: category → required subdirectories (space-separated)
declare -A CATEGORY_SUBDIRS
CATEGORY_SUBDIRS["coding"]="scripts references assets examples"
CATEGORY_SUBDIRS["testing"]="scripts references assets examples"
CATEGORY_SUBDIRS["planning"]="references assets examples"
CATEGORY_SUBDIRS["documentation"]="references assets examples"
CATEGORY_SUBDIRS["design"]="references assets examples"
CATEGORY_SUBDIRS["idea-validation"]="references assets examples"
CATEGORY_SUBDIRS["debugging"]="references examples"

# Counters and storage
TOTAL_SKILLS=0
COMPLIANT_COUNT=0
NON_COMPLIANT_COUNT=0
TOTAL_ERRORS=0
TOTAL_WARNINGS=0

# Arrays to store non-compliant skill info
declare -a NON_COMPLIANT_SKILLS=()
declare -A SKILL_ISSUES=()

# ---------------------------------------------------------------------------
# check_frontmatter_fields <skill_md_path> <skill_key>
#   Checks that all required frontmatter fields are present in SKILL.md.
#   Appends ⚠️  warnings to SKILL_ISSUES[skill_key] for each missing field.
# ---------------------------------------------------------------------------
check_frontmatter_fields() {
  local skill_md="$1"
  local skill_key="$2"

  # Extract frontmatter block (between first pair of ---)
  local in_frontmatter=0
  local frontmatter=""
  while IFS= read -r line; do
    if [[ "$line" == "---" ]]; then
      if [[ $in_frontmatter -eq 0 ]]; then
        in_frontmatter=1
        continue
      else
        break
      fi
    fi
    if [[ $in_frontmatter -eq 1 ]]; then
      frontmatter+="$line"$'\n'
    fi
  done < "$skill_md"

  for field in "${REQUIRED_FRONTMATTER_FIELDS[@]}"; do
    # Match field at start of line (handles multi-line values too)
    if ! echo "$frontmatter" | grep -qE "^${field}[[:space:]]*:"; then
      SKILL_ISSUES["$skill_key"]+="  ⚠️  Missing frontmatter field: ${field}"$'\n'
      (( TOTAL_WARNINGS++ ))
    fi
  done
}

# ---------------------------------------------------------------------------
# check_subdirectories <skill_dir> <category> <skill_key>
#   Checks that all required subdirectories for the category exist.
#   Appends ❌ errors to SKILL_ISSUES[skill_key] for each missing directory.
# ---------------------------------------------------------------------------
check_subdirectories() {
  local skill_dir="$1"
  local category="$2"
  local skill_key="$3"

  local required_dirs="${CATEGORY_SUBDIRS[$category]}"
  if [[ -z "$required_dirs" ]]; then
    # Unknown category — skip subdirectory check
    return
  fi

  for subdir in $required_dirs; do
    if [[ ! -d "${skill_dir}/${subdir}" ]]; then
      SKILL_ISSUES["$skill_key"]+="  ❌ Missing subdirectory: ${subdir}/"$'\n'
      (( TOTAL_ERRORS++ ))
    fi
  done
}

# ---------------------------------------------------------------------------
# check_file_count <skill_md_path> <skill_key>
#   Reports a warning if SKILL.md exceeds MAX_SKILL_LINES lines.
# ---------------------------------------------------------------------------
check_file_count() {
  local skill_md="$1"
  local skill_key="$2"

  local line_count
  line_count=$(wc -l < "$skill_md")

  if [[ $line_count -gt $MAX_SKILL_LINES ]]; then
    SKILL_ISSUES["$skill_key"]+="  ⚠️  SKILL.md exceeds ${MAX_SKILL_LINES} lines (current: ${line_count})"$'\n'
    (( TOTAL_WARNINGS++ ))
  fi
}

# ---------------------------------------------------------------------------
# generate_report
#   Prints the full validation report to stdout.
# ---------------------------------------------------------------------------
generate_report() {
  local timestamp
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  echo "=== Skill Structure Validation Report ==="
  echo "Generated: ${timestamp}"
  echo ""
  printf "COMPLIANT:     %d/%d\n" "$COMPLIANT_COUNT" "$TOTAL_SKILLS"
  printf "NON-COMPLIANT: %d/%d\n" "$NON_COMPLIANT_COUNT" "$TOTAL_SKILLS"

  if [[ ${#NON_COMPLIANT_SKILLS[@]} -gt 0 ]]; then
    echo ""
    echo "--- Non-Compliant Skills ---"
    for skill_key in "${NON_COMPLIANT_SKILLS[@]}"; do
      echo "${skill_key}"
      echo -n "${SKILL_ISSUES[$skill_key]}"
    done
  fi

  echo ""
  echo "=== Summary ==="
  local total_issues=$(( TOTAL_ERRORS + TOTAL_WARNINGS ))
  printf "Total issues: %d (%d errors, %d warnings)\n" \
    "$total_issues" "$TOTAL_ERRORS" "$TOTAL_WARNINGS"

  if [[ $NON_COMPLIANT_COUNT -gt 0 ]]; then
    echo "Exit code: 1"
  else
    echo "Exit code: 0"
  fi
}

# ---------------------------------------------------------------------------
# validate_skill <skill_dir> <category>
#   Runs all checks for a single skill directory.
# ---------------------------------------------------------------------------
validate_skill() {
  local skill_dir="$1"
  local category="$2"

  local skill_name
  skill_name=$(basename "$skill_dir")
  local skill_key="${category}/${skill_name}"
  local skill_md="${skill_dir}/SKILL.md"

  (( TOTAL_SKILLS++ ))

  # Missing SKILL.md is an error
  if [[ ! -f "$skill_md" ]]; then
    SKILL_ISSUES["$skill_key"]="  ❌ Missing SKILL.md"$'\n'
    (( TOTAL_ERRORS++ ))
    NON_COMPLIANT_SKILLS+=("$skill_key")
    (( NON_COMPLIANT_COUNT++ ))
    return
  fi

  # Run all checks
  check_subdirectories "$skill_dir" "$category" "$skill_key"
  check_frontmatter_fields "$skill_md" "$skill_key"
  check_file_count "$skill_md" "$skill_key"

  # Determine compliance
  if [[ -n "${SKILL_ISSUES[$skill_key]}" ]]; then
    NON_COMPLIANT_SKILLS+=("$skill_key")
    (( NON_COMPLIANT_COUNT++ ))
  else
    (( COMPLIANT_COUNT++ ))
  fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
FILTER_CATEGORY=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --category)
      if [[ -z "$2" ]]; then
        echo "Error: --category requires a value." >&2
        echo "Valid categories: ${!CATEGORY_SUBDIRS[*]}" >&2
        exit 1
      fi
      FILTER_CATEGORY="$2"
      shift 2
      ;;
    --help|-h)
      sed -n '2,15p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: bash scripts/validate-skill-structure.sh [--category <name>]" >&2
      exit 1
      ;;
  esac
done

# Validate filter category if provided
if [[ -n "$FILTER_CATEGORY" && -z "${CATEGORY_SUBDIRS[$FILTER_CATEGORY]+x}" ]]; then
  echo "Error: Unknown category '${FILTER_CATEGORY}'." >&2
  echo "Valid categories: ${!CATEGORY_SUBDIRS[*]}" >&2
  exit 1
fi

# Iterate over categories
for category_dir in "${SKILLS_ROOT}"/*/; do
  [[ -d "$category_dir" ]] || continue

  category=$(basename "$category_dir")

  # Skip if not a known category (e.g. README.md at root level)
  [[ -z "${CATEGORY_SUBDIRS[$category]+x}" ]] && continue

  # Apply category filter
  if [[ -n "$FILTER_CATEGORY" && "$category" != "$FILTER_CATEGORY" ]]; then
    continue
  fi

  # Iterate over skill directories within the category
  for skill_dir in "${category_dir}"*/; do
    [[ -d "$skill_dir" ]] || continue
    validate_skill "$skill_dir" "$category"
  done
done

generate_report

# Exit with appropriate code
if [[ $NON_COMPLIANT_COUNT -gt 0 ]]; then
  exit 1
else
  exit 0
fi
