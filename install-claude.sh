#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$REPO_ROOT/lib.sh"

link_rules "$REPO_ROOT/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
