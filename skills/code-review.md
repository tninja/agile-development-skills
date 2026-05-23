---
name: code-review
description: Code review, PR creation, PR review, issue investigation, CI check analysis, and merge conflict resolution workflows.
trigger: When the user asks to review code, create/review a PR, investigate an issue, check CI failures, resolve merge conflicts, or explain code changes.
---

# Code Review Skill

Structured workflows for code review, pull request management, and GitHub issue investigation.

## Workflow Modes

| Mode | Purpose |
|------|---------|
| Review PR | Full code review of a pull request |
| Check unresolved feedback | Find and analyze unresolved review comments |
| Prepare PR description | Generate a PR description from code changes |
| Send PR for current branch | Create a new PR from the current working branch |
| Investigate issue | Analyze a GitHub issue and suggest fixes |
| Review CI checks | Analyze failing CI/CD checks |
| Explain code change | Explain what a PR or diff does at a high level |
| Resolve merge conflict | Analyze and suggest resolution for merge conflicts |
| Review diff file | Review a local .diff file against requirements |

## PR Review

```
Review pull request: {pr_url}

Use {tool} to fetch pull request details and review comments.

Review Steps:
1. Requirement Fit: Verify the PR implementation against requirements.
2. Code Quality: Check code quality, security, and performance concerns.
3. Findings: For each issue include location, issue, fix suggestion, and priority.

Provide an overall assessment at the end.
```

## Unresolved Feedback Check

```
Check unresolved feedback for pull request: {pr_url}

Use {tool} to fetch pull request details and review comments.

Feedback Check Steps:
1. Find unresolved feedback or unresolved review comments in this PR.
2. For each unresolved feedback, explain whether it makes sense and why.
3. If a feedback does not make sense, explain why it may not be necessary.
4. No need to make code change. Provide analysis only.
```

## PR Description Preparation

```
Prepare a pull request description for: {pr_url}

Use {tool} to fetch pull request details.

PR Description Steps:
1. Add a summary of the problem and the approach taken in the PR.
2. Highlight the most important code changes and user-visible impact.
3. Add a testing section with relevant verification details.
4. Format the result as a concise PR description ready to share with reviewers,
   written in the voice of the author or maintainer.
```

## Create PR for Current Branch

```
Create a pull request from branch {current_branch} into {target_branch}.

Use {tool} to create the pull request.

PR Creation Steps:
1. Inspect the current branch changes and open a pull request into {target_branch}.
2. {title_instruction}
3. Write a concise PR description that sounds like it was written by the author,
   but do not make it too short.
4. Keep the description focused on the problem, the approach, and the most important
   verification, with enough detail for reviewers to understand the change quickly.
5. Aim for a compact but complete description, roughly a short summary plus 2 to 3
   brief supporting paragraphs or bullet points.
6. Return the final PR URL, the exact PR title, and the exact description that were used.
```

### Target Branch Resolution

Determine the default target branch in this priority order:
1. Upstream tracking branch (if different from current)
2. Remote default branch (`origin/HEAD`)
3. `main` (if exists)
4. `master` (if exists)

## Issue Investigation

```
Investigate issue: {issue_url}

Use {tool} to inspect the GitHub issue and relevant repository context.

Issue Investigation Steps:
1. Understand the issue description, reproduction details, and expected behavior.
2. Analyze relevant code in this repository as context and identify likely root causes.
3. Provide concrete insights on how to fix it, including likely files or areas to change.
4. No need to make code change. Provide analysis only.
```

## CI Check Review

```
Review GitHub CI checks for pull request: {pr_url}

Use {tool} to fetch pull request details and CI checks.

CI Checks Review Steps:
1. Review the GitHub CI checks for this pull request.
2. If there is a failing or error state, inspect the failing checks and relevant details.
3. Analyze the likely root cause of each failure.
4. No need to make code change. Provide analysis only.
```

## Explain Code Change

Explain what a code change does at multiple levels of detail:

- **PR level**: Summarize the overall change, motivation, and impact
- **File level**: Explain changes in each modified file
- **Function level**: Explain specific function modifications

The explanation should be accessible to reviewers unfamiliar with the specific area of code.

## Merge Conflict Resolution

```
Resolve merge conflict for pull request: {pr_url}

Use {tool} to fetch pull request branch details and merge status.

Merge Conflict Resolution Steps:
1. Identify the current working branch and the target branch from the PR.
2. Verify the current working branch matches the PR source branch.
3. Update the local target branch to the latest remote version.
4. Attempt to merge the target branch into the current working branch.
5. If there are merge conflicts, analyze each conflict and provide detailed
   instructions on how to resolve them, including which files to change and how.
6. Do not make code changes. Provide analysis and resolution suggestions only.
7. If there are no merge conflicts, report that the merge would succeed.
```

## Diff File Review

When reviewing a local `.diff` file:

```
Code review for {diff_file_name}. Use relevant file in repository as context.

Review Steps:
1. Requirement Fit (Top Priority): Verify if the code change fulfills the requirement.
   Identify gaps or missing implementations.
2. Code Quality: Check for quality, security, performance, and coding patterns.
3. Issues Found: For each issue: Location, Issue, Solution, Priority (High/Medium/Low)

Provide overall assessment.

Requirement: {user_specified_requirement}
```

## Git Blame Analysis

Analyze code history for deeper understanding:

```
Analyze the Git commit history for this code:

File: {file_path}
Lines: {start}-{end}
{selected_code}

Commit history information:
{blame_output}

Analysis:
1. Code evolution patterns and timeline
2. Key changes and their purpose
3. Potential design decisions and thought processes
4. Possible refactoring or improvement opportunities
5. Insights about code architecture or design
```

## Tool Selection

This skill works with multiple tools for GitHub interaction:
- **GitHub MCP server**: Direct API access via MCP tools
- **gh CLI**: GitHub CLI commands (`gh pr`, `gh issue`)
- **Local git**: For diff generation and blame analysis

Choose based on what's available in the current environment.

## Review Checklist

Before approving any code:
- [ ] Code is readable and well-named
- [ ] Functions are focused (<50 lines)
- [ ] Files are cohesive (<800 lines)
- [ ] No deep nesting (>4 levels)
- [ ] Errors are handled explicitly
- [ ] No hardcoded secrets or credentials
- [ ] No debug statements left behind
- [ ] Tests exist for new functionality
- [ ] Security concerns addressed (input validation, auth, injection)
- [ ] Performance considerations (N+1 queries, unbounded operations)
