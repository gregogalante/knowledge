## Documentation rules

Ensure `AGENTS.md` exists at repo root. If missing, create with project basics. If `README.md` already covers overview/setup, do not duplicate — keep `AGENTS.md` focused on agent-facing instructions (conventions, commands, architecture pointers).

Split into `docs/` when `AGENTS.md` exceeds ~300 lines or covers >3 distinct domains. Markdown only, clear headings, no fluff.

Language: English.

Update docs when: build changes, run/test commands change, project structure shifts, key dependencies added/removed, conventions evolve.

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
