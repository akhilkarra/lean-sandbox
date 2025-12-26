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
