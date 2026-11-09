
## Claude-specific rules

### Session title

If a session-rename tool is available (e.g. `mcp__ccd_session_mgmt__set_session_title` in the desktop app; load it via ToolSearch if deferred), set the title on the first turn of every session, before other work.

Format: `DD/MM | <short description of requested task>`. Date = today. Description in user's language, max ~6 words. Example: `09/11 | Regola titolo sessione per Claude`.

Rename again only when the user switches to an unrelated task. No tool available → skip silently.
