/-
  Examples and code from the Dependent Type Theory chapter
  of Theorem Proving in Lean
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
