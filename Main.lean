import LeanSandbox

/-!
# Main Executable

Simple demo showing Lean sandbox is working.
-/

def main : IO Unit := do
  IO.println s!"Hello from {LeanSandbox.hello}!"
  IO.println s!"addTwo 2 = {LeanSandbox.addTwo 2}"
  IO.println "✓ All proofs verified!"
