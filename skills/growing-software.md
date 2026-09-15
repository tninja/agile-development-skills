---
name: growing-software
description: Grow a larger software idea one human-verifiable, value-delivering slice at a time. Chooses only the next smallest valuable capability from current evidence instead of producing a speculative full roadmap.
trigger: When the user asks to grow or evolve a larger feature incrementally, wants the next smallest valuable step, mentions Growing Object-Oriented Software Guided by Tests / walking skeleton / vertical slice, or wants to avoid a large big-bang AI implementation.
---

# Growing Software Skill

Grow software at the speed humans can understand and validate, not at the speed an AI can generate code.

This skill is inspired by the *growing* style of development associated with *Growing Object-Oriented Software, Guided by Tests*: start from working behavior, add one useful capability, get feedback, and let the next design decision be informed by what was just learned.

The goal is **not** to decompose the entire vision into a complete implementation plan. The goal is to decide **one next grow step** that delivers real value, is small enough to verify confidently, and teaches us something useful about what should come next.

## Core Principle

> Do not plan farther than the evidence justifies.

A large vision is useful as direction, but future steps are hypotheses. Each completed grow step changes what we know about the problem, the design, and the real value of later ideas.

Prefer:

```text
vision
  -> smallest valuable working slice
  -> verify
  -> learn
  -> choose the next slice from new evidence
```

Over:

```text
vision
  -> detailed architecture
  -> complete task breakdown
  -> implement all tasks
  -> verify at the end
```

## Hard Constraints

1. **Choose exactly ONE next grow step.** Do not output a full roadmap or enumerate future implementation phases.
2. **Do not implement by default.** First propose the next grow step and let the user discuss, refine, record, or explicitly ask to implement it.
3. **The step must deliver observable value.** Prefer a thin end-to-end capability over a horizontal technical layer.
4. **The step must be human-verifiable.** A developer should be able to understand the change and determine whether it works without reviewing a large speculative implementation.
5. **Keep the system working.** The result should leave the software in a useful, testable state rather than halfway through a larger architecture.
6. **Define scope boundaries explicitly.** State what tempting adjacent work is intentionally excluded.
7. **Use evidence from the current system.** Inspect existing code, tests, documentation, behavior, and previous results before deciding what should grow next.
8. **Prefer learning over speculation.** When uncertainty is high, choose a step that cheaply answers an important design or product question.
9. **Avoid premature abstractions.** Do not add frameworks, generalized extension points, or infrastructure unless the current grow requires them.
10. **Re-plan after every grow.** Never assume the next step chosen today remains correct after the current step is completed.

## Workflow

### 1. Understand the Vision

Capture the larger outcome in one or two sentences. The vision is a direction, not a contract for a predetermined architecture.

Ask only when essential information is missing. Otherwise infer the vision from the user's task and current repository context.

### 2. Inspect the Current Capability

Before proposing the next step, determine what the software can **demonstrably do now**.

Inspect relevant:
- production code
- tests and test results
- user-facing behavior or CLI/API behavior
- design/task documents
- recent changes when useful
- known limitations or failure cases supplied by the user

Distinguish existing behavior from planned or assumed behavior.

### 3. Identify What Has Actually Been Proven

Summarize the evidence supporting the current capability. Examples:
- a test demonstrates the behavior
- a real example was manually verified
- an API call produces the expected result
- an existing production path exercises the behavior
- a previous grow step established a design assumption

Do not treat generated code, an implementation plan, or an unexecuted test as proof.

### 4. Find the Next Valuable Uncertainty or Capability Gap

Look for a small gap where closing it would produce one or more of:
- new user-visible or developer-visible value
- an end-to-end usable path
- evidence about an important design assumption
- reduction of a major product or technical uncertainty
- support for a real example that currently fails

Avoid choosing work merely because it is architecturally convenient.

### 5. Choose ONE Smallest Valuable Grow

Select the smallest step that changes what a user, operator, developer, or calling system can meaningfully accomplish.

Prefer vertical slices such as:

```text
input -> real path through the system -> useful observable result
```

Avoid horizontal slices such as:

```text
build data layer -> build service layer -> build abstraction layer -> integrate later
```

A grow does not need to be end-user UI. A debugging capability, deterministic diagnostic, new API behavior, migration safety check, or operational signal can be valuable when it enables a real task that was not possible before.

### 6. Define Verification Before Implementation

State how we will know this grow is correct before writing the implementation.

