---
name: code-styleguide-javascript
description: "**DOMAIN SKILL** — Enforce JavaScript Standard Style and project hygiene. USE FOR: writing or reviewing JavaScript/JSX code; creating new files, functions, or components; refactoring; code reviews. DO NOT USE FOR: non-JavaScript languages; configuration-only changes; documentation-only edits."
---

# Code Style Guide — JavaScript

## Standard Style

All JavaScript code MUST follow [JavaScript Standard Style](https://standardjs.com/). Key rules:

- **No semicolons** — never use semicolons at the end of a line
- **2 spaces** for indentation, never tabs
- **Single quotes** for strings (`'hello'`), never double quotes
- **No unused variables** — remove unused imports and variables
- **Space after keywords** — `if (condition)` not `if(condition)`
- **Space before curly braces** — `function name () {` not `function name(){`
- **Always `===`** instead of `==` (except for `null` checks: `== null`)
- **Handle `err`** in Node.js callbacks
- **`window.` prefix** for browser globals (except `document` and `navigator`)
- **No `var`** — use `const` by default, `let` only if the variable is reassigned

### Template literals

Use template literals (`` `hello ${name}` ``) instead of string concatenation.

### Arrow functions

Prefer arrow functions for callbacks and anonymous functions:

```js
// Yes
const items = list.map((item) => item.name)

// No
const items = list.map(function (item) { return item.name })
```

### Destructuring

Use destructuring to extract values from objects and arrays:

```js
// Yes
const { name, age } = user
const [first, second] = items

// No
const name = user.name
const age = user.age
```

### Import/Export

Prefer ESM (`import`/`export`) over CommonJS (`require`/`module.exports`) in projects that support it.

## Code Reuse

Before creating a new function, component, or utility, **always search the project first to see if something similar or reusable already exists**.

### Mandatory procedure

1. **Search first** — Use semantic search or grep in the project to find functions, components, or helpers that already do what you need
2. **Reuse** — If something similar exists, reuse it directly or extend it by adding parameters/options
3. **Generalize** — If an existing function does almost the same thing, consider generalizing it instead of creating a new one
4. **Create only if necessary** — Create a new function/component only if nothing reusable exists

### Signs of duplication

When about to write code, ask yourself:
- Does a helper/utility already exist for this?
- Is there a similar component that could be parameterized?
- Is this logic already present elsewhere in the project?

If the answer is yes to any of these, reuse the existing code.

### Extracting common code

If you find the same pattern repeated in multiple places:
- Extract it into a shared function/component
- Place it in the appropriate folder (see next section)
- Update existing usages to use the shared version

## File placement in the project

When creating new files, **respect the existing structure and conventions** of the project.

### Mandatory procedure

1. **Analyze the structure** — Before creating a file, explore the project structure to understand where different types of files belong
2. **Follow the patterns** — If the project has a convention (e.g. components in `components/`, utilities in `utils/`, hooks in `hooks/`), follow it
3. **Consistency** — A file of the same type must go in the same folder as its siblings
4. **Don't create new folders** unnecessarily — use existing ones when possible

### General rules

| File type | Where to look |
|---|---|
| UI Components | `components/`, `src/components/`, or in the corresponding feature |
| Utilities/Helpers | `utils/`, `lib/`, `libs/`, `helpers/` |
| Hooks (React) | `hooks/`, `src/hooks/` |
| Constants | `constants/`, `config/` |
| Types/Interfaces | `types/`, or co-located with the module |
| Tests | Co-located (`__tests__/`, `.test.js`) or in `test/` |
| Services/API | `services/`, `api/` |
| Store/State | `store/`, `state/` |

If the project doesn't have one of these folders, **look at where similar files are placed** and follow the same convention.
