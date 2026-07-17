---
name: jj-review
description: Critical code review of a jj commit, focused on correctness, maintainability, and consistency with the codebase. Use when the user asks to review a jj commit/change or invokes /jj-review. Not for GitHub PRs (use /review) or the uncommitted working diff (use /code-review). Args: a jj revision (default @-) and optionally a mode (report / fix-critical / fix).
---

# jj Code Review

Critically review a local jj commit. Think critically — the goal is to find real problems, not to validate the change.

## Arguments

- **Revision**: any jj revset (default `@-`).
- **Mode** (default `report`):
  - `report` — only report findings, change nothing.
  - `fix-critical` — implement Critical findings directly, report the rest.
  - `fix` — implement all findings that are part of the change, report the rest.

## Process

1. Inspect the change: `jj show <rev> --git` (use `jj log` for surrounding context if needed).
2. Read the touched files in full, plus enough of the surrounding codebase to judge consistency.
3. Review, in particular concerning:
   - **Correctness** — bugs, edge cases, error handling, concurrency.
   - **Maintainability** — clarity, naming, structure, tests.
   - **Consistency with the rest of the codebase** — patterns, idioms, conventions. Suggesting changes elsewhere in the codebase is allowed but must be well justified.

## Reporting

Clearly mark each finding by severity:

- **Critical** — bugs, data loss, security issues.
- **Major** — likely problems or significant maintainability concerns.
- **Minor** — style, polish, nitpicks.

For each finding: file:line, what's wrong, why it matters, suggested fix. If the change is sound, say so briefly — don't invent findings.

## Fixing (fix / fix-critical modes)

- Never implement findings unrelated to the reviewed change — those are always report-only, regardless of mode.
- Apply fixes to the reviewed revision (`jj edit <rev>` or edit files and `jj squash` as appropriate), following the pre-commit workflow (tests, lint, format).
- After fixing, report what was fixed and what remains as findings.
