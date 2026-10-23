## Subagents usage

Use subagent when main context too big or task isolated (search, single file edit, focused exec) or when user asks for it. Break complex tasks into subagent-sized pieces. Use correct model for subagent, based on the task complexity and context size.

Validate output: correct + expected format. Wrong format (duplicated code, bad convention) → ask subagent to return only corrected version, no explanation.