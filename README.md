# Knowledge

`src/` is source of truth. `build.sh` generates per-tool files; install scripts symlink them into each tool's user config. See [AGENTS.md](AGENTS.md) for output layout.

## Build

```bash
./build.sh
```

## Install

```bash
./install-claude.sh
./install-codex.sh
./install-opencode.sh
```

Note: Claude Cowork sessions ignore a symlinked `~/.claude/CLAUDE.md`.

## Check

```bash
./test.sh
```

Exit code 1 + `FAIL` lines when a build is outdated or an install is missing, wrong or stale.

## Clean sessions

```bash
./clean-sessions.sh        # dry-run: list what would be deleted
./clean-sessions.sh --yes  # delete
```

Removes local session history of Claude Code, Codex and OpenCode; keeps auth, config and rules. Quit the apps first. Cloud sessions (claude.ai, Codex cloud, OpenCode `/share`) need deleting from their web UI.
