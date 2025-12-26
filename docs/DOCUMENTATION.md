# Documentation Guide

This guide explains how to document your Lean code effectively in this project.

## Module Documentation

Every `.lean` file should start with module documentation using `/-! ... -/`:

```lean
/-!
# Module Title

Brief description of what this module contains.

## Main definitions
- `definition1`: What it does
- `definition2`: What it does

## Main theorems
- `theorem1`: What it proves
- `theorem2`: What it proves

## Examples
```lean
-- Example usage
example : 1 + 1 = 2 := rfl
```

## References
- [Relevant paper or book]
- [Related module]
-/
```

## Definition Documentation

Document all public definitions with `/-- ... -/`:

```lean
/-- 
A function that adds two natural numbers.

This is the standard addition on natural numbers, defined recursively.
-/
def add (n m : Nat) : Nat := n + m
```

## Theorem Documentation

Theorems should be documented with their statement and meaning:

```lean
/-- 
✓ Theorem: Addition is commutative.

For any natural numbers `n` and `m`, we have `n + m = m + n`.

This is a fundamental property of addition.
-/
theorem add_comm (n m : Nat) : n + m = m + n := by
  omega
```

### The ✓ Symbol

Use ✓ to indicate a verified theorem:
- ✓ means the theorem is fully proven
- ⚠ means the theorem has `sorry` or is incomplete
- ✗ means the theorem is known to be false or has issues

## Inline Comments

Use `--` for inline comments explaining proof steps:

```lean
theorem example_theorem (n : Nat) : n + 0 = n := by
  -- Base case: reflexivity handles this
  rfl
```

## Complex Proofs

For complex proofs, explain the strategy:

```lean
/--
✓ Theorem: Reverse of reverse is identity.

**Proof strategy:**
1. Induction on the list
2. Base case: empty list trivially satisfied
3. Inductive case: use properties of reverse and append

**Key lemmas used:**
- `reverse_append`: reverse (xs ++ ys) = reverse ys ++ reverse xs
- Inductive hypothesis
-/
theorem reverse_reverse {α : Type} (xs : List α) :
    reverse (reverse xs) = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    simp [reverse_cons]
    rw [reverse_append, ih]
    rfl
```

## Type Documentation

Document types with their invariants:

```lean
/--
Binary tree data structure.

A tree is either:
- `empty`: The empty tree
- `node v left right`: A node containing value `v` with subtrees `left` and `right`

**Invariants:**
- For a binary search tree, left.values < v < right.values
- No duplicate values (for BST)
-/
inductive Tree (α : Type) where
  | empty : Tree α
  | node : α → Tree α → Tree α → Tree α
```

## Documentation Best Practices

### DO:
- ✓ Write clear, concise descriptions
- ✓ Explain why, not just what
- ✓ Include examples for complex functions
- ✓ Document preconditions and postconditions
- ✓ Link to related definitions/theorems
- ✓ Use proper mathematical notation
- ✓ Keep documentation up-to-date with code

### DON'T:
- ✗ State the obvious ("this function adds" for `def add`)
- ✗ Leave public APIs undocumented
- ✗ Use vague descriptions
- ✗ Forget to update docs when code changes
- ✗ Over-comment trivial proofs
- ✗ Use inconsistent formatting

## Special Sections

### Deprecated Features

```lean
/--
**DEPRECATED**: Use `newFunction` instead.

This function is kept for backwards compatibility but will be removed in v2.0.
-/
def oldFunction : Nat := 42
```

### Unsafe Code

```lean
/--
**UNSAFE**: This function uses `sorry` and is not verified.

This is a placeholder for future implementation.
-/
theorem unverified_claim : False := by
  sorry
```

### Performance Notes

```lean
/--
Compute factorial of n.

**Time complexity**: O(n)
**Space complexity**: O(n) due to recursion

For large n, consider using iterative version.
-/
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n
```

## Documentation in Different Files

### In Main.lean
Explain the purpose of the executable and how to use it.

### In Test.lean
Explain what is being tested and why.

### In lakefile.toml
Add comments explaining non-obvious configuration:

```toml
# We enable precompileModules for faster metaprogramming
# This increases build time but improves IDE responsiveness
precompileModules = true
```

## Generating Documentation

While Lean doesn't have built-in documentation generation like doc-gen4 by default, you can:

1. Keep a `docs/` directory with markdown files
2. Reference source code with clear file links
3. Maintain API documentation in README.md
4. Use comments that could be extracted by future tools

## Example: Well-Documented Module

See [LeanSandbox/Examples/Propositions.lean](../LeanSandbox/Examples/Propositions.lean) for a complete example of well-documented code.

## Checking Documentation

Before submitting a PR:
1. All public definitions have `/-- ... -/` comments
2. All files have `/-! ... -/` module docs
3. Complex proofs have explanation
4. Examples are provided where helpful
5. Documentation is accurate and up-to-date

## Questions?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more information on contributing documentation.
