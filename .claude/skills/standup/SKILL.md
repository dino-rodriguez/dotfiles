---
name: standup
description: Generate a standup summary from your recent PRs, enriched with Linear issue context
disable-model-invocation: true
model: sonnet
allowed-tools: Bash(gh*), Bash(date*), Bash(linear*)
---

## Context

- Current date: !`date "+%Y-%m-%d %H:%M %Z"`
- 36 hours ago: !`date -u -v-36H "+%Y-%m-%dT%H:%M:%SZ"`
- GitHub username: !`gh api user --jq '.login'`

## Instructions

1. Fetch PRs from last 36h:
   ```
   gh pr list --author "@me" --state all --search "created:>=<36H_AGO_TIMESTAMP>" --json title,body,state,url,number --limit 50
   ```

2. For each PR with a Linear issue ID in the title (e.g. `SPE-123`), fetch issue details in parallel:
   ```
   linear issue view <ISSUE-ID>
   ```

3. Generate a standup grouped by status (Merged, Open, Draft). For each PR:
   - *Why:* from Linear context + PR description
   - *What:* from PR title + description
   - *Decision:* from PR description (only if meaningful, otherwise omit)

4. Format as:
   ```
   ### Merged
   - **PR title** ([#N](url))
     - *Why:* ...
     - *What:* ...
     - *Decision:* ... (only if applicable)
   ```
   Omit empty status groups. If no PRs, say "No PRs in the last 36 hours."

5. Do all of the above in a single message using parallel tool calls where possible.
