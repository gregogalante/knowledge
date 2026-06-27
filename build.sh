#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$REPO_ROOT/src"
SRC_AGENTS_DIR="$SRC_DIR/agents"
SRC_OPENCODE_CONFIG_SRC="$SRC_DIR/opencode/opencode.json"
OPENCODE_OUT_DIR="$REPO_ROOT/opencode/agents"
OPENCODE_CONFIG_OUT="$REPO_ROOT/opencode/opencode.json"
CODEX_OUT_DIR="$REPO_ROOT/codex/agents"
CODEX_CONFIG_SRC="$SRC_DIR/codex/config.toml"
CODEX_CONFIG_OUT="$REPO_ROOT/codex/config.toml"
CLAUDE_OUT_DIR="$REPO_ROOT/claude"
CLAUDE_OUT_FILE="$CLAUDE_OUT_DIR/CLAUDE.md"
CLAUDE_SRC_FILE="$SRC_AGENTS_DIR/_developer.toml"

if [[ ! -d "$SRC_AGENTS_DIR" ]]; then
  echo "ERROR: Source directory not found: $SRC_AGENTS_DIR" >&2
  exit 1
fi

mkdir -p "$OPENCODE_OUT_DIR" "$CODEX_OUT_DIR" "$CLAUDE_OUT_DIR"

src_files=()
while IFS= read -r src_file; do
  src_files+=("$src_file")
done < <(find "$SRC_AGENTS_DIR" -type f -name '*.toml' | sort)

if [[ ${#src_files[@]} -eq 0 ]]; then
  echo "No source files found in $SRC_AGENTS_DIR" >&2
  exit 1
fi

expand_includes () {
  local input_file="$1"
  local output_file="$2"
  local tmp_file

  tmp_file=$(mktemp)

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*\<\!--[[:space:]]*@include[[:space:]]+(.+)[[:space:]]*--\>[[:space:]]*$ ]]; then
      local include_path="${BASH_REMATCH[1]}"
      include_path="${include_path#"${include_path%%[![:space:]]*}"}"
      include_path="${include_path%"${include_path##*[![:space:]]}"}"
      local include_full="$SRC_DIR/$include_path"

      if [[ -f "$include_full" ]]; then
        cat "$include_full" >> "$tmp_file"
        printf '\n' >> "$tmp_file"
      else
        echo "ERROR: Include not found: $include_path (referenced in $input_file)" >&2
        rm -f "$tmp_file"
        exit 1
      fi
    else
      printf '%s\n' "$line" >> "$tmp_file"
    fi
  done < "$input_file"

  mkdir -p "$(dirname "$output_file")"
  mv "$tmp_file" "$output_file"
}

extract_developer_instructions () {
  local src_file="$1"
  local output_file="$2"
  local tmp_file

  tmp_file=$(mktemp)

  if ! awk '
    BEGIN { in_body = 0; found = 0 }
    /^[[:space:]]*developer_instructions[[:space:]]*=[[:space:]]*"""[[:space:]]*$/ { in_body = 1; found = 1; next }
    in_body && /^[[:space:]]*"""[[:space:]]*$/ { exit }
    in_body { print }
    END { if (!found) exit 2 }
  ' "$src_file" > "$tmp_file"; then
    echo "ERROR: developer_instructions not found in $src_file" >&2
    rm -f "$tmp_file"
    exit 1
  fi

  expand_includes "$tmp_file" "$output_file"
  rm -f "$tmp_file"
}

for src_file in "${src_files[@]}"; do
  rel_path="${src_file#"$SRC_AGENTS_DIR/"}"
  base_name="${rel_path%.toml}"
  open_out_file="$OPENCODE_OUT_DIR/$base_name.md"
  codex_out_file="$CODEX_OUT_DIR/$base_name.toml"

  echo "Building $base_name..."

  rm -f "$OPENCODE_OUT_DIR/$base_name.toml" "$CODEX_OUT_DIR/$base_name.md"

  extract_developer_instructions "$src_file" "$open_out_file"
  expand_includes "$src_file" "$codex_out_file"
  echo "  → opencode/agents/$base_name.md"
  echo "  → codex/agents/$base_name.toml"
done

if [[ -f "$CODEX_CONFIG_SRC" ]]; then
  cp "$CODEX_CONFIG_SRC" "$CODEX_CONFIG_OUT"
  echo "  → codex/config.toml"
else
  echo "ERROR: Source config not found: $CODEX_CONFIG_SRC" >&2
  exit 1
fi

if [[ -f "$SRC_OPENCODE_CONFIG_SRC" ]]; then
  cp "$SRC_OPENCODE_CONFIG_SRC" "$OPENCODE_CONFIG_OUT"
  echo "  → opencode/opencode.json"
else
  echo "ERROR: Source config not found: $SRC_OPENCODE_CONFIG_SRC" >&2
  exit 1
fi

if [[ -f "$CLAUDE_SRC_FILE" ]]; then
  extract_developer_instructions "$CLAUDE_SRC_FILE" "$CLAUDE_OUT_FILE"
  echo "  → claude/CLAUDE.md"
else
  echo "ERROR: Source file not found: $CLAUDE_SRC_FILE" >&2
  exit 1
fi

echo ""
echo "Build complete. $(date '+%Y-%m-%d %H:%M:%S')"
