# Shared helpers for install-*.sh. Source it, do not execute.

# Symlink $1 (built file in repo) at $2, refusing to replace a real file:
# the target may hold hand-written rules.
link_rules () {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "ERROR: $src not found. Run ./build.sh first." >&2
    exit 1
  fi
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "ERROR: $dest exists and is not a symlink. Remove it manually first." >&2
    exit 1
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "Linked: $dest → $src"
}
