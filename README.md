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
