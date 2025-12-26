# Getting Started with Lean Sandbox

Welcome! This guide will help you get started with the Lean Sandbox project.

## What is Lean?

[Lean](https://leanprover.github.io/) is a theorem prover and programming language that allows you to write mathematically rigorous proofs that are verified by the computer. It's used for:

- Formal verification of mathematical theorems
- Verified software development
- Teaching logic and proof techniques
- Research in type theory and foundations of mathematics

## Installation

### 1. Install Elan (Lean Version Manager)

**macOS/Linux:**
```bash
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
```

**Windows:**
Download and run the installer from [Elan releases](https://github.com/leanprover/elan/releases).

### 2. Clone and Build

```bash
git clone https://github.com/YOUR_USERNAME/lean-sandbox.git
cd lean-sandbox
lake build
```

## Your First Steps

### 1. Run the Demo

```bash
lake exe lean-sandbox
```

This will show you several verified theorems from the project.

### 2. Run the Tests

```bash
lake exe test
```

All tests should pass with green checkmarks ✓.

### 3. Open in VS Code

1. Install [VS Code](https://code.visualstudio.com/)
2. Install the [Lean 4 extension](https://marketplace.visualstudio.com/items?itemName=leanprover.lean4)
3. Open the project folder in VS Code
4. Open any `.lean` file - you'll see live verification!

## Understanding the Project Structure

```
LeanSandbox/
├── Basic.lean              # Start here! Simple theorems
├── Examples/
│   ├── Propositions.lean   # Logic proofs
│   ├── NaturalNumbers.lean # Number theory
│   └── Lists.lean          # List operations
├── Data/
│   └── Tree.lean           # Custom data structures
└── Tactics/
    └── Custom.lean         # Proof automation
```

## Your First Theorem

Let's write a simple theorem! Create a new file `LeanSandbox/Examples/MyFirst.lean`:

```lean
/-!
# My First Theorems

This is where I learn Lean!
-/

namespace MyFirst

/-- A simple function that adds 1 -/
def addOne (n : Nat) : Nat := n + 1

/-- ✓ Theorem: Adding 1 to n gives n + 1 -/
theorem addOne_works (n : Nat) : addOne n = n + 1 := by
  rfl  -- "reflexivity" - both sides are definitionally equal

/-- ✓ Theorem: Adding 1 twice gives n + 2 -/
theorem addOne_twice (n : Nat) : addOne (addOne n) = n + 2 := by
  simp [addOne]  -- simplify using the definition of addOne
  omega          -- omega tactic solves arithmetic

end MyFirst
```

Then add to `LeanSandbox.lean`:
```lean
import LeanSandbox.Examples.MyFirst
```

Build it:
```bash
lake build
```

If it compiles, congrats! You've written verified theorems! 🎉

## Key Lean Concepts

### Tactics

Tactics help build proofs. Common ones:

- `rfl` - Reflexivity (prove x = x)
- `simp` - Simplification
- `omega` - Arithmetic solver
- `intro` - Introduce hypothesis
- `exact` - Provide exact proof term
- `induction` - Proof by induction
- `cases` - Case analysis

### Types

Everything in Lean has a type:
- `Nat` - Natural numbers (0, 1, 2, ...)
- `Int` - Integers
- `Bool` - Booleans (true/false)
- `List α` - Lists of elements of type α
- `Prop` - Propositions (statements to prove)

### Theorems vs Definitions

- `def` - Define functions and values
- `theorem` - State and prove propositions
- They're actually the same in Lean, but `theorem` signals intent

## Next Steps

1. **Read the Examples**
   - Start with [LeanSandbox/Basic.lean](../LeanSandbox/Basic.lean)
   - Move to [LeanSandbox/Examples/Propositions.lean](../LeanSandbox/Examples/Propositions.lean)

2. **Modify Existing Theorems**
   - Try changing proofs
   - See what breaks and why
   - Learn by experimentation!

3. **Study Resources**
   - [Theorem Proving in Lean 4](https://leanprover.github.io/theorem_proving_in_lean4/)
   - [Functional Programming in Lean](https://leanprover.github.io/functional_programming_in_lean/)
   - [Lean Zulip Chat](https://leanprover.zulipchat.com/)

4. **Write Your Own Theorems**
   - Pick a simple mathematical statement
   - Try to prove it in Lean
   - Ask for help if stuck!

## Common Issues

### "Unknown identifier"
Make sure you've imported the module with `import LeanSandbox.YourModule`.

### "Type mismatch"
Check that your types line up. Lean is very strict about types!

### "Tactic failed"
The tactic couldn't finish the proof. Try a different approach or break it into steps.

### Build is slow
First build takes time. Subsequent builds are much faster. Use `lake clean` if you get strange errors.

## Getting Help

- **In-project**: Check existing examples for patterns
- **Lean Zulip**: [leanprover.zulipchat.com](https://leanprover.zulipchat.com/)
- **Lean documentation**: [leanprover.github.io](https://leanprover.github.io/)
- **This project's issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/lean-sandbox/issues)

## Tips for Success

1. **Start Small** - Prove simple things first
2. **Read Errors Carefully** - Lean's errors are helpful
3. **Use InfoView** - In VS Code, the InfoView shows proof state
4. **Experiment** - Try different tactics and approaches
5. **Learn from Examples** - Study existing proofs
6. **Be Patient** - Formal verification has a learning curve

## Congratulations!

You're now ready to explore formal verification with Lean! Remember: every mathematician started by proving 1 + 1 = 2. 😊

Happy proving! 🎓
