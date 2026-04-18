#!/usr/bin/env bash
# run-mutation.sh
# Run mutation testing for the target project
# Usage: bash scripts/run-mutation.sh
# Dependencies: {{test_framework}}, {{runtime}}

set -euo pipefail

PROJECT="{{project_name}}"
TEST_DIR="{{test_directory}}"
FRAMEWORK="{{test_framework}}"

echo "Running tests for $PROJECT..."

# Run tests
{{test_command}}

echo "Done."
