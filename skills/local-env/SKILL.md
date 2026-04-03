---
name: local-env
description: "**WORKFLOW SKILL** — Local environment setup for Node.js (nvm), Python (Conda), and Ruby (rbenv). USE FOR: running scripts; installing packages; switching language versions; any task requiring node/npm/npx, python/pip/conda, or ruby/gem/bundle. DO NOT USE FOR: tasks unrelated to these three runtimes."
---

# Local Environment Setup

## Node.js — managed via nvm

Node.js is installed and managed via **nvm** (Node Version Manager). No system-level Node is available: nvm must be initialized before using Node.

### Rules

#### 1. Activate the chosen version

- **Default version**: run `nvm use default`.
- **Specific version**: install (if needed) and activate:
  ```sh
  nvm install <version>
  nvm use <version>
  ```

#### 2. Package installation

- Use `yarn add <package>` for packages (yarn is preferred).
- If the project uses yarn or pnpm, respect the existing lock file.

#### 3. Verify

After activation, verify the version is correct:

```sh
which node
node --version
npm --version
```

---

## Python — managed via Conda

Python is installed and managed via **Conda**. No system-level Python is available: a Conda environment must always be activated before using Python.

### Rules

#### 1. Base default environment

Use the **base** Conda environment for general-purpose Python tasks that don't require specific dependencies. This is the default environment when Conda is initialized.

If user specifically requests a specific environment, proceed to step 2.

#### 2. Activate the chosen environment

- **Base environment**: activate with `conda activate` (no argument activates base).
- **Dedicated environment**: ask for the name, then create and activate:
  ```sh
  conda create -n <env_name> python -y
  conda activate <env_name>
  ```

#### 3. Package installation

- Prefer `conda install <package>` when available.
- Use `pip install <package>` only if the package is not available on Conda.

#### 4. Verify

After activation, verify the environment is correct:

```sh
which python
python --version
```

---

## Ruby — managed via rbenv

Ruby is installed and managed via **rbenv**. No system-level Ruby is used: rbenv controls which Ruby version is active.

### Rules

#### 1. Activate the chosen version

- **Global version**: rbenv will use it automatically — no extra command needed.
- **Specific version**: install (if needed) and set locally:
  ```sh
  rbenv install <version>   # if not already installed
  rbenv local <version>     # sets .ruby-version in the project directory
  ```

#### 2. Package installation

- Use `bundle install` to install gems defined in `Gemfile`.
- Use `gem install <gem>` for standalone gems outside a Bundler context.

#### 3. Verify

After setup, verify the version is correct:

```sh
which ruby
ruby --version
gem --version
bundle --version
```
