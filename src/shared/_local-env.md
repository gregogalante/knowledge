## Local Environment

Source `~/.zshrc` before using nvm/rbenv/conda if shell does not expose them.

No background processes left running (`node`, `python`, `rails server`, ...). Process started to test something → terminate it when done. User runs it manually if needed.

### Node.js — managed via nvm

No system-level Node. Init nvm before use. If `.nvmrc` present in repo → `nvm use`.

### Python — managed via Conda

Never use system Python (`/usr/bin/python3`). Activate Conda env before use. Default to **base** if none requested. If `environment.yml` present → ask which env to create/activate.

### Ruby — managed via rbenv

No system-level Ruby. rbenv controls active version. `.ruby-version` is auto-respected by rbenv — verify required version installed (`rbenv install`).

### Docker

Installed and available. Use `docker ps` to check running containers. Stop any containers you start when done.