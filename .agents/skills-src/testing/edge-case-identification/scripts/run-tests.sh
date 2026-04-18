#!/usr/bin/env bash
# run-tests.sh
# Run edge case test suite for the edge-case-identification skill
# Usage: bash scripts/run-tests.sh
# Dependencies: {{test_framework}}, bash 4+

set -euo pipefail

PROJECT_DIR="{{project_directory}}"
TEST_COMMAND="{{test_command}}"
TEST_PATTERN="{{test_pattern}}"

echo "Running tests for {{project_name}}..."
cd "$PROJECT_DIR"
$TEST_COMMAND $TEST_PATTERN
