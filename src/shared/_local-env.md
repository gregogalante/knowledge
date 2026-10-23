## Local Environment

Source `~/.zshrc` before using nvm/rbenv/conda if shell does not expose them.

### Background processes

No background processes left running (`node`, `python`, `rails server`, dev servers, Docker containers, ...). User runs them manually if needed.

- Started to test something → terminate it as soon as check is done.
- Started to show user something (local server, preview) → terminate it when user is done with it.
- Every process left running at end of turn → schedule automatic shutdown after max 30 minutes, so it dies even if user forgets. Use the tool's own scheduling feature (e.g. Claude Code's scheduled tasks). Shell watchdog only as fallback when tool has none, e.g. `(sleep 1800; kill <pid>) >/dev/null 2>&1 &`. Tell user PID/port and shutdown time.

### Node.js — managed via nvm

No system-level Node. Init nvm before use. If `.nvmrc` present in repo → `nvm use`.

### Python — managed via Conda

Never use system Python (`/usr/bin/python3`). Activate Conda env before use. Default to **base** if none requested. If `environment.yml` present → ask which env to create/activate.

### Ruby — managed via rbenv

No system-level Ruby. rbenv controls active version. `.ruby-version` is auto-respected by rbenv — verify required version installed (`rbenv install`).

### Docker

Installed and available. Use `docker ps` to check running containers. Stop any containers you start when done.