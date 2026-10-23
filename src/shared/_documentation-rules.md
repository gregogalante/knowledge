## Documentation rules

### In-repo docs

Rules below apply to docs committed in the repo (`AGENTS.md`, `docs/`), not to personal deliverables.

`AGENTS.md` at repo root = single source of agent-facing instructions (conventions, commands, architecture pointers), shared by all tools. Never write instructions in `CLAUDE.md`: it only contains `@AGENTS.md` so Claude Code loads the same file. Repo has `CLAUDE.md` with content and no `AGENTS.md` → move content to `AGENTS.md`, replace `CLAUDE.md` with `@AGENTS.md`.

Create or update it only when user asks, or when change affects what it covers (build, run/test commands, structure, key dependencies, conventions). If `README.md` already covers overview/setup, do not duplicate.

Split into `docs/` when `AGENTS.md` exceeds ~300 lines or covers >3 distinct domains. Markdown only, clear headings, no fluff.

Language: English.

Things to write:
- Project overview and purpose
- Shared rules: coding style, local env setup
- Run / test / build commands
- Key components and architecture (high-level)
- Recurring patterns and conventions with minimal examples

Things NOT to write:
- Feature implementation details
- Personal opinions
- Outdated info
- Step-by-step task workflows
- Full class / component dumps (link to source instead)

### Personal deliverables

Reports, analyses, ad-hoc documentation files and similar deliverables requested by user.

- Location: `~/Desktop`, unless user explicitly says to put them in the repo. Report the full path when done.
- Language: user's language.
- Format: whatever fits the request; in-repo rules above do not apply.
