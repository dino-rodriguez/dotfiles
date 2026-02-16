---
name: standup
description: Generate a standup summary from your recent PRs, enriched with Linear issue context
disable-model-invocation: true
model: sonnet
allowed-tools: Bash(gh:*), Bash(date:*), Bash(linear:*)
---

## Context

- Current date: !`date "+%Y-%m-%d %H:%M %Z"`
- Default lookback (36h ago): !`date -u -v-36H "+%Y-%m-%dT%H:%M:%SZ"`
- GitHub username: !`gh api user --jq '.login'`

## Instructions

0. Determine the lookback window. Default is 36 hours. If the user specifies a custom timeframe (e.g. "last 80 hours", "last week", "since Monday"), calculate the appropriate UTC timestamp from the current date above.

1. Fetch PRs from the lookback window:
   ```
   gh pr list --author "@me" --state all --search "created:>=<LOOKBACK_TIMESTAMP>" --json title,body,state,url,number --limit 50
   ```

2. For each PR with a Linear issue ID in the title (e.g. `SPE-123`), fetch issue details in parallel:
   ```
   linear issue view <ISSUE-ID>
   ```

3. Generate a standup for each PR. Format each PR as its own standalone block (not a list). Include the status next to the PR link. Separate each block with a blank line.

   ```
   **PR title** ([#N](url)) · Merged
   *Problem:* what problem this solves and why it matters (from Linear context + PR description)
   *Solution:* what changed and how it solves the problem (from PR title + description)

   **PR title** ([#N](url)) · Open
   *Problem:* ...
   *Solution:* ...
   ```
   If no PRs, say "No PRs in the last <N> hours." (using the actual lookback window).

5. Do all of the above in a single message using parallel tool calls where possible.
