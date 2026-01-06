#!/bin/bash
set -e

echo "=== Running Mistral Codestral Test Suite ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

export MISTRAL_API_KEY="test_key_for_ci"

# Track overall test status
TESTS_FAILED=0

# Run integration tests
echo -e "\n--- Integration Tests ---"
if ! nvim --headless --noplugin -u NONE \
  -c "set runtimepath+=$PROJECT_ROOT" \
  -c "luafile $PROJECT_ROOT/tests/integration_test.lua" 2>&1 | tee /tmp/integration.log; then
  TESTS_FAILED=1
fi

# Check for success indicator
if ! grep -q "All integration tests passed" /tmp/integration.log; then
  echo "Integration tests failed"
  TESTS_FAILED=1
fi

# Run plugin tests
echo -e "\n--- Plugin Tests ---"
if ! nvim --headless --noplugin -u NONE \
  -c "set runtimepath+=$PROJECT_ROOT" \
  -c "luafile $PROJECT_ROOT/tests/plugin_test.lua" 2>&1 | tee /tmp/plugin.log; then
  TESTS_FAILED=1
fi

# Check for success indicator
if ! grep -q "All tests passed" /tmp/plugin.log; then
  echo "Plugin tests failed"
  TESTS_FAILED=1
fi

# Skip API tests in CI (require real API key)
echo -e "\n--- Skipping API Tests (require valid API key) ---"

# Summary
echo -e "\n=== Test Summary ==="
if [ $TESTS_FAILED -eq 0 ]; then
  echo "✓ All CI tests passed"
  exit 0
else
  echo "✗ Some tests failed"
  exit 1
fi
