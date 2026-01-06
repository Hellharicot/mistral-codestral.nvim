#!/bin/bash
# Check if version is consistent across files

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Extract version from init.lua
INIT_VERSION=$(grep -oP 'M\.VERSION = "\K[^"]+' "$PROJECT_ROOT/lua/mistral-codestral/init.lua")

# Extract version from manifest
MANIFEST_VERSION=$(grep -oP '"\.":\s*"\K[^"]+' "$PROJECT_ROOT/.github/.release-please-manifest.json")

# Get latest git tag
GIT_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
GIT_VERSION=${GIT_TAG#v}

echo "Version Check:"
echo "  init.lua:        $INIT_VERSION"
echo "  manifest:        $MANIFEST_VERSION"
echo "  latest git tag:  $GIT_VERSION"

if [ "$INIT_VERSION" = "$MANIFEST_VERSION" ] && [ "$MANIFEST_VERSION" = "$GIT_VERSION" ]; then
  echo "✓ All versions match"
  exit 0
else
  echo "✗ Version mismatch detected"
  exit 1
fi
