---
name: linear-create-issue
description: Create a Linear issue, ticket, bug, or task. Use when asked to file, track, log, or add something to Linear. Handles status, priority, assignee, labels, project, cycle, and milestone.
argument-hint: "[title or description]"
allowed-tools: Bash(linear:*), Bash(curl:*)
---

## Context

- Auth token: !`linear auth token 2>&1`
- Available labels: !`linear label list --all --no-color 2>&1`
- Active cycle: !`curl -s -X POST https://api.linear.app/graphql -H "Authorization: $(linear auth token)" -H "Content-Type: application/json" -d '{"query":"{ teams { nodes { key activeCycle { id number } } } }"}'`
- Team members: !`linear team members SPE --no-color 2>&1`

## Prerequisites

If the auth token above shows an error, tell the user to install the Linear CLI (`brew install linear`) and authenticate (`linear auth login`).

## Defaults

Always apply unless the user explicitly overrides:

| Flag | Default | Notes |
|------|---------|-------|
| `--state` | `Todo` | |
| `--priority` | `3` | 1=urgent, 2=high, 3=medium, 4=low |
| `--team` | `SPE` | Always required — the CLI cannot infer it |
| `--assignee` | `self` | When not `self`, must be the exact email from `linear team members SPE` — never guess |
| `--no-interactive` | (always) | |
| `--no-color` | (always) | Prevents ANSI codes from corrupting parsed output |

## Description Template

Use this for `--description` unless the user provides their own:

```
## Summary
<Brief description of what this issue addresses>

## Context
<Why this is needed, what prompted it>

## Acceptance Criteria
- [ ] <Criterion 1>
- [ ] <Criterion 2>
```

## Procedure

### Step 1: Review preloaded context and gather remaining details

Use the labels, active cycle, and team members from the Context section above. Then fetch any additional context needed:

1. **Labels**: Pick the most relevant label(s) from the preloaded list. Use multiple `--label` flags if more than one applies. Skip if intent is unclear.
2. **Active cycle**: Use the `activeCycle.id` for the user's team from the preloaded GraphQL response.
3. **Project** (if user specified one): `linear project list --all-teams` — save the project's **display name** (for `--project` on `issue create`) and its **ID** (for `--project` on `milestone list`).
4. **Milestones** (if user specified a project): `linear milestone list --project <projectId>` — use the project ID from the previous step. Save the milestone list for Step 3.
5. **Assignee** (if not `self`): Find their exact email address from the preloaded team members list. Never guess email formats.

### Step 2: Create the issue

Run `linear issue create` with the defaults above, plus `--title`, `--description`, `--label`, `--assignee` (exact email), and `--project` (display name) as applicable.

Parse the issue identifier (e.g. `SPE-1234`) from the command output — this is used in Step 3.

### Step 3: Assign cycle and milestone via GraphQL

The CLI does not support cycle or milestone assignment. Use the `issueUpdate` GraphQL mutation to patch the created issue.

**Cycle**: Always assign the active cycle from Step 1. If `activeCycle` was null (no active cycle), skip.

**Milestone** (only when a project was specified and milestones exist): Pick the milestone with the nearest future target date. If all target dates are in the past, pick the most recent one.

Send a single `issueUpdate` mutation:
- `id`: the issue identifier from Step 2 (e.g. `SPE-1234`)
- `input`: include `cycleId` and optionally `projectMilestoneId`
- Request back: `success`, `issue { identifier url cycle { number } projectMilestone { name } }`

If the mutation returns errors, report them to the user verbatim. Common causes: expired token (re-run `linear auth login`), issue not found (verify the identifier from Step 2).

Confirm to the user: issue identifier with clickable URL, cycle number, and milestone name (if assigned).
