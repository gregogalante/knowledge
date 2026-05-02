---
name: loop
description: "**WORKFLOW SKILL** — Executes autonomous iterative work loop (plan → modify → verify → repeat) until target outcome is reached with objective evidence. USE WHEN: user asks long autonomous execution, iterative fixing, trial-and-verify workflow, or 'work until done'. Requires upfront clarification of goal and success tests, local execution capability check, then continuous loop with progress updates. DO NOT USE FOR: one-shot trivial tasks or pure explanations without execution."
---

# Loop Skill

When this skill is invoked, agent MUST run autonomous delivery loop focused on measurable outcome: understand target, validate testability in local environment, iterate changes + verification until success criteria pass.

## Core objective

Drive task to completion without user babysitting.

Pattern:
1. Clarify outcome and acceptance tests.
2. Prove local execution/verification capability.
3. Enter iterative loop (change → test → evaluate → next change).
4. Exit only with objective success evidence or hard blocker.

## Mandatory rules

1. **No blind coding**: before edits, define explicit success criteria and how to test them.
2. **Ask only missing critical info**: gather all required constraints in one compact question set.
3. **Testability gate required**: verify commands/files/runtime needed for validation are actually accessible and executable.
4. **Autonomous loop required**: once gate passes, continue iterations without asking user each step.
5. **Evidence over opinion**: every claim of progress must cite command output, test results, logs, or artifact paths.
6. **Single in-progress objective**: keep one primary goal active until done or blocked.
7. **Stop conditions explicit**: success reached, hard blocker detected, or user-stated limit reached.

## Mandatory operational procedure

Follow phases IN ORDER.

### Phase 1 — Goal alignment (ask + confirm)

Agent MUST confirm:
- Target outcome (what must be true at end).
- Acceptance criteria (functional, technical, performance, UX, etc.).
- Verification method (tests, app run, scripts, manual checks).
- Constraints (time, scope, forbidden changes, dependency/version limits).

If any critical element missing, ask user focused questions in single batch.

Then restate concise contract:
- "Goal"
- "Done when"
- "How I will verify"
- "Constraints"

Do not start implementation before this alignment.

### Phase 2 — Autonomy readiness check (local testability gate)

Before coding loop, agent MUST verify environment allows autonomous validation.

Checklist:
1. Identify required commands (example: build/test/run/lint/e2e).
2. Execute minimal smoke commands to prove access.
3. Verify required files/config exist and are readable.
4. Detect blockers early: missing secrets, permissions, external services, unavailable runtime.

Output to user MUST include:
- Commands executed.
- Result per command (pass/fail + short reason).
- Explicit statement:
  - **Ready**: "I can work autonomously and verify results locally."
  - **Not ready**: exact blocker list + minimal action needed from user.

If not ready, pause and request only blocker-resolving input.

### Phase 3 — Autonomous execution loop

After readiness confirmed, enter loop.

Loop cycle (repeat):
1. Select next smallest high-impact change.
2. Apply code/config change.
3. Run relevant verification subset immediately.
4. Evaluate result vs acceptance criteria.
5. Decide next action:
   - continue (partial progress),
   - rollback/adjust (regression/failure),
   - expand verification (if near completion).
6. Log concise iteration note (change, command, result, decision).

Rules inside loop:
- Keep steps small and reversible.
- Prefer fastest feedback tests first, then broader suite.
- If failure appears, isolate root cause before next broad change.
- Do not ask user for routine choices agent can decide.

### Phase 4 — Completion proof and exit

Exit loop only when all acceptance criteria satisfied.

Final output MUST include:
1. Criteria checklist with pass/fail.
2. Verification evidence (commands + key outputs).
3. Modified files list.
4. Residual risks or follow-ups (if any).

If impossible to complete, provide blocker report:
- Attempts made.
- Evidence collected.
- Why blocker is hard.
- Minimal user action to unblock.

## Progress communication protocol

While looping for long tasks, provide periodic compact updates (time- or milestone-based):
- Current hypothesis/step.
- Last verification result.
- Next planned action.

Avoid noise. Report only decision-relevant info.

## Decision heuristics

- **If ambiguous requirement**: ask early, once.
- **If repeat failure ≥ 2 cycles same cause**: switch strategy, not random retries.
- **If broad tests expensive**: run targeted tests each iteration; run full suite before declaring done.
- **If change increases risk**: add/adjust test coverage before further refactor.

## Anti-patterns to avoid

- Starting implementation before defining "done".
- Claiming success without executable evidence.
- Asking user to run checks agent can run locally.
- Large speculative rewrites without iterative validation.
- Endless looping without strategy changes.

## Output templates

### Readiness confirmation template

```text
Goal understood:
- Goal: ...
- Done when: ...
- Verify via: ...
- Constraints: ...

Readiness check:
1) <command/file check> → PASS/FAIL (<reason>)
2) ...

Status: READY / NOT READY
If READY: I can work autonomously and verify results locally. Starting loop now.
If NOT READY: Need: <minimal unblock actions>
```

### Iteration log template

```text
Iteration N
- Change: ...
- Verification: <command>
- Result: PASS/FAIL (...)
- Decision: continue / adjust / rollback
```

### Final completion template

```text
Completion status: DONE

Acceptance criteria:
- [x] ...
- [x] ...

Verification evidence:
- <command> → <key output>
- <command> → <key output>

Files changed:
- path/to/file1
- path/to/file2

Residual notes:
- ...
```

## Language

Use same language as user conversation.
