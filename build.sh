#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$REPO_ROOT/src"
OUT_DIR="$REPO_ROOT/agents"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "ERROR: Source directory not found: $SRC_DIR" >&2
  exit 1
fi

shopt -s nullglob
src_files=("$SRC_DIR"/*.md)

if [[ ${#src_files[@]} -eq 0 ]]; then
  echo "No source files found in $SRC_DIR" >&2
  exit 1
fi

for src_file in "${src_files[@]}"; do
  filename=$(basename "$src_file")
  out_file="$OUT_DIR/$filename"

  echo "Building $filename..."

  tmp_file=$(mktemp)

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*\<\!--[[:space:]]*@include[[:space:]]+(.+)[[:space:]]*--\>[[:space:]]*$ ]]; then
      include_path="${BASH_REMATCH[1]}"
      # trim whitespace from path
      include_path="${include_path#"${include_path%%[![:space:]]*}"}"
      include_path="${include_path%"${include_path##*[![:space:]]}"}"
      include_full="$REPO_ROOT/$include_path"

      if [[ -f "$include_full" ]]; then
        cat "$include_full" >> "$tmp_file"
        echo "" >> "$tmp_file"
      else
        echo "ERROR: Include not found: $include_path (referenced in $filename)" >&2
        rm -f "$tmp_file"
        exit 1
      fi
    else
      echo "$line" >> "$tmp_file"
    fi
  done < "$src_file"

  mv "$tmp_file" "$out_file"
  echo "  → agents/$filename"
done

echo ""
echo "Build complete. $(date '+%Y-%m-%d %H:%M:%S')"
