#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude"

mkdir -p "$TARGET_DIR"

# Symlink skills directory
ln -sfn "$SCRIPT_DIR/skills" "$TARGET_DIR/skills"

echo "Symlinks created in $TARGET_DIR"
