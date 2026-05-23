# agile development agent skills

Portable AI coding agent skills for agile engineering practices: **refactoring**, **TDD**, and **code review / PR workflows**.

These skills are extracted from [ai-code-interface.el](https://github.com/tninja/ai-code-interface.el) and can be adapted for AI coding CLIs and agents such as Claude Code, Codex CLI, Gemini CLI, GitHub Copilot CLI, and similar tools — no Emacs required.

[Agile development](https://en.wikipedia.org/wiki/Agile_software_development) is an iterative approach to building software that emphasizes short feedback loops, working software, collaboration, and the ability to respond to change. Core practices commonly include [test-driven development](https://en.wikipedia.org/wiki/Test-driven_development), [continuous refactoring](https://en.wikipedia.org/wiki/Code_refactoring), [frequent code review](https://en.wikipedia.org/wiki/Code_review), [incremental delivery](https://en.wikipedia.org/wiki/Iterative_and_incremental_development), and close coordination between developers and stakeholders.

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| [refactoring](skills/refactoring.md) | `/refactoring` | 60+ refactoring techniques from Martin Fowler's catalog with parameterized instructions |
| [tdd](skills/tdd.md) | `/tdd` | Red-Green-Blue TDD cycle with strict stage separation and test-pattern detection |
| [code-review](skills/code-review.md) | `/code-review` | PR review, creation, issue investigation, CI check analysis, merge conflict resolution |

## Installation

### Claude Code Quick Install

`install.sh` is a Claude Code installer. For other AI coding CLIs and agents, use the manual prompt workflow guidance below.

```bash
./install.sh
```

### Claude Code Manual Install

Copy individual skills to your Claude Code skills directory:

```bash
# All three skills
cp skills/*.md ~/.claude/skills/

# Or pick what you need
cp skills/refactoring.md ~/.claude/skills/
cp skills/tdd.md ~/.claude/skills/
cp skills/code-review.md ~/.claude/skills/
```

### Claude Code Project-Level Install

To make skills available only in a specific project:

```bash
cp skills/*.md /path/to/your/project/.claude/skills/
```

### Other AI Coding CLIs

For other AI coding CLIs and agents, use the files in `skills/` as reusable prompt workflows. Copy the relevant skill content into your tool's custom instruction, prompt, slash-command, or project rules system, and keep the linked data files available when a skill references them. The provided installer does not configure these tools automatically.

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

## License

Apache-2.0
