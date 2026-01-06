#!/bin/bash
# Test release preparation locally

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Local Release Preparation Test ==="

# Check for conventional commits
echo -e "\n1. Checking recent commits..."
git log --oneline -5 --pretty=format:"%s"

# Validate commit messages
echo -e "\n\n2. Validating commit message format..."
LAST_COMMIT=$(git log -1 --pretty=format:"%s")
if echo "$LAST_COMMIT" | grep -qE "^(feat|fix|docs|refactor|test|chore|perf)(\(.+\))?: .+"; then
  echo "✓ Last commit follows conventional format"
else
  echo "✗ Last commit does NOT follow conventional format"
  echo "  Format: type(scope): description"
  echo "  Example: feat: add new feature"
fi

# Check version consistency
echo -e "\n3. Checking version consistency..."
bash "$SCRIPT_DIR/check_version.sh"

# Run tests
echo -e "\n4. Running test suite..."
bash "$SCRIPT_DIR/ci_test.sh"

echo -e "\n✓ Release preparation test complete"
echo "Ready to push to trigger release workflow"
