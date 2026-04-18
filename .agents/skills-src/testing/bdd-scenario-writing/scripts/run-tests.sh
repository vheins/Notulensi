#!/usr/bin/env bash
# run-tests.sh
# Run BDD test suite for the bdd-scenario-writing skill
# Usage: bash scripts/run-tests.sh
# Dependencies: {{test_framework}}, bash 4+

set -euo pipefail

PROJECT_DIR="{{project_directory}}"
TEST_COMMAND="{{test_command}}"
TEST_PATTERN="{{test_pattern}}"

echo "Running tests for {{project_name}}..."
cd "$PROJECT_DIR"
$TEST_COMMAND $TEST_PATTERN
