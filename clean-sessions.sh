#!/usr/bin/env bash
# Deletes local session history of Claude Code, Codex and OpenCode.
# Dry-run by default; pass --yes to delete. Keeps auth, config and rules.
# Cloud sessions (claude.ai, Codex cloud, OpenCode /share) are not touched.
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
CLAUDE_APP_DIR="$HOME/Library/Application Support/Claude"
CODEX_DIR="$HOME/.codex"
OPENCODE_DIR="$HOME/.local/share/opencode"

CLAUDE_TARGETS=(
  "$CLAUDE_DIR/projects"
  "$CLAUDE_DIR/sessions"
  "$CLAUDE_DIR/session-env"
  "$CLAUDE_DIR/file-history"
  "$CLAUDE_DIR/shell-snapshots"
  "$CLAUDE_DIR/todos"
  "$CLAUDE_DIR/history.jsonl"
  "$CLAUDE_APP_DIR/claude-code-sessions"
)
CODEX_TARGETS=(
  "$CODEX_DIR/sessions"
  "$CODEX_DIR/archived_sessions"
  "$CODEX_DIR/session_index.jsonl"
  "$CODEX_DIR/history.jsonl"
  "$CODEX_DIR/shell_snapshots"
  "$CODEX_DIR"/state_*.sqlite*
  "$CODEX_DIR"/thread_history_*.sqlite*
  "$CODEX_DIR"/logs_*.sqlite*
)
# Whole DB goes, not single rows: OpenCode recreates it on start with current schema.
OPENCODE_TARGETS=(
  "$OPENCODE_DIR"/opencode.db*
  "$OPENCODE_DIR/storage"
  "$OPENCODE_DIR/snapshot"
  "$OPENCODE_DIR/tool-output"
)

confirmed=false
case "${1:-}" in
  --yes) confirmed=true ;;
  "") ;;
  *) echo "Usage: $0 [--yes]" >&2; exit 1 ;;
esac

# Open apps hold SQLite files and rewrite history on exit, undoing the cleanup.
warn_running () {
  local name
  # Prefix match: covers app helpers and CLI variants (e.g. "Claude Helper", "opencode-cli").
  for name in claude codex opencode; do
    if pgrep -i "^$name" > /dev/null; then
      echo "WARN: $name is running. Quit it first, or files may be rewritten/corrupted."
    fi
  done
}

# Unmatched globs stay literal, so existence check also filters those out.
clean () {
  local label="$1"
  shift
  local target
  echo "$label"
  for target in "$@"; do
    [[ -e "$target" ]] || continue
    echo "  $(du -sh "$target" | cut -f1)	${target/#$HOME/~}"
    if $confirmed; then
      rm -rf "$target"
    fi
  done
}

warn_running
clean "Claude Code" "${CLAUDE_TARGETS[@]}"
clean "Codex" "${CODEX_TARGETS[@]}"
clean "OpenCode" "${OPENCODE_TARGETS[@]}"

echo ""
if $confirmed; then
  echo "Deleted."
else
  echo "Dry-run: nothing deleted. Re-run with --yes to delete."
fi
