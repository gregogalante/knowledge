## Documentation rules

`AGENTS.md` at repo root = agent-facing instructions (conventions, commands, architecture pointers). Create or update it only when user asks, or when change affects what it covers (build, run/test commands, structure, key dependencies, conventions). If `README.md` already covers overview/setup, do not duplicate.

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
