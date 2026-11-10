## Git rules

Skip these rules if not a git repo (`git rev-parse --is-inside-work-tree` fails).

Start of work (before any task in a repo):
- Sync, fast-forward only: `git fetch --prune`, then update default branch (name from `git symbolic-ref refs/remotes/origin/HEAD`; `git fetch origin <default>:<default>` if not on it) and current branch if it has upstream (`git pull --ff-only`). Fails (diverged, conflicts) → report, never force.
- Uncommitted or untracked files (`git status`) → report them before starting.
- Stashes (`git stash list`) → report them before starting.
- Local branches not pushed (`git branch -vv`: no upstream, ahead, or upstream `gone`) → report them before starting.
- Report only. Never commit, stash, push, or delete to clean up without user's yes.

Branching:
- No direct work on `main` / `master`. Create branch first, unless user explicitly names main/master in request (e.g. "commit on main", "push to main"): that counts as confirmation.
- Branch name: conventional prefix + descriptive slug. Prefixes: `feature/`, `bugfix/`, `hotfix/`, `chore/`, `refactor/`, `docs/`, `test/`. Example: `feature/add-user-endpoint`.

Commit (trigger: user says `commit`):
- Use conventional commits: `type(scope): subject`. Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `style`, `perf`.
- Subject: imperative, present tense, lowercase, no trailing period. Example: `feat(auth): add login endpoint`.
- Respect repo config: GPG sign, DCO sign-off, hooks. Never bypass with `--no-verify`.

Push (trigger: user says `push`):
- Separate step: a commit never implies a push.
- Ask confirmation before `push --force` or `push --force-with-lease`.

End of work:
- Task done and repo has uncommitted changes or unpushed commits (`git status`, `git log @{u}..`) → ask user whether to commit and push; act only on their yes.
- Branch has no upstream → ask too, since work exists only locally.

Pull request (trigger: user says `pull request` / `pr`):
- Open PR from current branch to default branch.
- Title: same convention as commit subject.
- Description: what changed + why. Skip reviewer assignment unless user specifies.

Merge into `main` / `master` (trigger: user asks to merge):
- After successful merge, always delete the merged branch, both local (`git branch -d`) and remote if it exists (`git push origin --delete <branch>`). No confirmation needed: branch is fully merged, so nothing is lost and it would otherwise be left abandoned.
- `-d` refuses (branch not fully merged) → stop and report, delete nothing, never fall back to `-D` without confirmation.

Destructive ops — ask confirmation before:
- `reset --hard`, `clean -fd`
- `rebase` on already-pushed branch
- `commit --amend` after push
- `branch -D`, `push --force*`
