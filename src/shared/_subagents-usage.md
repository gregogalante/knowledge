## Subagents usage

If tool supports subagents: use one when main context too big, task isolated (search, single file edit, focused exec), or user asks. Break complex tasks into subagent-sized pieces. If tool lets you pick model, match it to task complexity and context size.

Validate output: correct + expected format. Wrong format (duplicated code, bad convention) → ask subagent to return only corrected version, no explanation.

### Bulk I/O delegation

Protect main context: shunt I/O-heavy work to subagent on cheapest capable model.

- Bulk read → subagent: file >350 lines read in full, question spanning 3+ files, large diff summary. Subagent returns structured bullets only, led by exact names, types, line numbers. Full content never enters main context.
- Need exact content for edit → targeted read only (offset/limit, `sed -n`, `grep -n`). No full `cat`/`head`/`tail` on large files.
- Boilerplate → subagent: tests, config, stubs, docstrings >80% predictable from a reference file. Pass reference file, subagent matches its patterns and writes target. Main agent reviews and edits the rest.
- Never delegate: debugging, architectural decisions, small files.
- Verify line numbers and exact values from subagent output before using them in edits.
