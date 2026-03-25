---
name: standup
description: Generate a standup summary from your recent PR activity, enriched with Linear issue context
argument-hint: "[timeframe]"
allowed-tools: Bash(gh:*), Bash(date:*), Bash(linear:*)
---

## Context

- Current date: !`date "+%Y-%m-%d %H:%M %Z"`
- Default lookback (36h ago): !`date -u -v-36H "+%Y-%m-%dT%H:%M:%SZ"`
- GitHub username: !`gh api user --jq '.login'`
- Recent PRs (default 36h window): !`gh pr list --author "@me" --state all --search "updated:>=$(date -u -v-36H '+%Y-%m-%dT%H:%M:%SZ')" --json title,body,state,url,number,createdAt,mergedAt --limit 50`

## Instructions

0. Determine the lookback window. Default is 36 hours. If the user specifies a custom timeframe (e.g. "last 80 hours", "last week", "since Monday"), calculate the appropriate UTC timestamp from the current date above and re-fetch PRs for that window. Otherwise, use the PR list from the context above.

1. For each PR with a Linear issue ID in the title (e.g. `SPE-123`), fetch issue details in parallel:
   ```
   linear issue view <ISSUE-ID>
   ```

2. Generate a standup for each PR. Format each PR as its own standalone block (not a list). Include the status next to the PR link. Separate each block with a blank line.

   ```
   **PR title** ([#N](url)) · Shipped
   *Problem:* what problem this solves and why it matters (from Linear context + PR description)
   *Solution:* what changed and how it solves the problem (from PR title + description)

   **PR title** ([#N](url)) · Open
   *Problem:* ...
   *Solution:* ...
   ```
   If no PRs, say "No PRs in the last <N> hours." (using the actual lookback window).

3. Do all of the above in a single message using parallel tool calls where possible.