Use the lightest credible evidence appropriate to the change:
- an acceptance test
- a focused unit/integration test
- a real known example
- a reproducible command and expected output
- comparison against known production behavior

When code implementation starts, use the `tdd` skill when appropriate for Red-Green-Blue execution. This skill decides **what should grow next**; TDD governs **how to implement that behavior safely**.

### 7. Define the Learning Goal

Every grow should answer a question, even when the primary purpose is feature value.

Examples:
- Is the available metadata sufficient for deterministic diagnosis?
- Does one end-to-end path expose the integration boundary we actually need?
- Do users need an explanation or only the raw evidence?
- Is this dependency stable enough to build the next capability on it?

The learning goal matters because the next grow must be chosen from what this step teaches us.

## Selection Heuristics

When several possible next steps exist, prefer the one with the best combination of:

1. **Value** — makes a real task newly possible or meaningfully better
2. **Verifiability** — correctness can be demonstrated clearly
3. **Learning** — reduces important uncertainty
4. **Small scope** — a human can maintain a reliable mental model of the change
5. **Reversibility** — avoids locking the design into an unproven direction
6. **End-to-end shape** — exercises real boundaries instead of building isolated infrastructure

Risk can justify choosing a step earlier when validating it cheaply prevents large speculative work later.

## Greenfield Guidance

If there is no working implementation yet, choose a **walking skeleton** as the first grow: the thinnest real path through the important system boundaries that produces a useful observable result.

The walking skeleton should be deliberately small. Do not use "walking skeleton" as justification to scaffold the complete future architecture.

For example, for a debugging assistant, a first grow might be:

```text
Given one real entity ID -> retrieve one authoritative signal -> print one useful diagnosis
```

not:

```text
Build plugin framework + data adapters + LLM orchestration + UI + generalized workflow engine
```

## Existing-System Guidance

For an existing system, preserve current behavior and grow from a real current capability. Prefer one real unsupported case over broad architectural preparation for many hypothetical cases.

When the current code is hard to test safely, use the `legacy-code` skill to establish characterization tests or seams before implementing the grow.

## Output Format

Keep the proposal concise enough to review. Use this structure:

```markdown
## Vision
The larger outcome, in 1-2 sentences.

## Current Capability
What the system demonstrably does today.

## Evidence
What has actually been verified.

## Next Grow
Exactly ONE smallest valuable capability to add.

## Value
What becomes possible after this grow that is not possible today.

## Scope Boundary
What this grow intentionally will NOT include.

## Verification
How we will prove the grow works.

## Learning Goal
What this grow should teach us before choosing another step.
```

If useful, add a short **Why this step now** explanation. Do not turn it into a future roadmap.

End by asking whether the user wants to:
- discuss/refine this grow step,
- record it in the relevant design/task document, or
- implement it.

Do not edit the design/task file or code until the user chooses one of those actions, unless the user explicitly requested the skill to do so in the original prompt.

## Anti-Patterns

### Full upfront decomposition

Bad:

```text
Phase 1: data layer
Phase 2: service layer
Phase 3: agent layer
Phase 4: UI
Phase 5: observability
...
```

This creates confidence without evidence and encourages the agent to run far ahead of human validation.

### Small tasks that do not deliver value

Breaking a 10,000-line implementation into 100 tiny coding tasks is not necessarily growing software. If all tasks merely construct pieces of a predetermined architecture and value appears only at the end, the feedback loop is still too long.

### AI-generated scope expansion

Do not add "while we are here" improvements, generalized frameworks, extra configuration, unrelated cleanup, or future-facing extension points.

### Treating passing tests as the only feedback

Tests are powerful evidence, but a perfectly tested feature can still solve the wrong problem. Include real behavior or user/operator verification when the grow's value depends on it.

### Predetermining the next grow

Do not write "after this, implement X" as a commitment. After verification, inspect what was learned and choose again.

## Relationship to Other Skills

```text
larger vision
    |
    v
[growing-software]  -- choose ONE next valuable behavior
    |
    v
[tdd]               -- implement it safely when appropriate
    |
    v
verification + human judgment
    |
    v
[growing-software]  -- choose again from new evidence
```

Use `legacy-code` first when safe change requires characterization tests or dependency seams. Use `refactoring` after behavior is working when design cleanup is justified by current code rather than speculative future needs.

## Guiding Question

At every iteration ask:

> Given what the software can prove today, what is the smallest valuable thing we can make true next?
