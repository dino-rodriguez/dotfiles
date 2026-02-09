---
name: commit-push-pr
description: Commit all changes, push to origin, and open a pull request using conventional commits
disable-model-invocation: true
model: sonnet
allowed-tools: Bash(git checkout:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr create:*), Bash(git diff:*)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD 2>/dev/null || git diff --cached`
- Current branch: !`git branch --show-current`
- PR template: !`cat .github/PULL_REQUEST_TEMPLATE.md 2>/dev/null || echo "No PR template found in .github/PULL_REQUEST_TEMPLATE.md"`

## Conventional Commit Reference

Use conventional commit format for both branch names and commit messages.

### Branch naming

Format: `<type>/<short-kebab-description>`

Examples: `feat/add-user-auth`, `fix/login-redirect`, `chore/update-deps`, `refactor/extract-api-client`

### Commit message

Format: `<type>(<optional-scope>): <description>`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

Keep the description concise (under 72 characters), lowercase, no period at the end.

## Your task

Based on the above context:

1. If on `main` or `master`, create a new branch using conventional commit branch naming that reflects the changes
2. Stage all changes with `git add` and create a single commit with a conventional commit message
3. Push the branch to origin with `git push -u origin <branch-name>`
4. Create a pull request using `gh pr create`. If a PR template was found above, structure the PR body to follow that template's format and sections. Otherwise, write a concise PR body with a summary of changes.
5. If Linear issue IDs were provided as arguments (e.g. `SPE-3295` or `SPE-3295 SPE-3300`), prepend them to the PR title in brackets: `[SPE-3295] feat: description` or `[SPE-3295][SPE-3300] feat: description`. If no issue IDs were provided, use the PR title as-is without brackets.
6. You MUST do all of the above in a single message using multiple tool calls where possible. Do not use any other tools or send any other text besides these tool calls.
