import LeanSandbox

/-!
# Test/Scratch File

Use this file to experiment and test ideas as you learn Lean.
This is your scratch space - feel free to modify or delete anything here!
-/

-- Try things out here!

#check LeanSandbox.hello
#check LeanSandbox.addTwo

-- Evaluate expressions
#eval LeanSandbox.addTwo 5

-- Test your own definitions here

-- Main function for executable
def main : IO Unit := do
  IO.println "Test executable - scratch space for experiments"
  IO.println s!"hello = {LeanSandbox.hello}"
  IO.println s!"addTwo 5 = {LeanSandbox.addTwo 5}"
