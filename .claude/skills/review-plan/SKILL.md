---
name: review-plan
description: Critically review an implementation plan (or proposed change) for correctness, testing, performance, and architecture before any code is written. Use when asked to "review the plan", review a design/approach, or sanity-check a plan file before implementing.
---

Review the plan against the real codebase, not its own prose. The deliverable is the review: verdicts, findings with `file:line` evidence, and the plan file updated in place. If there is no plan file, deliver the review in the response instead. Then stop. Do not call ExitPlanMode and do not reopen decisions the plan marks as locked.

## Scope first

State the minimal change that closes the ticket. If the plan is bigger than that, it is the first finding. Smells found nearby get one line as an optional follow-up, never a place in the plan.

## Verification rule

Every claim the plan depends on gets one of three treatments. Say which.

- **Read**: claims about code (a helper exists, a field is nullable, a caller passes X). Open the file. Explore-agent summaries are hypotheses, not evidence.
- **Run**: claims about behavior or data (a query is fast, a fixture supports X, prod rows look like Y, an existing test passes). Run it now: the scoped test, EXPLAIN on dev, a remote-shell count, a curl. Dev is fair game.
- **Defer**: claims only checkable once code exists. Write the check into the plan with the exact command, what is measured, and the pass threshold.

A load-bearing claim with none of the three is a finding.

## Dimensions

Verdict per dimension: ready / fix / blocker. Ready means implement as written; a dimension with only deferred checks outstanding is still ready. Fix means named changes are required and the plan is re-run after them. Blocker means the approach is wrong.

A finding earns a fix or blocker verdict only if it would cause a bug, a failing test, a measurable perf regression, or a new abstraction where an existing one fits. Taste, polish, and optional hardening are not findings.

**Correctness.** Wired end to end (caller -> service -> model, or FE prop -> consumer -> API). Types, nullability, enum membership, and route/string literals match reality. Every consumer of a changed function is listed, not just the obvious caller. Hunt for the edit that silently breaks an assumption: a mock that drops the prop being asserted, an already-applied migration, a parallel code path left unfixed.

**Architecture.** For each new helper, service, model, component, or hook, name the existing abstraction it should extend, or state why none fits. Build on what exists. Prefer the smallest change that matches how the sibling feature is built. No rearchitecting or rewriting unless the ticket requires it. Respect project guardrails (logic in services, no narration comments).

**Performance.** Read every query the change adds or triggers: index use, projection, N+1, eager loading, transaction length, no `select_for_update` on hot models. Frontend: requests on mount, payload size, render thrash. Where the answer depends on data shape or volume, Run (EXPLAIN ANALYZE on dev or prod) or Defer with a measurement and threshold. "Should be fine" is a finding.

**Testing.** Tests assert behavior, not that inputs were passed through. Existing fixtures, mocks, and helpers support the new assertions, or the plan widens them first. New service code has DB-free unit tests (diff-cover gates on the unit job). The plan names the exact scoped test command, the type-check, and one manual check in the running app. Reuse suite helpers and conventions; avoid mock-heavy tests.

## Method

1. Identify the plan and the files it touches. Read them, the sibling pattern it mirrors, and the existing tests. Explore agents for breadth; targeted reads for anything load-bearing.
2. Apply the verification rule to each claim. Run what can be run.
3. Render verdicts with `file:line` evidence and a concrete fix for each finding.
4. Update the plan file in place: fixes, deferred checks, and a numbered "Review notes" pass. Keep earlier passes.

## Reruns

This skill is run repeatedly until every dimension is ready. Each pass first confirms the previous pass's findings are resolved, then looks only for something that would change a verdict. Do not restate resolved findings, do not swap one acceptable approach for another, and do not add improvements a ready verdict does not need. When all four dimensions are ready, say so in one line and stop.

## Output

- Verdict per dimension, then the single highest-risk item.
- Findings with `file:line`, each paired with a fix.
- What was verified by running, with results, and what was deferred into the plan.
- Recommend rather than ask, unless the decision is genuinely the user's.
