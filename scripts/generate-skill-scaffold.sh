#!/usr/bin/env bash
# generate-skill-scaffold.sh
# Generates a new skill folder with the correct subdirectory structure and template files
# based on the skill's category, compliant with agentskills.io/specification.
#
# Usage:
#   bash scripts/generate-skill-scaffold.sh <category> <skill-name>
#
# Example:
#   bash scripts/generate-skill-scaffold.sh coding my-new-skill
#   bash scripts/generate-skill-scaffold.sh debugging error-tracing
#
# Options:
#   --force    Overwrite existing skill folder (use with caution)
#
# Exit codes:
#   0 = scaffold created successfully
#   1 = invalid arguments, invalid category, or skill already exists
#
# Dependencies: bash 4+, mkdir, cat

SKILLS_ROOT=".agents/skills"

# Valid categories and their required subdirectories (space-separated)
declare -A CATEGORY_SUBDIRS
CATEGORY_SUBDIRS["coding"]="scripts references assets examples"
CATEGORY_SUBDIRS["testing"]="scripts references assets examples"
CATEGORY_SUBDIRS["planning"]="references assets examples"
CATEGORY_SUBDIRS["documentation"]="references assets examples"
CATEGORY_SUBDIRS["design"]="references assets examples"
CATEGORY_SUBDIRS["idea-validation"]="references assets examples"
CATEGORY_SUBDIRS["debugging"]="references examples"

VALID_CATEGORIES="coding, debugging, testing, planning, documentation, design, idea-validation"

# ---------------------------------------------------------------------------
# Parse arguments
# ---------------------------------------------------------------------------
FORCE=0
CATEGORY=""
SKILL_NAME=""

for arg in "$@"; do
  case "$arg" in
    --force)
      FORCE=1
      ;;
    *)
      if [[ -z "$CATEGORY" ]]; then
        CATEGORY="$arg"
      elif [[ -z "$SKILL_NAME" ]]; then
        SKILL_NAME="$arg"
      fi
      ;;
  esac
done

# ---------------------------------------------------------------------------
# Validate parameters
# ---------------------------------------------------------------------------
if [[ -z "$CATEGORY" || -z "$SKILL_NAME" ]]; then
  echo "Error: Missing required parameters." >&2
  echo "Usage: bash scripts/generate-skill-scaffold.sh <category> <skill-name>" >&2
  echo "Example: bash scripts/generate-skill-scaffold.sh coding my-new-skill" >&2
  exit 1
fi

# Validate category
if [[ -z "${CATEGORY_SUBDIRS[$CATEGORY]+x}" ]]; then
  echo "Error: Invalid category '${CATEGORY}'." >&2
  echo "Valid categories: ${VALID_CATEGORIES}" >&2
  exit 1
fi

SKILL_DIR="${SKILLS_ROOT}/${CATEGORY}/${SKILL_NAME}"

# Validate skill does not already exist
if [[ -d "$SKILL_DIR" && $FORCE -eq 0 ]]; then
  echo "Error: Skill '${CATEGORY}/${SKILL_NAME}' already exists." >&2
  echo "Use --force to overwrite: bash scripts/generate-skill-scaffold.sh ${CATEGORY} ${SKILL_NAME} --force" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Helper: write_file <path> <content>
#   Creates parent directories as needed and writes content to file.
#   Skips if file already exists and --force is not set.
# ---------------------------------------------------------------------------
write_file() {
  local filepath="$1"
  local content="$2"

  if [[ -f "$filepath" && $FORCE -eq 0 ]]; then
    echo "  [skip] ${filepath} (already exists)"
    return
  fi

  mkdir -p "$(dirname "$filepath")"
  printf '%s\n' "$content" > "$filepath"
  echo "  [create] ${filepath}"
}

# ---------------------------------------------------------------------------
# Create skill directory
# ---------------------------------------------------------------------------
echo "Generating scaffold for: ${CATEGORY}/${SKILL_NAME}"
echo "Destination: ${SKILL_DIR}"
echo ""

mkdir -p "$SKILL_DIR"

# ---------------------------------------------------------------------------
# Create SKILL.md with full frontmatter template
# ---------------------------------------------------------------------------
SKILL_MD_CONTENT="---
name: {{skill_name}}
description: >
  Use when {{use_case_description}}.
  Do NOT use for {{exclusion_description}}.
version: \"1.0.0\"
license: MIT
compatibility: >
  Compatible with Kiro (.kiro/skills/), Cursor (.cursor/skills/),
  Windsurf (.windsurf/skills/), GitHub Copilot (.github/skills/),
  OpenCode (.agents/skills-src/), TRAE (.trae/skills/),
  Claude Code (.claude/skills/). No special tools required.
category: ${CATEGORY}
complexity: {{Beginner|Intermediate|Advanced}}
tags: [{{tag_1}}, {{tag_2}}, {{tag_3}}]
author: {{author_name}}
---

