---
name: tdd
description: Test-Driven Development cycle guidance (Red-Green-Blue). Enforces strict TDD stages with clear constraints at each phase.
trigger: When the user asks to write tests first, follow TDD, implement a feature with tests, or mentions Red-Green-Blue/refactor cycle.
---

# TDD Skill

Guide development through Kent Beck's Test-Driven Development methodology with strict stage separation.

## TDD Stages

### Stage Selection

Offer these options when the user invokes TDD:

| Stage | Name | Purpose |
|-------|------|---------|
| 0 | Run Tests | Execute the test suite and report results |
| 1 | Red | Write the smallest failing test that captures requested behavior |
| 2 | Green | Write minimum source code to make the failing test pass |
| 3 | Blue | Refactor the code changed in Red/Green while preserving behavior |
| 4 | Red + Green | Combined: write failing test then make it pass (one prompt) |
| 5 | Red + Green + Blue | Full cycle: test, implement, refactor (one prompt) |

## Stage Instructions

### Red Stage (Write Failing Test)

```
{feature_description}
{file_context}

Follow TDD principles - write only the test now, not the implementation.
The test should fail when run because the functionality doesn't exist yet.
Only update test file code.
Run test after this stage and output the summary of test result.
State whether the result matches the goal of this stage.
List the files changed and exact test command / result.
List the public API / log key / config key change if there is.
Follow the test-code pattern in the current project.
Write the test-code in the test-file.
If the test-file does not exist, create it using the same test-filename pattern used in this repository.
```

### Green Stage (Make Test Pass)

```
{implementation_instruction}
{file_context}

Follow TDD principles - implement the code needed to make the test pass.
Run test after this stage and output the summary of test result.
State whether the result matches the goal of this stage.
List the files changed and exact test command / result.
List the public API / log key / config key change if there is.
```

### Blue Stage (Refactor)

Use the refactoring skill with TDD constraint:
- Only refactor files changed in Red/Green
- Preserve behavior and do not add features
- Review the code diff (including tests) and identify the highest-impact cleanup
- Apply focused refactoring: improve readability, keep classes/functions small and cohesive, reduce duplication, simplify naming and control flow
- Ensure all tests still pass after refactoring

### Red + Green (Combined)

```
{feature_description}
{file_context}

Follow strict TDD stages. Do not skip stages.
Stage 1 - Red: update only test code and write the smallest failing test
that captures the requested behavior. Do not modify source code during Red.
Stage 2 - Green: after confirming the new test fails for the expected reason,
update the minimum source code needed to make it pass. Do not refactor during Green.
Keep the changes narrowly scoped to the requested behavior.
Only update the relevant test and source code.
Do not add extra features or unrelated cleanup.
Run test after each stage and output the summary of test result.
For each stage, list the stage name, files changed, exact test command / result,
and whether the result matches the goal of that stage.
List the public API / log key / config key change if there is.
Follow the test-code pattern in the current project.
Write the test-code in the test-file.
If the test-file does not exist, create it using the same test-filename pattern used in this repository.
```

### Red + Green + Blue (Full Cycle)

Same as Red + Green, plus:

```
Stage 3 - Blue: after Green is passing, refactor only the files changed in Red/Green.
Preserve behavior and do not add features.
First review the code diff (including tests) and identify the highest-impact cleanup.
Then apply focused refactoring that improves readability, keeps classes/functions
small and cohesive / easy to test, reduces duplication, and simplifies naming and control flow.
```

## Context-Aware Behavior

### When cursor is in a source function (not test file)
- Red stage becomes "Write test for {function_name}" with appropriate test file hint
- Green stage pre-fills: "Implement function '{function_name}' to make tests pass"

### When in a test file with a failure
- Red stage becomes: "Fix the code to resolve the following error: {failure_info}"
- This handles the case where a test is already failing and needs implementation

### Test Pattern Detection
- Always follow the test-code pattern already established in the project
- Use the same test-filename pattern found in the repository
- Do not impose a specific test framework; detect from existing tests

## Run Tests

When asked to run tests:

```
Run the tests for {context} using appropriate test runner.

If any test fails:
1. Analyze the test failure output carefully to identify which test(s) failed
2. Investigate the root cause by examining the test code and related source files
3. Provide a clear explanation of what went wrong
4. Suggest specific code fixes for user approval before making any changes
```

Context is determined by:
- Current function name (if available)
- Current file (if in a file)
- Current directory (if in a file browser)

## Constraints

- Never skip stages in multi-stage mode
- Red: ONLY modify test files
- Green: ONLY modify source files (minimum changes)
- Blue: ONLY refactor files touched in Red/Green
- Always run tests after each stage
- Always report whether the result matches the stage goal
