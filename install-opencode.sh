#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.config/opencode"

mkdir -p "$TARGET_DIR"

# Symlink skills directory
ln -sfn "$SCRIPT_DIR/skills" "$TARGET_DIR/skills"
ln -sfn "$SCRIPT_DIR/agents" "$TARGET_DIR/agents"
ln -sfn "$SCRIPT_DIR/opencode.json" "$TARGET_DIR/opencode.json"

echo "Symlinks created in $TARGET_DIR"
