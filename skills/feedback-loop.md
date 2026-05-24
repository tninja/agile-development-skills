---
name: feedback-loop
description: Harness-oriented coding workflow that establishes diagnostics and test baselines before editing, then continuously validates changes through tests, lint, diagnostics, and focused iteration loops.
trigger: When the user asks for safe iterative coding, harness engineering, continuous validation, regression prevention, diagnostics-first workflows, or automated build/test/fix loops.
---

# Feedback Loop Skill

Use this skill to keep AI-assisted code changes grounded in continuous verification.

The goal is not just generating code, but maintaining a reliable feedback loop:

- establish a baseline
- make a small change
- validate
- inspect failures
- iterate
- stop only when regressions are resolved

## Workflow

1. Establish baseline diagnostics before editing.
2. Detect the narrowest useful test command.
3. Make a small, focused change.
4. Run diagnostics and tests immediately.
5. Analyze failures before continuing.
6. Iterate until the requested behavior works without introducing regressions.
7. Summarize what changed and how it was verified.

## Baseline Collection

Before editing:

- Capture diagnostics from language tooling if available.
- Record existing failing tests separately from newly introduced failures.
- Identify the smallest reproducible validation command.
- Prefer narrow test scope first, broader validation later.

Examples:

- single unit test
- current file test
- package/module test
- lint/typecheck for touched files
- repository-wide verification only after local success

## Editing Strategy

- Prefer incremental edits over large rewrites.
- Re-run validation after each meaningful edit.
- Preserve unrelated behavior.
- Avoid mixing refactoring and feature work unless explicitly requested.

## Failure Analysis

When validation fails:

1. Identify which failure is newly introduced.
2. Read the exact error output carefully.
3. Trace the failure to the smallest relevant scope.
4. Explain the likely root cause.
5. Apply the smallest fix possible.
6. Re-run validation.

## Diagnostics-First Guidance

If diagnostics tooling is available:

- Record baseline diagnostics before editing.
- After each edit, compare diagnostics for touched files.
- Do not finish with newly introduced diagnostics.

## Output Requirements

At the end:

- List changed files.
- List validation commands executed.
- Summarize final validation status.
- Call out unresolved risks or assumptions.
