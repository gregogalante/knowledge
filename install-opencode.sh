#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.config/opencode"
# Legacy target: ~/.opencode is OpenCode's install dir, not a documented config
# dir. Links there made config and agents load twice.
LEGACY_DIR="$HOME/.opencode"

if [[ ! -f "$SCRIPT_DIR/opencode/AGENTS.md" ]]; then
  echo "ERROR: opencode/AGENTS.md not found. Run ./build.sh first." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

# Refuse to replace a real file: AGENTS.md may hold hand-written rules.
if [[ -e "$TARGET_DIR/AGENTS.md" && ! -L "$TARGET_DIR/AGENTS.md" ]]; then
  echo "ERROR: $TARGET_DIR/AGENTS.md exists and is not a symlink. Remove it manually first." >&2
  exit 1
fi

# Global AGENTS.md also stops OpenCode falling back to ~/.claude/CLAUDE.md.
ln -sfn "$SCRIPT_DIR/opencode/AGENTS.md" "$TARGET_DIR/AGENTS.md"
ln -sfn "$SCRIPT_DIR/opencode/agents" "$TARGET_DIR/agents"
ln -sfn "$SCRIPT_DIR/opencode/opencode.json" "$TARGET_DIR/opencode.json"

# Drop legacy links only if they point into this repo.
for name in agents opencode.json; do
  link="$LEGACY_DIR/$name"
  if [[ -L "$link" && "$(readlink "$link")" == "$SCRIPT_DIR/"* ]]; then
    rm "$link"
    echo "Removed legacy link: $link"
  fi
done

echo "Symlinks created in $TARGET_DIR"
