## Code rules

#### Javascript rules

All JavaScript code MUST follow JavaScript Standard Style. Key rules:

- No semicolons — never use semicolons at the end of a line
- 2 spaces for indentation, never tabs
- Single quotes for strings (`'hello'`), never double quotes
- No unused variables — remove unused imports and variables
- Space after keywords — `if (condition)` not `if(condition)`
- Space before curly braces — `function name () {` not `function name(){`
- Always `===` instead of `==` (except for `null` checks: `== null`)
- Handle `err` in Node.js callbacks
- `window.` prefix for browser globals (except `document` and `navigator`)
- No `var` — use `const` by default, `let` only if the variable is reassigned

Respect the existing lock file to choose package manager. If `package-lock.json` exists, use `npm install`. If `yarn.lock` exists, use `yarn install`. If `pnpm-lock.yaml` exists, use `pnpm install`. If no lock file exists, use yarn by default.

#### Ruby/Rails rules

- For Rails projects, be sure the `database.yml` is configured to use an sqlite adapter, then you can drop and recreate the database to test functionalities.
- Use always double quotes for strings in Ruby (`"hello"`), never single quotes.
