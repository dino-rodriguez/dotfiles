---
name: send-it
description: Implement changes and ship a PR with Copilot review. Use when the user says "send it", "ship it", "implement and PR", or wants the full implement-verify-ship pipeline. Accepts a Linear issue ID (e.g. SPE-1234) for context.
disable-model-invocation: true
---

## Workflow

1. **Gather context.** If a Linear issue ID (e.g. `SPE-1234`) is included in the arguments, fetch the issue for context:
   ```bash
   linear issue view SPE-1234
   ```
   Then explore the relevant areas of the codebase to understand what needs to change. Use the issue description, acceptance criteria, and codebase exploration to build a clear understanding of the requirements and architecture before implementing.

2. **Implement** the requested changes. Keep it simple — match existing patterns in the codebase. Include appropriate unit and integration tests for new or changed behavior.
3. **Self-review** your diff for correctness, performance, and test coverage.
4. **Run tests** using `/test` if available, otherwise run relevant tests directly.
5. **Update docs** using `/docs` if available, otherwise update relevant docs directly.
6. **Ship** using `/commit-push-pr`. Do NOT use `--draft`.
7. **Set variables** for the rest of the workflow:
   ```bash
   OWNER=$(gh repo view --json owner --jq '.owner.login')
   REPO=$(gh repo view --json name --jq '.name')
   PR_NUMBER=$(gh pr view --json number --jq '.number')
   ```

8. **Confirm Copilot is assigned.** Copilot auto-requests itself via repo settings. Verify it appears in requested reviewers:
   ```bash
   gh api repos/$OWNER/$REPO/pulls/$PR_NUMBER/requested_reviewers \
     --jq '[.users[] | select(.login == "Copilot")] | length'
   ```
   This returns 1 when Copilot is assigned and reviewing. It returns 0 once Copilot has submitted its review.

9. **Poll until CI and Copilot review are both done.** Check every 30 seconds, max 20 attempts (~10 min ceiling). If still not done after 20 attempts, stop and report what's still pending.
   ```bash
   # CI: returns 0 when all checks complete (excluding integration-test which is slow)
   gh pr view $PR_NUMBER --json statusCheckRollup \
     --jq '[.statusCheckRollup[] | select(.name != "integration-test" and .status != "COMPLETED")] | unique_by(.name) | length'

   # Copilot: returns 1+ when review is submitted
   # Note: reviews use "copilot-pull-request-reviewer[bot]", inline comments use "Copilot"
   gh api repos/$OWNER/$REPO/pulls/$PR_NUMBER/reviews \
     --jq '[.[] | select(.user.login == "copilot-pull-request-reviewer[bot]")] | length'
   ```

10. **Check results.** If CI passes and Copilot has no comments, you're done — report the PR URL.

   Otherwise, gather failures and comments:
   ```bash
   # List failing checks
   gh pr checks $PR_NUMBER || true

   # Get failure logs (extract run ID from the link column above)
   RUN_ID=$(gh pr checks $PR_NUMBER --json 'name,link' \
     --jq '.[] | select(.name == "<FAILING_CHECK>") | .link | split("/") | .[-3]')
   gh run view $RUN_ID --log-failed | tail -80

   # Get Copilot comments (include id for replying)
   # Note: inline comments use login "Copilot"; line can be null for multiline suggestions
   gh api repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments \
     --jq '.[] | select(.user.login == "Copilot") | {id, body, path, line: (.line // .original_line)}'
   ```

   For each finding, decide: **fix** (real bug, security issue, CI breakage) or **skip** (noise, stylistic, false positive). Fix all actionable issues, then push using `/commit-push`.

11. **Reply to each Copilot comment** with the decision and rationale:
    ```bash
    gh api repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments \
      -X POST -f body="<reply>" -F in_reply_to=<COMMENT_ID>
    ```
    For fixed issues, briefly say what was changed. For skipped issues, explain why (false positive, not applicable, etc.). Keep replies short — one or two sentences.

12. **Re-request Copilot review** after pushing fixes so it reviews the updated code:
    ```bash
    gh api repos/$OWNER/$REPO/pulls/$PR_NUMBER/requested_reviewers \
      -X POST -f 'reviewers[]=copilot-pull-request-reviewer[bot]'
    ```
    Repeat steps 9-11 exactly one more time (second and final pass). After that, re-request Copilot, report the PR URL, and continue to step 13.

13. **Send Slack notification.** Use the current user's Slack ID from the `slack_send_message` tool description (it includes the logged-in user's ID), then notify via webhook:
    ```bash
    PR_URL=$(gh pr view --json url --jq '.url')
    PR_TITLE=$(gh pr view --json title --jq '.title')
    SLACK_USER_ID="<user_id from MCP context>"
    printf '{"text":"<@%s> PR ready for review: <%s|%s>"}' "$SLACK_USER_ID" "$PR_URL" "$PR_TITLE" \
      | curl -s -X POST -H 'Content-type: application/json' -d @- \
      "$SLACK_WEBHOOK_URL"
    ```
