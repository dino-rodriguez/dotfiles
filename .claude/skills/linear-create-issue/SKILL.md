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

Infer the label from the user's description or explicit request. If the intent is unclear, skip `--label`.

| Label | Use when |
|-------|----------|
| `Feature` | New functionality or capability |
| `Bug` | Fixing broken behavior |
| `Documentation` | Docs-only changes |
| `Improvement` | Refactoring or enhancing existing functionality |
| `Testing` | Adding or updating tests |
| `Chore` | Maintenance, dependencies, cleanup |
| `Performance` | Speed or resource optimization |
| `CI/CD` | Pipeline or deployment changes |
| `Style` | Formatting or cosmetic changes |

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
