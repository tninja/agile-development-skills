---
name: value-driven-simplification
description: Human-led discussion to decide which code complexity is worth keeping. Investigates a branch diff or a repository topic, asks one high-value question at a time about business value, and lets the user decide what to keep, simplify, or delete. Never edits code on its own.
trigger: When the user asks whether code is worth keeping, wants to simplify a branch before merging, questions the value of a feature or abstraction, or wants to challenge complexity against business value.
---

# Value-driven Simplification Skill

AI makes code generation cheap, which makes it easy to accept features, abstractions, and extra code without sufficiently considering their business value. Even correct, well-tested code may have little value while creating years of maintenance cost. This skill helps developers reassess complexity after AI code generation and in established codebases.

Its guiding principle is **human-led value judgment**: the user understands the business context and decides what to preserve, simplify, defer, or remove. The AI gathers evidence, surfaces trade-offs, and asks challenging questions — it does not make those choices on the user's behalf.

## Scopes

Ask the user which scope to analyze:

### 1. Current Branch

- Determine the current branch and a base ref. Suggest the remote default branch (`origin/HEAD`, else `main`/`master`) and let the user confirm or override it. Refuse an empty or nonexistent base.
- Compute the merge-base of the base and HEAD. Inspect committed changes from the merge-base to HEAD, including relevant tests.
- Ask explicitly whether to include uncommitted changes (staged, unstaged, and relevant untracked files). Be explicit in the analysis about which are included.
- If uncommitted changes are excluded, read the committed HEAD version of affected files rather than the working copy, so the analysis respects that choice.
- Optionally narrow the discussion to a user-provided topic.

### 2. Repository Topic

- Ask the user for a topic (e.g. config merge). Refuse to run a repository-wide analysis with no topic.
- Incrementally locate the relevant implementation, callers, tests, and documented constraints.
- Discuss legacy complexity without assuming an unfamiliar design is unnecessary.
- Avoid dumping the whole repository into context: start with a bounded investigation and expand as the conversation requires.

## Discussion Workflow

1. **Gather evidence.** Briefly explain the feature or topic, relevant code, dependencies, tests, likely core paths, and identifiable sources of complexity. Distinguish established facts from guesses about business intent. Identify affected core paths and behavior that may need protection. Do not paste a large diff or dump the whole repository into the response.

2. **Ask, don't prescribe.** In a grill-me style conversation, raise **ONE high-value question at a time** about actual business value, essential behavior, historical constraints, and consequences of changes. Ask the user which parts are worth keeping and how they would simplify the rest. Do not begin by generating a long refactoring plan. Wait for the user's answer.

3. **Challenge and refine the user's proposal.** Use concrete code evidence to identify overlooked dependencies, invariants, operational risks, or cases where deleting code could increase complexity or risk. Invite the user to revise the proposal; don't substitute the AI's business-value judgment for theirs.

4. **Only after the user's direction,** help turn the chosen simplification into **one small, independently verifiable next step**, including tests or characterization of essential behavior, blast-radius considerations, and rollback options when relevant. Continue discussing if the user is not ready to act.

## Principles

- Aim for the **least complexity needed to reliably deliver the value the user identifies**, not the fewest lines of code.
- Distinguish core business paths from optional or experimental features. Prefer isolating non-core behavior when appropriate, without introducing needless abstractions or duplicating core logic.
- Treat uncertainty about historical requirements as a reason to ask, not a reason to delete.
- A simplification may change externally visible behavior; unlike behavior-preserving refactoring, such changes require explicit user approval.
- **Discussion first:** no automatic edits, deletion, or feature removal based on the initial analysis. Do not edit code, remove behavior, or run mutating commands without explicit user approval.

## Usage Examples

### Simplify a branch before merging

```
/value-driven-simplification
> Scope: Current Branch
> Base: origin/main (confirmed)
> Include uncommitted changes: no
> Topic (optional): retry logic
```

The skill inspects the branch diff from the merge-base, identifies the consequential complexity with file/line evidence, then asks one question at a time — e.g. "Is the retry backoff strategy load-bearing for the checkout path, or could the simpler fixed-delay version carry the same value?" You decide what stays.

### Challenge an old abstraction

```
/value-driven-simplification
> Scope: Repository Topic
> Topic: config merge
```

The skill incrementally locates the config-merge implementation, its callers, tests, and documented constraints, then grills you on which behavior is essential before proposing any simplification step.
