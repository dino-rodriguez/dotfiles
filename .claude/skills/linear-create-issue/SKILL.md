---
name: linear-create-issue
description: This skill provides default values and a template for creating Linear issues. It should be used when creating a new Linear issue, including setting status, priority, assignee, and labels.
allowed-tools: Bash(linear *)
---

## Default Flags

Always include these flags unless the user explicitly overrides them:

| Flag | Default | Notes |
|------|---------|-------|
| `--state` | `Todo` | |
| `--priority` | `3` | Medium (1=urgent, 2=high, 3=medium, 4=low) |
| `--assignee` | `self` | |
| `--no-interactive` | (always) | |

## Labels

Before creating an issue, run `linear label list` to fetch the current labels. Select the most relevant label(s) based on the user's description and context. Use multiple `--label` flags if more than one applies. If the intent is unclear, skip `--label`.

## Issue Description Template

Use this template for the issue description unless the user provides their own:

```markdown
## Summary
<Brief description of what this issue addresses>

## Context
<Why this is needed, what prompted it>

## Acceptance Criteria
- [ ] <Criterion 1>
- [ ] <Criterion 2>
```
