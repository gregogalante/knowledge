#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.codex"

mkdir -p "$TARGET_DIR"

ln -sfn "$SCRIPT_DIR/codex/agents" "$TARGET_DIR/agents"
ln -sfn "$SCRIPT_DIR/codex/config.toml" "$TARGET_DIR/config.toml"

echo "Symlink created in $TARGET_DIR"
