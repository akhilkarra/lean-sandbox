# Lean 4 Quick Reference Cheat Sheet

## Essential Commands

```bash
# Build and verify all proofs
lake build

# Run the executable
lake exe lean-sandbox

# Clean build artifacts
lake clean

# Update dependencies
lake update

# Create new file
touch LeanSandbox/MyFile.lean
```

## Lean Syntax Essentials

### Definitions

```lean
-- Function definition
def functionName (param : Type) : ReturnType := body

-- Example
def double (n : Nat) : Nat := n + n

-- With type inference (less clear, avoid for learning)
def double n := n + n
```

### Theorems

```lean
-- Theorem statement
theorem name (params) : statement := proof

-- Direct proof
theorem add_zero (n : Nat) : n + 0 = n := Nat.add_zero n

-- Tactic proof
theorem add_comm (n m : Nat) : n + m = m + n := by
  rw [Nat.add_comm]
```

### Common Tactics

```lean
-- Reflexivity (things equal themselves)
rfl

-- Simplify using definitions
simp

-- Rewrite using a theorem
rw [theorem_name]

-- Introduce hypothesis
intro h

-- Case analysis
cases h

-- Induction
induction n

-- Apply a function/theorem
apply theorem_name

-- Exact proof term
exact proof_term

-- Placeholder (compile but not proven)
sorry
```

### Documentation

```lean
/-!
# Module-level doc
Markdown supported
-/

/-- Single-line doc for definitions -/
def myDef := ...

/-! ## Section header -/
```

### Special Commands

```lean
-- Check the type of something
#check Nat.add

-- Evaluate an expression
#eval 2 + 2

-- Print definition
#print Nat.add

-- Check if something is a Prop or Type
#check (2 = 2)  -- Prop (a statement to prove)
#check Nat      -- Type (a type of values)
```

## Project Structure Patterns

### Creating a New Module

1. Create file: `LeanSandbox/Chapter2.lean`
2. Add to `LeanSandbox.lean`:
   ```lean
   import LeanSandbox.Basic
   import LeanSandbox.Chapter2
   ```
3. Build: `lake build`

### File Template

```lean
/-!
# Module Title

Brief description of what this module contains.
-/

namespace MyModule

/-! ## Section Title -/

/-- Documentation for this definition -/
def myDefinition : Type := implementation

/-- Documentation for this theorem -/
theorem myTheorem : statement := proof

end MyModule
```

## Common Patterns

### Proof by Cases

```lean
theorem example (p q : Prop) : p ∨ q → q ∨ p := by
  intro h
  cases h with
  | inl hp => exact Or.inr hp
  | inr hq => exact Or.inl hq
```

### Proof by Induction

```lean
theorem example (n : Nat) : property n := by
  induction n with
  | zero => 
    -- Base case: prove for 0
    sorry
  | succ n ih =>
    -- Inductive case: prove for n+1
    -- ih is the inductive hypothesis
    sorry
```

### Using Have

```lean
theorem example : ... := by
  have helper : SomeType := proof_of_helper
  -- Now use helper in the main proof
  exact use_helper helper
```

## Type Basics

```lean
-- Basic types
Nat          -- Natural numbers (0, 1, 2, ...)
Int          -- Integers (..., -1, 0, 1, ...)
Bool         -- true, false
String       -- "text"
List α       -- List of elements of type α

-- Function types
Nat → Nat                  -- Function from Nat to Nat
Nat → Nat → Nat           -- Function taking 2 Nats
(n : Nat) → Vec α n       -- Dependent function

-- Propositions (things to prove)
n = m        -- Equality
n < m        -- Less than
P ∧ Q        -- And
P ∨ Q        -- Or
P → Q        -- Implies
¬P           -- Not
∀ x, P x     -- For all
∃ x, P x     -- There exists
```

## Logical Symbols (How to Type)

```
→   \to   or  \r        (implies)
∀   \all  or  \forall   (for all)
∃   \ex   or  \exists   (exists)
∧   \and                (and)
∨   \or                 (or)
¬   \not  or  \neg      (not)
↔   \iff                (if and only if)
≠   \ne                 (not equal)
≤   \le                 (less or equal)
≥   \ge                 (greater or equal)
⟨⟩  \< \>               (angle brackets for constructors)
```

## VS Code Shortcuts

```
Ctrl/Cmd + Space       Autocomplete
Ctrl/Cmd + Click       Go to definition
Hover                  See type and docs
Ctrl/Cmd + Shift + P   Command palette
  → "Lean 4: Restart Server"
Alt + Enter            Apply suggestions
```

## Debugging Workflow

1. **See the error** - Hover over red squiggle
2. **Simplify** - Comment out code to isolate issue
3. **Inspect** - Use `#check` and `#eval`
4. **Break down** - Add intermediate `have` steps
5. **Restart** - Restart Lean server if stuck

## Git Workflow

```bash
# Create feature branch
git checkout -b my-feature

# Make changes and commit
git add LeanSandbox/MyFile.lean
git commit -m "Add: description of changes"

# Push and create PR
git push origin my-feature
gh pr create

# CI will run automatically
# Merge when green ✓
```

## Common Errors and Fixes

### "unknown identifier"
- Check spelling
- Add import statement
- Check namespace

### "type mismatch"
- Use `#check` to see actual type
- May need type coercion
- Check parentheses

### "tactic failed"
- The tactic doesn't apply
- Try different tactic
- May need intermediate steps

### "unsolved goals"
- Proof not complete
- Use `sorry` to see remaining goals
- Work through goals one by one

## Learning Resources Quick Links

- **TPiL**: https://lean-lang.org/theorem_proving_in_lean4/
- **MiL**: https://leanprover-community.github.io/mathematics_in_lean/
- **FPiL**: https://lean-lang.org/functional_programming_in_lean/
- **Docs**: https://lean-lang.org/lean4/doc/
- **Chat**: https://leanprover.zulipchat.com/

## Remember

**If `lake build` succeeds → All theorems are proven correct!**

No unit tests needed for proofs. The type checker is the verifier.

---

*Keep this file handy while learning!*
