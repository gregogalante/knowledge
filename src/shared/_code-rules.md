## Code rules

Repo config wins: existing linter/formatter config (`.eslintrc`, `.prettierrc`, `.rubocop.yml`, `.editorconfig`, ...) and surrounding code style override defaults below. Defaults apply only when repo has none.

### Comments

English. Comment non-obvious why (intent, constraint, workaround), not what. Match comment density of surrounding code. No comments restating code.

### JavaScript

Default style: JavaScript Standard Style (no semicolons, 2 spaces, single quotes, `===`, `const`/`let` no `var`). If repo configures `eslint` / `standard`, run it before delivering.

### Package manager (Node)

Respect existing lock file: `package-lock.json` → `npm install`, `yarn.lock` → `yarn install`, `pnpm-lock.yaml` → `pnpm install`. No lock file → default to yarn.

### Ruby/Rails

- Default string quotes: double (`"hello"`).
- Rails + SQLite local DB: drop/recreate freely to test. Any other adapter (Postgres, MySQL, prod-like): ask confirmation before destructive DB actions. Never modify `config/database.yml` to switch adapter without explicit user request.
