---
name: derive-ddd-document
description: Derive a Domain-Driven Design document from an existing codebase, architecture notes, tests, APIs, schemas, or other project context. Use when the user wants a DDD-oriented document, bounded context map, ubiquitous language, aggregate model, domain events, commands, policies, repositories, or a domain model summary written to a target file.
trigger: When the user asks to derive, generate, update, or write a DDD document from project context, code, tests, database schemas, API contracts, issue notes, or a user-provided target file.
---

# Derive DDD Document Skill

Derive a practical Domain-Driven Design document from evidence in the project. The target document file may be provided by the user; if not, propose a conventional path such as `docs/domain-driven-design.md` before writing.

## Workflow

1. Confirm the target file path if the user provided one; otherwise use the repository's existing docs convention or ask only when no safe default exists.
2. Gather evidence from code, tests, schemas, APIs, documentation, package boundaries, route names, service names, and user-provided notes.
3. Identify domain language from names that appear repeatedly in production code and tests.
4. Separate observed facts from inferred design intent.
5. Draft or update the DDD document with concise, evidence-backed sections.
6. Preserve existing document content where possible; merge updates instead of overwriting unrelated sections.
7. After editing, report changed files, unresolved assumptions, and the verification command used.

## Evidence Collection

Prefer local repository evidence over speculation. Search for:

- Domain nouns in model, entity, service, command, event, handler, controller, route, migration, schema, fixture, and test names.
- Module boundaries, package boundaries, API route groups, database schemas, and external integration names.
- State transitions, lifecycle methods, status enums, validation rules, and authorization checks.
- Domain events, message topics, queue names, webhook payloads, audit records, and notification flows.
- Existing docs such as `README.md`, `docs/`, `ARCHITECTURE.md`, ADRs, OpenAPI specs, GraphQL schemas, and migration files.

If evidence conflicts, document the conflict instead of forcing a single interpretation.

## Document Structure

Use this structure unless the repository already has a DDD document style:

```markdown
# Domain-Driven Design

## Purpose

## Domain Overview

## Ubiquitous Language

| Term | Meaning | Evidence |
| --- | --- | --- |

## Bounded Contexts

| Context | Responsibility | Key Concepts | Collaborators |
| --- | --- | --- | --- |

## Aggregates and Entities

| Aggregate | Root | Entities / Value Objects | Invariants |
| --- | --- | --- | --- |

## Domain Events

| Event | Trigger | Consumers | Notes |
| --- | --- | --- | --- |

## Commands and Use Cases

| Command / Use Case | Actor | Aggregate / Context | Outcome |
| --- | --- | --- | --- |

## Policies and Invariants

## Repositories and Persistence

## Integrations

## Open Questions
```

Omit empty sections if the available evidence does not support them, but keep `Open Questions` when assumptions remain.

## Derivation Rules

- Use domain terms from the codebase; do not invent business vocabulary unless clearly marked as an inference.
- Treat tests as strong evidence for behavior and invariants.
- Treat database tables and API resources as clues, not automatically as aggregates.
- Keep aggregates small and define them around consistency boundaries.
- Put technical implementation details in supporting notes unless they explain a domain boundary.
- Mark uncertainty with `Inferred:` or list it under `Open Questions`.
- Include file paths, symbol names, or test names in the `Evidence` column when helpful.
- Do not claim DDD concepts that are not visible in the current context.

## Update Strategy

When the target file already exists:

1. Read the whole file first.
2. Preserve user-authored wording unless it is contradicted by stronger current evidence.
3. Add new sections only when they improve navigability.
4. Update tables in place rather than duplicating equivalent sections.
5. Keep unresolved decisions under `Open Questions`.

## Prompt Template

Use this instruction when deriving the document:

```text
Derive a Domain-Driven Design document from the current project context and write it to <target_file>.

Use repository evidence from code, tests, schemas, APIs, and existing documentation. Identify bounded contexts, ubiquitous language, aggregates, entities, value objects, domain events, commands/use cases, policies, repositories, integrations, and open questions.

Separate observed facts from inferences. Preserve existing content in <target_file> when updating it. Keep the document concise, useful for engineers, and grounded in concrete file or symbol evidence.
```

## Output Requirements

- The final document must be in English.
- The document should be useful to engineers who need to change the system.
- The document should explain domain boundaries and behavior, not only list files.
- The final response should mention the target file and any important assumptions.
