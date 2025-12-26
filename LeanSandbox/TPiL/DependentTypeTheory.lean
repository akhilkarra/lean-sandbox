/-
  Examples and code from the Dependent Type
  Theory chapter of Theorem Proving in Lean
-/


namespace SimpleTypeTheory
  /- Define some constants -/
  def m : Nat := 1
  def n : Nat := 0
  def b1 : Bool := true
  def b2 : Bool := false

  /- Check their types -/
  #check m
  #check n
  #check n + 0
  #check m * (n + 0)
  #check b1
  #check b1 && b2
  #check b1 || b2
  #check true

  #check Nat → Nat -- write using slash 'to' or 'r'
  #check Nat -> Nat -- can write both ways

  #check Nat × Nat  -- Product type: use slash 'times'
  #check Prod Nat Nat  -- Same thing, different notation
  #check Nat → Nat → Nat
  #check Nat → (Nat → Nat) -- Right associative
  #check (Nat → Nat) → Nat

  #check Nat.succ
  #check (0, 1)
  #check Nat.add

  #check (5, 1).1
  #eval (5, 1).1
  #check (5, 1).2
  #eval (5, 1).2

  /- Evaluate -/
  #eval 5 * 4
  #eval m + 2
  #eval b1 && b2
end SimpleTypeTheory

namespace TypesAsObjects
  def α : Type := Nat
  def β : Type := Bool
  def F : Type → Type := List
  def G : Type → Type → Type := Prod

  #check α
  #check F α
  #check F Nat
  #check G α
  #check G α β
  #check G α Nat
  #check α × β
  #check Nat × Nat
  #check List α
  #check List Nat

  #check Type
  #check Type 1
  #check Type 2
  #check Type 3
  /-
    Lean has an infinite hierarchy of types.
    What does this mean?

    Type 0 can be thought of as a universe of
    small or "ordinary" types. Type 1 is a
    larger universe containing Type 0, Type 2
    an even larger one containing Type 1, and
    so on infinitely.
  -/

  #check List   -- notice how LEAN deals with polymorphism

  /- How to define polymorphism ourselves -/
  /- Option 1: use universe keyword -/
  universe u
  def H (α : Type u) : Type u := Prod α α
  #check H
  /- Option 2: specify universe parameters -/
  def J.{v} (α : Type v) : Type v := Prod α α
  #check J
end TypesAsObjects

namespace FunctionAbstractionAndEvaluation
  /-
    We use the fun or λ keyword to create a
    function from an expression.

    These keywords are aliases.

    Either type => or ↦ using slash `ma`
  -/
  #check fun (x : Nat) ↦ x + 5
  #check λ (x : Nat) => x + 5
  -- I like fun and ↦ personally.
  -- Like with SML/NJ, we have type inference
  #check fun x ↦ x + 5
  #eval (fun x ↦ x + 5) 10
  #check fun x y ↦ if not y then x + 1 else x + 2
  #check fun α β γ (f : α → β) (g : β → γ) x ↦ g (f x)
end FunctionAbstractionAndEvaluation

namespace Definitions
  def double (x : Nat) := x + x
  #eval double 3
  def doubleFun := fun x : Nat ↦ x + x
  #eval doubleFun 3
  def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) := g (f x)
  def square (x : Nat) : Nat := x * x
  #eval compose Nat Nat Nat double square 3
end Definitions

namespace LocalDefinitions
  #check let y := 2 + 2; y * y
  #eval let y:= 2 + 2; y * y
  def twiceDouble (x : Nat) : Nat :=
    let y := x + x  -- No need of ; with newlines
    y * y
  #eval twiceDouble 2
  def foo :=
    let a := Nat
    fun x : a ↦ x + 2
  -- def bar := (fun a ↦ fun x : a ↦ x + 2) Nat
  /-
    foo works but bar doesn't.

    This is because bar's lambda declaration
    needs to type check to make sense but it does
    not. In contrast, the let expression acts as
    an imperative substitution declaration,
    allowing Lean to make sense of the function
    declaration.
  -/
end LocalDefinitions
