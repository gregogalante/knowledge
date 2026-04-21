---
name: report
description: "**WORKFLOW SKILL** — Generates a complete report of the work activity just performed. USE WHEN: the user asks to create a report, summarize what has been done, document decisions, or track work at the end of a task. Forces creation of a markdown file at `reports/{timestamp}-{task_description}.md` detailing actions, motivations, and purpose. DO NOT USE FOR: code documentation, READMEs, or commit messages."
---

# Report Skill

When this skill is invoked, the agent MUST generate a complete report of the work activity just completed and save it to a file.

## Mandatory rules

1. **File path**: the report MUST be saved to `reports/{timestamp}-{task_description}.md` relative to the root of the current workspace.
   - `{timestamp}` format: `YYYYMMDD-HHMM` (e.g. `20260421-1530`).
   - `{task_description}` format: kebab-case, short (max 5-6 words), descriptive of the task performed (e.g. `refactor-auth-controller`).
2. **Create the `reports/` directory** if it does not exist.
3. **Do not ask the user for confirmation**: generate the report autonomously using the context of the current conversation.
4. **The report must be complete**: do not over-summarize. Include all relevant details of the work performed.

## Mandatory report structure

The markdown file MUST follow EXACTLY this structure:

```markdown
# Report: {Descriptive task title}

**Date**: {YYYY-MM-DD HH:MM}
**Workspace**: {workspace name}

## Goal

Clear description of the purpose of the activity: what was to be achieved and why.

## Initial context

State of the project/code before the intervention. Problems, constraints, or starting requirements.

## Activities performed

Ordered, detailed list of actions performed. For each significant action:
- **What**: description of the intervention.
- **Files involved**: paths of files created, modified, or deleted.
- **Details**: technical description of the changes.

## Design decisions and rationale

For each non-trivial decision taken during the work:
- **Decision**: what was decided.
- **Rationale**: why it was preferred over alternatives.
- **Purpose**: which goal it serves, which problem it solves.
- **Alternatives discarded** (if relevant): what was evaluated and why it was not chosen.

## Final result

State of the project after the intervention. What now works, what has changed compared to the starting point.

## Notes and follow-up

Any open points, remaining todos, known risks, or suggestions for future work.
```

## Quality guidelines for the report

- **Be specific**: cite actual file names, functions, classes, and commands used.
- **Explain the "why"**, not just the "what": motivations are the most important part of the report.
- **Be honest**: if something was not completed, if there are doubts or trade-offs, report them in the "Notes and follow-up" section.
- **Avoid fluff**: no generic phrases like "I improved the code". Specify what and how.
- **Language**: use the same language as the conversation with the user.

## Operational procedure

1. Determine `{timestamp}` from the current date/time.
2. Derive `{task_description}` from the conversation content.
3. Verify/create the `reports/` directory.
4. Create the file `reports/{timestamp}-{task_description}.md` following the structure above.
5. Inform the user of the path of the generated report.
