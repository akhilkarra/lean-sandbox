/-!
# Basic Lean Examples

A minimal starting point for learning Lean 4.
Add your own definitions and proofs here as you work through the documentation!

## Resources to Learn From
- **TPiL** (Theorem Proving in Lean 4): https://lean-lang.org/theorem_proving_in_lean4/
- **MiL** (Mathematics in Lean): https://leanprover-community.github.io/mathematics_in_lean/
- **FPiL** (Functional Programming in Lean): https://lean-lang.org/functional_programming_in_lean/
-/

namespace LeanSandbox

/-! ## Simple Examples to Get Started -/

/-- A simple greeting -/
def hello : String := "Lean 4"

/-- Basic function -/
def addTwo (n : Nat) : Nat := n + 2

/-! ## Simple Proofs -/

/-- Things equal themselves (reflexivity) -/
example : 2 + 2 = 4 := rfl

/-- Using built-in simplification -/
example (n : Nat) : n + 0 = n := by simp

/-- Using rewrite with a theorem -/
example : 3 + 5 = 5 + 3 := by
  rw [Nat.add_comm]

/-!
## Your Learning Space

Write your own definitions, functions, and proofs below as you learn!
Delete these examples once you understand the basics.
-/

-- Try: Define your own function


-- Try: Prove a simple property


end LeanSandbox
