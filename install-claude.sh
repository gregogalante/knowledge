#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$REPO_ROOT/claude/CLAUDE.md"
DEST="$HOME/.claude/CLAUDE.md"

if [[ ! -f "$SRC" ]]; then
  echo "ERROR: $SRC not found. Run ./build.sh first." >&2
  exit 1
fi

mkdir -p "$HOME/.claude"

if [[ -L "$DEST" ]]; then
  echo "Symlink already exists: $DEST → $(readlink "$DEST")"
  ln -sf "$SRC" "$DEST"
  echo "Updated: $DEST → $SRC"
elif [[ -f "$DEST" ]]; then
  echo "ERROR: $DEST exists and is not a symlink. Remove it manually first." >&2
  exit 1
else
  ln -s "$SRC" "$DEST"
  echo "Created: $DEST → $SRC"
fi
