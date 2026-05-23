---
name: legacy-code
description: Legacy code change workflow based on Working Effectively with Legacy Code. Use when modifying hard-to-test code, adding behavior safely, breaking dependencies, generating characterization tests, identifying seams, or applying Sprout, Wrap, Extract and Override, Sensing Variable, Null Object, or related legacy-code techniques.
---

# Legacy Code

Use this skill to make small, behavior-preserving progress in legacy code. Prefer characterization tests and dependency-breaking moves before changing behavior.

Use it when the user asks to change, test, refactor, understand, or make safe progress in legacy code, especially code with weak tests, hidden dependencies, global/static state, hard-coded construction, or high regression risk.

## Workflow

1. Identify the scope: selected region, current function, current class/module, or current file.
2. Clarify the goal: understand behavior, add behavior, enable tests, break a dependency, or find a safe change point.
3. Choose the smallest technique that creates leverage without broad rewrites.
4. Preserve current behavior unless the user explicitly asks for a behavior change.
5. Add or update characterization tests before risky changes when practical.
6. Run the narrowest relevant tests after each code change, then widen verification if shared behavior was touched.

## Context Phrases

Use these phrases when forming an instruction:

| Scope | Phrase |
| --- | --- |
| Selected region | `in the selected code` or `for the selected code` |
| Current function | `in function '<function_name>'` or `for function '<function_name>'` |
| Current file | `in the current file` or `for the current file` |

When code is provided inline, include it after the instruction in a fenced code block.

## Technique Selection

| Goal | Technique |
| --- | --- |
| Understand how behavior can be changed safely | Identify Seams |
| Lock down current behavior before editing | Generate Characterization Tests |
| Replace or isolate hard dependencies | Break Dependencies |
| Add new behavior with minimal edits to existing code | Sprout Method or Sprout Class |
| Add behavior around existing behavior | Wrap Method or Wrap Class |
| Observe hidden state during tests | Sensing Variable |
| Replace an untestable call site | Extract and Override Call |
| Replace direct field reads | Extract and Override Getter |
| Replace direct field writes | Extract and Override Setter |
| Replace hard-coded object construction | Extract and Override Factory Method |
| Control static state in tests | Introduce Static Setter |
| Make C/C++ static or direct functions replaceable | Replace Function with Function Pointer |
| Convert an awkward dependency passed as a parameter | Adapt Parameter |
| Make static calls overridable | Introduce Instance Delegator |
| Isolate global state | Encapsulate Global References |
| Remove repeated null checks | Introduce Null Object |
| Remove type or status conditionals | Replace Conditional with Polymorphism |
| Plan a feature safely | Analyze Change Points |

## Core Prompts

Use the prompt that matches the selected technique, then adapt names and placeholders to the target language and repository style.

### Identify Seams

Prompt:

```text
Identify seams <scope>. Look for places where behavior can be changed without editing the code directly. Consider preprocessing seams, link seams, and object seams.
```

### Generate Characterization Tests

Prompt:

```text
Write characterization tests <scope>. These tests should document the existing behavior without making judgments about correctness. Focus on capturing all current behaviors, including edge cases and error conditions.
```

### Break Dependencies

Prompt:

```text
Apply the '<technique>' technique <scope>. <technique_description>.
```

Dependency-breaking options:

| Technique | Description |
| --- | --- |
| Extract Interface | Create an interface from a class to separate usage from implementation. |
| Parameterize Constructor | Pass dependencies into a class rather than creating them internally. |
| Parameterize Method | Pass dependencies into a method rather than accessing them globally. |
| Subclass and Override Method | Create a testing subclass that overrides problematic methods. |
| Extract Method | Move code to a separate method to make it easier to override or mock. |
| Adapt Parameter | Use an adapter to convert between incompatible interfaces. |
| Break Out Method Object | Move a complex method to its own class to isolate dependencies. |
| Replace Global Reference with Getter | Add a getter method for global variables to allow overriding. |

### Sprout Method

Prompt:

```text
Apply the Sprout Method technique <scope> to add this functionality: <new_functionality>. Create a new method named '<method_name>' that implements this functionality with minimal changes to existing code.
```

### Wrap Method

Prompt:

```text
Apply the Wrap Method technique to '<method_to_wrap>'. <wrap_type>: <new_behavior>. Preserve the original method's behavior while adding the new functionality.
```

Wrap types:

- Before: add behavior before the method.
- After: add behavior after the method.
- Around: add behavior before and after the method.

### Sprout Class

Prompt:

```text
Apply the Sprout Class technique to create a new class named '<class_name>' that implements this functionality: <new_functionality>. Design the class to work with the existing code with minimal changes to the original code.
```

