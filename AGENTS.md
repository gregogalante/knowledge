# AGENTS

Repo rules.

- `src/` is source of truth.
- `src/shared/` holds reusable fragments, pulled in via `<!-- @include shared/<file>.md -->`.
- `src/agents/_developer.toml` is global agent: its `developer_instructions` become user-level rules for every tool.
- `src/claude/_claude-rules.md` holds Claude-only rules (rely on Claude-only tools), appended to `claude/CLAUDE.md` only.
- `build.sh` compiles into:
  - `claude/CLAUDE.md`, `codex/AGENTS.md`, `opencode/AGENTS.md`: global rules (same content, plus Claude-only rules in `CLAUDE.md`).
  - `codex/agents/*.toml`: Codex subagents.
  - `opencode/agents/*.md`: OpenCode agents (frontmatter; global agent has no body, rules come from `AGENTS.md`). `opencode/opencode.json` copied from `src/opencode/`.
- `lib.sh` holds `link_rules`, sourced by the install scripts (refuses to replace a real file).
- `install-claude.sh` links `~/.claude/CLAUDE.md`.
- `install-codex.sh` links `~/.codex/{AGENTS.md,agents}`. `~/.codex/config.toml` stays app-owned, not managed here.
- `install-opencode.sh` links `~/.config/opencode/{AGENTS.md,agents,opencode.json}`.
- `test.sh` checks build is fresh and all three installs point at it. Run after changes.
- `clean-sessions.sh` deletes local session history of all three tools. Dry-run unless `--yes`.
- `_backups/` is archival. Leave unchanged.
