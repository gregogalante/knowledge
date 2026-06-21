## Git rules

Skip these rules if not a git repo (`git rev-parse --is-inside-work-tree` fails).

Branching:
- No direct work on `main` / `master`. Create branch first.
- If user explicitly requests work on main/master, ask confirmation before committing.
- Branch name: conventional prefix + descriptive slug. Prefixes: `feature/`, `bugfix/`, `hotfix/`, `chore/`, `refactor/`, `docs/`, `test/`. Example: `feature/add-user-endpoint`.

Commit (trigger: user says `commit`):
- Use conventional commits: `type(scope): subject`. Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `style`, `perf`.
- Subject: imperative, present tense, lowercase, no trailing period. Example: `feat(auth): add login endpoint`.
- Commit only. Do NOT push.
- Respect repo config: GPG sign, DCO sign-off, hooks. Never bypass with `--no-verify`.

Push (trigger: user says `push`):
- Explicit step, separate from commit.
- Ask confirmation before `push --force` or `push --force-with-lease`.

Pull request (trigger: user says `pull request` / `pr`):
- Open PR from current branch to default branch.
- Title: same convention as commit subject.
- Description: what changed + why. Skip reviewer assignment unless user specifies.

Destructive ops — ask confirmation before:
- `reset --hard`, `clean -fd`
- `rebase` on already-pushed branch
- `commit --amend` after push
- `branch -D`, `push --force*`