# Skill: {{skill_title}}

## Purpose

{{skill_purpose_description}}

## Input

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| \`{{variable_1}}\` | string | {{variable_1_description}} | \"{{variable_1_example}}\" |
| \`{{variable_2}}\` | string | {{variable_2_description}} | \"{{variable_2_example}}\" |

## Prompt

\`\`\`
{{prompt_template}}

Input:
- {{variable_1}}: {{variable_1}}
- {{variable_2}}: {{variable_2}}
\`\`\`

## Output Format

{{output_format_description}}

## Examples

See [examples/](examples/) for concrete input/output examples.

## Agent Compatibility

See [references/compatibility-matrix.md](references/compatibility-matrix.md) for full compatibility details.

## Changelog

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | {{date}} | Initial release |"

write_file "${SKILL_DIR}/SKILL.md" "$SKILL_MD_CONTENT"

# ---------------------------------------------------------------------------
# Create subdirectories and template files based on category
# ---------------------------------------------------------------------------
SUBDIRS="${CATEGORY_SUBDIRS[$CATEGORY]}"

for subdir in $SUBDIRS; do
  mkdir -p "${SKILL_DIR}/${subdir}"

  case "$subdir" in

    examples)
      # examples/input.md
      INPUT_MD="# Example Input: {{skill_name}}

## Scenario: {{scenario_name}}

| Variable | Value |
|----------|-------|
| \`{{variable_1}}\` | \"{{variable_1_example_value}}\" |
| \`{{variable_2}}\` | \"{{variable_2_example_value}}\" |"
      write_file "${SKILL_DIR}/examples/input.md" "$INPUT_MD"

      # examples/output.md
      OUTPUT_MD="# Example Output: {{skill_name}}

## Scenario: {{scenario_name}}

> Output yang dihasilkan ketika diberikan input dari \`input.md\`

{{expected_output_content}}"
      write_file "${SKILL_DIR}/examples/output.md" "$OUTPUT_MD"
      ;;

    references)
      # references/README.md
      REFS_README="# References: {{skill_name}}

Folder ini berisi dokumentasi pendukung untuk skill \`{{skill_name}}\`.

## Files

| File | Description |
|------|-------------|
| \`compatibility-matrix.md\` | Status kompatibilitas skill ini di setiap IDE/agent target |"
      write_file "${SKILL_DIR}/references/README.md" "$REFS_README"

      # references/compatibility-matrix.md
      COMPAT_MATRIX="# Compatibility Matrix: {{skill_name}}

| Agent | Status | Notes |
|-------|--------|-------|
| Kiro | ✅ Tested | Full compatibility |
| Cursor | ✅ Tested | Full compatibility |
| Windsurf | ✅ Tested | Full compatibility |
| GitHub Copilot | ✅ Tested | Full compatibility |
| OpenCode | ✅ Tested | Full compatibility |
| TRAE | ✅ Tested | Full compatibility |
| Claude Code | ✅ Tested | Full compatibility |"
      write_file "${SKILL_DIR}/references/compatibility-matrix.md" "$COMPAT_MATRIX"
      ;;

    assets)
      # assets/template.md
      ASSETS_TEMPLATE="# Template: {{skill_name}}

> Salin template ini dan ganti semua \`{{placeholder}}\` dengan nilai aktual.

---

## {{section_title}}

{{template_content}}

### {{subsection_title}}

- {{item_1}}: {{item_1_value}}
- {{item_2}}: {{item_2_value}}

### Notes

{{additional_notes}}"
      write_file "${SKILL_DIR}/assets/template.md" "$ASSETS_TEMPLATE"
      ;;

    scripts)
      # scripts/README.md
      SCRIPTS_README="# Scripts: {{skill_name}}

Folder ini berisi skrip executable yang dihasilkan atau digunakan oleh skill \`{{skill_name}}\`.

## Scripts

| Script | Language | Description | Usage |
|--------|----------|-------------|-------|
| \`{{script_name}}.sh\` | Bash | {{script_description}} | \`bash scripts/{{script_name}}.sh\` |

## Prerequisites

- {{dependency_1}}
- {{dependency_2}}

## Customization

Ganti semua \`{{variable_name}}\` dengan nilai aktual sebelum menjalankan skrip."
      write_file "${SKILL_DIR}/scripts/README.md" "$SCRIPTS_README"
      ;;

  esac
done

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "✅ Scaffold created: ${SKILL_DIR}"
echo ""
echo "Next steps:"
echo "  1. Edit ${SKILL_DIR}/SKILL.md — replace all {{placeholder}} values"
echo "  2. Fill in ${SKILL_DIR}/examples/input.md and examples/output.md"
echo "  3. Run: bash scripts/validate-skill-structure.sh --category ${CATEGORY}"
