#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$REPO_ROOT/lib.sh"
TARGET_DIR="$HOME/.codex"

# AGENTS.md = main-session rules; agents/ = subagents spawned on demand.
link_rules "$REPO_ROOT/codex/AGENTS.md" "$TARGET_DIR/AGENTS.md"
link_rules "$REPO_ROOT/codex/agents" "$TARGET_DIR/agents"
# config.toml stays a real file owned by the Codex app, which rewrites it.
