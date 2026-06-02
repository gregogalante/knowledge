## Subagents usage

Subagents are designed to be used to run single specific tasks when full context is too big and complex for the main agent. They are ideal for running specific code snippets, performing specific actions, or handling specific requests that require a focused context.

Use subagents when you need to run a specific piece of code, perform a specific action, or handle a specific request that requires a focused context. Subagents can be used to break down complex tasks into smaller, more manageable pieces, and to run code that requires a different context than the main agent.

Always validate the subagent's output to be sure it is correct and follow the expected format. If the output is correct but not in the expected format (for example it duplicates code, follow not valid convention), you can ask the subagent to fix the output and provide only the corrected version without any explanation.