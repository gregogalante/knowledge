#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$REPO_ROOT/lib.sh"
TARGET_DIR="$HOME/.config/opencode"
# Legacy target: ~/.opencode is OpenCode's install dir, not a documented config
# dir. Links there made config and agents load twice.
LEGACY_DIR="$HOME/.opencode"

# Global AGENTS.md also stops OpenCode falling back to ~/.claude/CLAUDE.md.
link_rules "$REPO_ROOT/opencode/AGENTS.md" "$TARGET_DIR/AGENTS.md"
link_rules "$REPO_ROOT/opencode/agents" "$TARGET_DIR/agents"
link_rules "$REPO_ROOT/opencode/opencode.json" "$TARGET_DIR/opencode.json"

# Drop legacy links only if they point into this repo.
for name in agents opencode.json; do
  link="$LEGACY_DIR/$name"
  if [[ -L "$link" && "$(readlink "$link")" == "$REPO_ROOT/"* ]]; then
    rm "$link"
    echo "Removed legacy link: $link"
  fi
done