### Wrap Class

Prompt:

```text
Apply the Wrap Class technique to create a wrapper class named '<wrapper_class_name>' for the original class '<original_class>'. The wrapper should add this behavior: <new_behavior>. Use delegation to preserve the original class's behavior while adding the new functionality.
```

### Sensing Variable

Prompt:

```text
Apply the Sensing Variable technique to expose the variable '<variable_name>' <scope> for testing purposes. Add the minimal code needed to make this internal state visible during tests without changing the normal behavior of the code.
```

### Extract and Override Call

Prompt:

```text
Apply the Extract and Override Call technique <scope> to extract the call to '<call_to_extract>' into a new method named '<new_method_name>'. This will allow the call to be overridden in a testing subclass.
```

### Extract and Override Getter

Prompt:

```text
Apply the Extract and Override Getter technique <scope> to extract access to the field '<field_name>' into a getter method named '<getter_name>'. Replace all direct field access with calls to this getter method.
```

Default getter name: `get<FieldName>`.

### Extract and Override Setter

Prompt:

```text
Apply the Extract and Override Setter technique <scope> to extract modification of the field '<field_name>' into a setter method named '<setter_name>'. Replace all direct field modifications with calls to this setter method. This allows overriding the setter in tests.
```

Default setter name: `set<FieldName>`.

### Extract and Override Factory Method

Prompt:

```text
Apply the Extract and Override Factory Method technique <scope>. Extract the creation logic '<creation_call>' into a new protected or virtual method named '<factory_method_name>'. Replace the original creation call with a call to this new factory method. This allows subclasses to override the factory method for testing.
```

Default factory method name: `create<ClassName>`.

### Introduce Static Setter

Prompt:

```text
Apply the Introduce Static Setter technique to class '<class_name>' for the static member '<static_variable>'. Add a static setter method named '<setter_name>' with test-only visibility if possible in the language. The setter should allow replacing or setting the static dependency during tests.
```

Default static setter name: `set<StaticVariable>ForTesting`.

### Replace Function with Function Pointer

Prompt:

```text
Apply the Replace Function with Function Pointer technique to make '<function_to_replace>' testable. Replace the direct function with a function pointer that can be changed during tests.
```

Use this primarily for C or C++ code where direct/static functions block tests.

### Adapt Parameter

Prompt:

```text
Apply the Adapt Parameter technique <scope> to create an adapter named '<adapter_name>' for the parameter '<parameter_name>'. This will allow the dependency to be replaced during testing.
```

### Introduce Instance Delegator

Prompt:

```text
Apply the Introduce Instance Delegator technique to convert the static method '<static_method>' in class '<class_name>' to an instance method. This will make the code more testable by allowing the method to be overridden in subclasses.
```

### Encapsulate Global References

Prompt:

```text
Apply the Encapsulate Global References technique. Create a new class or structure named '<encapsulating_class>' to encapsulate the following global references: <globals_list>. Replace direct access to these globals with access through an instance of the new class or structure. Provide a way to inject or replace this instance for testing.
```

### Introduce Null Object

Prompt:

```text
Apply the Introduce Null Object pattern for the class '<class_name>'. Create a Null Object class named '<null_object_class_name>' that implements the same interface as '<class_name>' but provides default do-nothing behavior. Modify the code to use an instance of '<null_object_class_name>' instead of null or nil checks where appropriate.
```

Default null object class name: `Null<ClassName>`.

### Replace Conditional with Polymorphism

Prompt:

```text
Apply the Replace Conditional with Polymorphism refactoring <scope>. Identify the conditional logic related to '<conditional_description>'. Introduce a class hierarchy or use existing polymorphism to replace the conditional checks with polymorphic method calls. Define the necessary interface or base class and subclasses.
```

### Analyze Change Points

Prompt:

```text
Analyze change points <scope> to safely implement this feature: <feature_description>. Identify areas where changes can be made with minimal risk, considering: 1. Where are the natural seams? 2. Which areas have tests? 3. Which dependencies need to be broken? 4. What refactoring techniques would be most appropriate?
```

## Execution Guardrails

- Keep edits narrow and reversible.
- Prefer adding a new method, wrapper, adapter, or test harness over rewriting legacy logic.
- Do not "clean up" unrelated code while applying a legacy-code technique.
- When adding tests, characterize existing behavior first; mark suspected bugs as observations unless the user asks to fix them.
- If a dependency-breaking change alters a public API, call it out explicitly and provide a migration path.
- If no technique fits cleanly, stop after analysis and propose the smallest next step.
