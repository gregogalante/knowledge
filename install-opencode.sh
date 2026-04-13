#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.config/opencode"
TARGET2_DIR="$HOME/.opencode"

mkdir -p "$TARGET_DIR"
mkdir -p "$TARGET2_DIR"

# Symlink skills directory
ln -sfn "$SCRIPT_DIR/skills" "$TARGET_DIR/skills"
ln -sfn "$SCRIPT_DIR/skills" "$TARGET2_DIR/skills"
ln -sfn "$SCRIPT_DIR/agents" "$TARGET_DIR/agents"
ln -sfn "$SCRIPT_DIR/agents" "$TARGET2_DIR/agents"
ln -sfn "$SCRIPT_DIR/opencode.json" "$TARGET_DIR/opencode.json"
ln -sfn "$SCRIPT_DIR/opencode.json" "$TARGET2_DIR/opencode.json"

echo "Symlinks created in $TARGET_DIR"
