---
name: refactor
description: "**WORKFLOW SKILL** — Evaluates and proposes refactoring of the code under consideration to improve maintainability, readability, performance, and to eliminate duplication. USE WHEN: the user asks to refactor, review, clean up, reorganize, improve the structure of the code, reduce duplication, or make the code more maintainable/optimized. The agent MUST first analyze the code and produce a refactoring plan, then apply the changes only after explicit user approval. DO NOT USE FOR: bug fixing, adding new features, writing documentation, or pure code formatting."
---

# Refactor Skill

When this skill is invoked, the agent MUST evaluate the target code and propose a structured refactoring plan aimed at improving maintainability, optimization, and eliminating code duplication — WITHOUT altering the external behavior of the code.

## Fundamental principles

1. **Preserve behavior**: refactoring MUST NOT change the observable behavior of the code. No new features, no bug fixes embedded in the refactor.
2. **Small, reversible steps**: prefer multiple focused changes over a single massive rewrite.
3. **Justify every change**: each proposed modification must have a clear rationale tied to maintainability, performance, readability, or DRY.
4. **Respect the existing style**: follow the conventions, patterns, and architecture already present in the project. Do not introduce new paradigms, libraries, or abstractions unless strictly necessary and justified.
5. **Do not over-engineer**: avoid premature abstractions, unnecessary design patterns, or speculative generality.

## Mandatory operational procedure

The agent MUST follow these phases IN ORDER:

### Phase 1 — Analysis

1. Identify the scope of the refactor (specific file, module, function, or entire directory indicated by the user).
2. Read the involved code and, if necessary, the surrounding context (callers, tests, related modules).
3. Identify concrete refactoring opportunities, classified among:
   - **Code duplication** (DRY): repeated logic to be extracted.
   - **Maintainability**: functions/classes too long, excessive responsibilities, unclear names, deep nesting, magic numbers/strings.
   - **Optimization**: redundant operations, inefficient algorithms, unnecessary allocations, I/O that can be batched.
   - **Structure**: inappropriate coupling, violation of cohesion, missing layers, mixed abstractions.
   - **Readability**: unclear control flow, overly long expressions, missing intermediate variables with meaningful names.
4. Check for the presence of tests covering the code. If tests are absent or insufficient, explicitly flag it as a risk.

### Phase 2 — Refactoring plan

Produce a plan presented to the user BEFORE making any changes. The plan MUST include:

- **List of identified issues**, each with:
  - Precise location (file + line or function/class).
  - Type of problem (duplication / maintainability / optimization / structure / readability).
  - Concrete impact (why it is a problem).
- **Proposed changes**, each with:
  - Brief description of the intervention.
  - Rationale (what improves and why).
  - Estimated risk (low / medium / high) and affected areas.
  - Order of execution (dependencies between changes).
- **Elements deliberately NOT touched** and why (e.g. risky area without tests, out of scope, acceptable trade-off).

### Phase 3 — Approval

Do NOT apply changes without explicit confirmation from the user. Present the plan and wait for approval. The user may request modifications, reductions, or extensions of the plan.

### Phase 4 — Execution

Once approved:

1. Apply changes in the established order, in small coherent steps.
2. After each significant change, verify that existing tests still pass (if present) or suggest the user run them.
3. Do not mix refactoring with functional changes: if a bug is discovered during the refactor, flag it separately without fixing it within the refactor (unless explicitly requested).
4. Keep commits/logically separate units of change if the context allows (e.g. one intervention = one semantic block of changes).

### Phase 5 — Final summary

At the end of the execution, provide a concise summary including:

- Changes actually applied (with paths of modified files).
- Changes from the plan that were NOT applied and why.
- Residual risks and suggested next steps (e.g. tests to be added, follow-up refactor).

## Typical refactoring patterns to evaluate

- **Extract function/method**: to break up long functions or give a name to a block of logic.
- **Extract module/class**: to isolate a cohesive responsibility.
- **Inline**: to remove a useless indirection.
- **Rename**: to make intent clearer.
- **Replace magic values with constants**.
- **Consolidate duplicated logic** into a single function/module.
- **Replace conditional with polymorphism/lookup table** where it reduces complexity.
- **Introduce parameter object / return object** when signatures become too long.
- **Guard clauses** to reduce nesting.
- **Separation of concerns**: separate I/O, business logic, and presentation when they are mixed together.

## Anti-patterns to avoid during refactoring

- Rewriting everything "from scratch" when small targeted changes are sufficient.
- Introducing new dependencies or frameworks to "modernize" the code without real necessity.
- Changing public APIs without evaluating the impact on callers.
- Applying abstract design patterns without concrete use cases justifying them.
- Embedded fixes: silently correcting bugs while refactoring (always flag them separately).
- Stylistic/formatting changes mixed with substantive changes (they make review harder).

## Quality guidelines for the analysis

- **Be specific**: cite file names, functions, and line numbers.
- **Argue every proposal**: an improvement without rationale is not a refactoring, it is a preference.
- **Quantify when possible**: "function of 180 lines with 6 responsibilities", "logic duplicated in 3 files".
- **Honesty on trade-offs**: if a change has drawbacks (e.g. a bit more indirection in exchange for less duplication), state them.
- **Language**: use the same language as the conversation with the user.
