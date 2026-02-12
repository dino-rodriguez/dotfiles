---
name: commit-push
description: Commit all changes and push to origin on the current branch using conventional commits
disable-model-invocation: true
model: sonnet
allowed-tools: Bash(git add *), Bash(git status *), Bash(git push *), Bash(git commit *), Bash(git diff *)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD 2>/dev/null || git diff --cached`
- Current branch: !`git branch --show-current`

## Conventional Commit Reference

Use conventional commit format for commit messages.

### Commit message

Format: `<type>: <description>`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

Keep the description concise (under 72 characters), lowercase, no period at the end.

## Your task

Based on the above context:

1. Stage all changes with `git add` and create a single commit with a conventional commit message
2. Push the current branch to origin with `git push -u origin HEAD`
3. Do NOT create a new branch. Stay on the current branch.
4. Do not use any other tools or send any other text besides these tool calls.
