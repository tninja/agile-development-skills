# agile development agent skills

Portable AI coding agent skills for agile engineering practices: **refactoring**, **TDD**, **code review / PR workflows**, **legacy-code change techniques**, and **DDD documentation**.

These skills are extracted from [ai-code-interface.el](https://github.com/tninja/ai-code-interface.el) and `aider-legacy-code.el`, then adapted for AI coding CLIs and agents such as Claude Code, Codex CLI, Gemini CLI, GitHub Copilot CLI, and similar tools — no Emacs required.

[Agile development](https://en.wikipedia.org/wiki/Agile_software_development) is an iterative approach to building software that emphasizes short feedback loops, working software, collaboration, and the ability to respond to change. Core practices commonly include [test-driven development](https://en.wikipedia.org/wiki/Test-driven_development), [continuous refactoring](https://en.wikipedia.org/wiki/Code_refactoring), [frequent code review](https://en.wikipedia.org/wiki/Code_review), [incremental delivery](https://en.wikipedia.org/wiki/Iterative_and_incremental_development), and close coordination between developers and stakeholders.

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| [refactoring](skills/refactoring.md) | `/refactoring` | 60+ refactoring techniques from Martin Fowler's catalog with parameterized instructions |
| [tdd](skills/tdd.md) | `/tdd` | Red-Green-Blue TDD cycle with strict stage separation and test-pattern detection |
| [code-review](skills/code-review.md) | `/code-review` | PR review, creation, issue investigation, CI check analysis, merge conflict resolution |
| [legacy-code](skills/legacy-code.md) | `/legacy-code` | Working Effectively with Legacy Code techniques for characterization tests, seams, dependency breaking, Sprout, Wrap, and Extract and Override workflows |
| [derive-ddd-document](skills/derive-ddd-document.md) | `/derive-ddd-document` | Derive a Domain-Driven Design document from code, tests, schemas, APIs, and other project context |
| [follow-up-suggestions](skills/follow-up-suggestions.md) | `/follow-up-suggestions` | Auto suggest AI-actionable follow-up questions/tasks, allowing user to trigger them by number |

## Installation

In your coding agent CLI session, just ask it to install skills with following prompt

Please read the README of https://github.com/tninja/agile-development-skills and install/setup the skills described there for "Your Coding Agent". Follow the installation instructions in the README.

You Coding Agent could be: Claude Code, Codex CLI, Github Copilot CLI, Gemini CLI, etc

## Uninstall

In your coding agent CLI session, just ask it to uninstall it

Please read the README of https://github.com/tninja/agile-development-skills and uninstall/remove the skills described there for "Your Coding Agent". Follow the repository instructions to remove any installed skill files and cleanup related configuration.

## Data Files

- `data/refactoring-catalog.json` — Structured catalog of 60+ refactoring techniques with names, scopes, descriptions, and parameter definitions. Referenced by the refactoring skill.

## Usage Examples

### Refactoring

```
/refactoring
> Select: Extract Method
> Method name: calculateTotalPrice
```

Or let the AI suggest:
```
/refactoring
> Select: Suggest Refactoring Strategy
> Goal: Reduce complexity
```

### TDD

```
/tdd
> Select stage: Red + Green + Blue (One prompt)
> Feature: Add validation for email format in UserService
```

### Code Review

```
/code-review
> Mode: Review the PR
> URL: https://github.com/org/repo/pull/123
```

Or create a PR:
```
/code-review
> Mode: Send PR for current branch
> Target: main
```

### Legacy Code

```
/legacy-code
> Goal: Add behavior safely to this hard-to-test module
> Technique: Analyze Change Points, then Generate Characterization Tests
```

### Derive DDD Document

```
/derive-ddd-document
> Target file: docs/domain-driven-design.md
> Context: Derive the document from the current codebase, tests, schemas, and APIs
```

### Follow Up Suggestions

```
/follow-up-suggestions
> This will enable auto-suggestion of next steps. Just reply with 1, 2, 3, etc. to trigger a suggestion.
```

## License

Apache-2.0
