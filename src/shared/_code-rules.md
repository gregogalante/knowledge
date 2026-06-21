## Code rules

#### Javascript rules

All JavaScript code MUST follow JavaScript Standard Style. Key rules:

- No semicolons — never use semicolons at the end of a line
- 2 spaces for indentation, never tabs
- Single quotes for strings (`'hello'`), never double quotes
- No unused variables — remove unused imports and variables
- Space after keywords — `if (condition)` not `if(condition)`
- Space before curly braces — `function name () {` not `function name(){}`
- Always `===` instead of `==` (except for `null` checks: `== null`)
- Handle `err` in Node.js callbacks
- `window.` prefix for browser globals (except `document` and `navigator`)
- No `var` — use `const` by default, `let` only if the variable is reassigned

If repo configures `eslint` / `standard`, run it before delivering. Otherwise apply rules above manually.

#### Package manager (Node)

Respect existing lock file: `package-lock.json` → `npm install`, `yarn.lock` → `yarn install`, `pnpm-lock.yaml` → `pnpm install`. No lock file → default to yarn.

#### Ruby/Rails rules

- Use always double quotes for strings in Ruby (`"hello"`), never single quotes.
- Rails + SQLite local DB: drop/recreate freely to test. Any other adapter (Postgres, MySQL, prod-like): ask confirmation before destructive DB actions. Never modify `config/database.yml` to switch adapter without explicit user request.
