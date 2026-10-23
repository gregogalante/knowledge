#!/usr/bin/env bash
# Checks that latest repo version is installed for Claude Code, Codex and OpenCode.
# Installs are symlinks into this repo, so "up to date" = build output matches
# src/ and every symlink points at the expected built file.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILT_PATHS=(
  claude/CLAUDE.md
  codex/AGENTS.md
  codex/agents
  opencode/AGENTS.md
  opencode/agents
  opencode/opencode.json
)
failures=0

ok () { echo "  OK    $1"; }
fail () { echo "  FAIL  $1"; failures=$((failures + 1)); }

# Rebuild in a scratch copy and diff, so the check never touches repo outputs.
check_build () {
  echo "Build"
  local tmp_dir
  tmp_dir=$(mktemp -d)
  cp -R "$REPO_ROOT/src" "$REPO_ROOT/build.sh" "$tmp_dir/"

  if ! "$tmp_dir/build.sh" > /dev/null; then
    fail "build.sh failed"
    rm -rf "$tmp_dir"
    return
  fi

  local path
  for path in "${BUILT_PATHS[@]}"; do
    if [[ ! -e "$REPO_ROOT/$path" ]]; then
      fail "$path missing (run ./build.sh)"
    elif diff -r "$tmp_dir/$path" "$REPO_ROOT/$path" > /dev/null; then
      ok "$path"
    else
      fail "$path outdated (run ./build.sh)"
    fi
  done
  rm -rf "$tmp_dir"
}

# Installed path must be a symlink to the expected repo file.
check_link () {
  local link="$1"
  local expected="$REPO_ROOT/$2"
  local label="${link/#$HOME/~}"

  if [[ ! -L "$link" ]]; then
    if [[ -e "$link" ]]; then
      fail "$label is not a symlink (run install script)"
    else
      fail "$label missing (run install script)"
    fi
  elif [[ "$(readlink "$link")" != "$expected" ]]; then
    fail "$label → $(readlink "$link"), expected → $expected"
  elif [[ ! -e "$link" ]]; then
    fail "$label is dangling"
  else
    ok "$label"
  fi
}

# Leftovers that silently change behavior: dangling links, legacy ~/.opencode links.
check_stale () {
  local dir="$1"
  local link
  [[ -d "$dir" ]] || return 0
  for link in "$dir"/*; do
    [[ -L "$link" ]] || continue
    if [[ ! -e "$link" ]]; then
      fail "${link/#$HOME/~} is dangling → $(readlink "$link")"
    elif [[ "$dir" == "$HOME/.opencode" && "$(readlink "$link")" == "$REPO_ROOT/"* ]]; then
      fail "${link/#$HOME/~} is legacy, loads config twice (run ./install-opencode.sh)"
    fi
  done
}

check_build

echo "Claude Code"
check_link "$HOME/.claude/CLAUDE.md" claude/CLAUDE.md

echo "Codex"
check_link "$HOME/.codex/AGENTS.md" codex/AGENTS.md
check_link "$HOME/.codex/agents" codex/agents

echo "OpenCode"
check_link "$HOME/.config/opencode/AGENTS.md" opencode/AGENTS.md
check_link "$HOME/.config/opencode/agents" opencode/agents
check_link "$HOME/.config/opencode/opencode.json" opencode/opencode.json
check_stale "$HOME/.config/opencode"
check_stale "$HOME/.opencode"

echo ""
if [[ $failures -gt 0 ]]; then
  echo "$failures problem(s) found."
  exit 1
fi
echo "All installations up to date."
