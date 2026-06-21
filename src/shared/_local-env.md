## Local Environment

Source `~/.zshrc` before using nvm/rbenv/conda if shell does not expose them.

### Node.js — managed via nvm

No system-level Node. Init nvm before use. If `.nvmrc` present in repo → `nvm use`.

### Python — managed via Conda

No system-level Python. Activate Conda env before use. Default to **base** if none requested. If `environment.yml` present → ask which env to create/activate.

### Ruby — managed via rbenv

No system-level Ruby. rbenv controls active version. `.ruby-version` is auto-respected by rbenv — verify required version installed (`rbenv install`).
