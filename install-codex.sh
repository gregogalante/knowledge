#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.codex"

if [[ ! -f "$SCRIPT_DIR/codex/AGENTS.md" ]]; then
  echo "ERROR: codex/AGENTS.md not found. Run ./build.sh first." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

# Refuse to replace a real file: AGENTS.md may hold hand-written rules.
if [[ -e "$TARGET_DIR/AGENTS.md" && ! -L "$TARGET_DIR/AGENTS.md" ]]; then
  echo "ERROR: $TARGET_DIR/AGENTS.md exists and is not a symlink. Remove it manually first." >&2
  exit 1
fi

# AGENTS.md = main-session rules; agents/ = subagents spawned on demand.
ln -sfn "$SCRIPT_DIR/codex/AGENTS.md" "$TARGET_DIR/AGENTS.md"
ln -sfn "$SCRIPT_DIR/codex/agents" "$TARGET_DIR/agents"
# config.toml stays a real file owned by the Codex app, which rewrites it.

echo "Symlinks created in $TARGET_DIR"
