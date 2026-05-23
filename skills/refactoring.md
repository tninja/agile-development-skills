---
name: refactoring
description: Guided code refactoring using 60+ techniques from Martin Fowler's catalog. Suggests or applies specific refactoring patterns with parameterized instructions.
trigger: When the user asks to refactor code, improve code structure, reduce complexity, or mentions a specific refactoring technique name.
---

# Refactoring Skill

Apply structured refactoring techniques from Martin Fowler's "Refactoring" catalog. This skill helps choose the right technique and generates precise, parameterized instructions.

## Workflow

1. **Assess context**: Identify the code scope (selected region, function, file, or directory)
2. **Choose technique**: Either let the user pick from the catalog, or analyze and suggest the best technique
3. **Parameterize**: Resolve placeholders (method names, variable names, target classes) from context
4. **Execute**: Apply the refactoring with clear constraints (do not change logic, preserve behavior)

## When to Suggest Refactoring

Use this skill when you detect:
- Duplicated code across methods/classes
- Long methods (>50 lines) or large classes
- Deep nesting (>4 levels)
- Feature envy (method uses another class's data more than its own)
- Shotgun surgery (one change requires edits in many places)
- Primitive obsession (using primitives instead of small objects)

## Refactoring Strategy Presets

When the user doesn't name a specific technique, offer one of these analysis modes:

| Goal | Instruction |
|------|-------------|
| General refactoring analysis | Analyze the code. Identify potential refactoring opportunities (complexity, duplication, clarity) and make the code easy to understand. Do not change code logic. Suggest the most impactful refactoring technique and explain why. |
| Improve readability and testability | Focus on making the code easier to understand, improving readability, and increasing testability. Do not change code logic. |
| Reduce complexity | Focus on reducing complexity and simplifying control flow. Do not change code logic. |
| Remove duplication | Focus on removing duplication and consolidating repeated logic. Do not change code logic. |
| Clarify naming and responsibilities | Focus on clarifying naming and separating responsibilities more cleanly. Do not change code logic. |

## Technique Catalog

The full catalog is in `data/refactoring-catalog.json`. Each technique has:
- **name**: Human-readable technique name
- **scopes**: Where it applies (`region` for selected code, `global` for whole file/class)
- **description**: Parameterized instruction template with `[PLACEHOLDER]` tokens
- **parameters**: Optional list of placeholders to resolve from user input or context

### Composing Methods
- Extract Method
- Inline Method
- Inline Temp
- Replace Temp with Query
- Introduce Explaining Variable
- Split Temporary Variable
- Remove Assignments to Parameters
- Replace Method with Method Object
- Substitute Algorithm

### Moving Features Between Objects
- Move Method
- Move Field
- Extract Class
- Inline Class
- Hide Delegate
- Remove Middle Man
- Introduce Foreign Method
- Introduce Local Extension

### Organizing Data
- Self Encapsulate Field
- Replace Data Value with Object
- Change Value to Reference
- Change Reference to Value
- Replace Array with Object
- Duplicate Observed Data
- Change Unidirectional Association to Bidirectional
- Change Bidirectional Association to Unidirectional
- Encapsulate Field
- Encapsulate Collection
- Replace Type Code with Class
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy
- Replace Subclass with Fields

### Simplifying Conditional Expressions
- Decompose Conditional
- Consolidate Conditional Expression
- Consolidate Duplicate Conditional Fragments
- Remove Control Flag
- Replace Nested Conditional with Guard Clauses
- Introduce Null Object
- Introduce Assertion

### Making Method Calls Simpler
- Rename Variable/Method
- Add Parameter
- Remove Parameter
- Separate Query from Modifier
- Parameterize Method
- Replace Parameter with Explicit Methods
- Preserve Whole Object
- Replace Parameter with Method
- Introduce Parameter Object
- Remove Setting Method
- Hide Method
- Replace Constructor with Factory Method
- Replace Error Code with Exception
- Replace Exception with Test

### Dealing with Generalization
- Pull Up Field / Method / Constructor Body
- Push Down Method / Field
- Extract Subclass / Superclass / Interface
- Collapse Hierarchy
- Form Template Method
- Replace Inheritance with Delegation
- Replace Delegation with Inheritance

### Big Refactorings
- Tease Apart Inheritance
- Convert Procedural Design to Objects
- Separate Domain from Presentation
- Extract Hierarchy

### IDE-Style Refactorings
- Extract Variable
- Extract Parameter
- Extract Field
- Introduce Constant
- Introduce Field
- Introduce Property
- Safe Delete
- Convert Anonymous Class to Lambda
- Change Method Signature
- Replace Magic Number with Symbolic Constant

## Applying a Technique

When a specific technique is selected:

1. Load the technique from the catalog
2. For each parameter placeholder:
   - Use context (current function name, symbol at cursor) as default
   - Ask the user to confirm or override
   - If left empty, let the AI decide the best value
3. Substitute resolved values into the description template
4. Clean up: remove prepositions ("to", "named", "with") before empty placeholders
5. Format the final instruction: `{Technique Name} {context}. {Resolved Description}. Go ahead and make the code change.`

## Constraints

- Do not change code logic during refactoring
- Preserve all existing behavior
- If in TDD mode, ensure all tests still pass after refactoring
- After refactoring, suggest running the test suite to verify behavior preservation
