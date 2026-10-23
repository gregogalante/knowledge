## Subagents usage

If tool supports subagents: use one when main context too big, task isolated (search, single file edit, focused exec), or user asks. Break complex tasks into subagent-sized pieces. If tool lets you pick model, match it to task complexity and context size.

Validate output: correct + expected format. Wrong format (duplicated code, bad convention) → ask subagent to return only corrected version, no explanation.
