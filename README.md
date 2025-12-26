# Lean 4 Sandbox

A minimal sandbox project for learning Lean 4 formal verification and functional programming.

## What is This?

This is a clean workspace for working through Lean 4 documentation and experimenting with formal proofs. It follows software engineering best practices (CI/CD, documentation, proper project structure) while keeping the examples minimal so you can learn at your own pace.

## Key Concept: No Separate Tests Needed!

**In Lean, if your code compiles, your proofs are verified.** The Lean type checker IS the verifier. When you prove a theorem and it type-checks successfully, that proof is mathematically verified. No unit tests needed!

## Learning Resources

Work through these in order:

1. **[Theorem Proving in Lean 4 (TPiL)](https://lean-lang.org/theorem_proving_in_lean4/)** - Start here to learn proof basics
2. **[Mathematics in Lean (MiL)](https://leanprover-community.github.io/mathematics_in_lean/)** - Apply Lean to mathematical reasoning  
3. **[Functional Programming in Lean (FPiL)](https://lean-lang.org/functional_programming_in_lean/)** - Use Lean as a programming language

## Project Structure

```
lean-sandbox/
├── LeanSandbox/
│   └── Basic.lean          # Start here - simple examples and your workspace
├── LeanSandbox.lean        # Module root (imports your files)
├── Main.lean               # Executable demo
├── Test.lean               # Scratch file for experiments
├── lakefile.toml           # Project configuration
└── README.md               # This file
```

## Quick Start

### Prerequisites

- Install [Lean 4](https://lean-lang.org/lean4/doc/quickstart.html)
- Recommended: [VS Code](https://code.visualstudio.com/) with the [Lean 4 extension](https://marketplace.visualstudio.com/items?itemName=leanprover.lean4)

### Build and Run

```bash
# Build the project (verifies all proofs!)
lake build

# Run the executable
lake exe lean-sandbox

# Clean build artifacts
lake clean
```

### Development Workflow

1. **Edit `LeanSandbox/Basic.lean`** - This is your main workspace
2. **Use `Test.lean`** - Scratch file for quick experiments
3. **Build frequently** - `lake build` verifies everything is correct
4. **Watch for errors** - The VS Code extension shows them inline

## How to Learn

### Step 1: Start with TPiL

Open [LeanSandbox/Basic.lean](LeanSandbox/Basic.lean) and work through [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/).

Try the examples in the book by adding them to `Basic.lean`. When the file compiles with no errors (green checkmark in VS Code), your proofs are verified!

### Step 2: Create New Modules

As you progress, organize your work:

```bash
# Create a new module for a chapter/topic
touch LeanSandbox/Chapter2.lean
```

Then add it to `LeanSandbox.lean`:
```lean
import LeanSandbox.Basic
import LeanSandbox.Chapter2  -- Your new module
```

### Step 3: Experiment

Use `Test.lean` for quick experiments and the `#check` and `#eval` commands to explore.

## Continuous Integration

GitHub Actions automatically verifies all proofs on every push:
- ✓ Builds the project
- ✓ Runs the executable  
- ✓ Checks for errors

See [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

## Understanding Verification

### Traditional Testing vs. Lean

**Traditional Code:**
```python
def add(a, b):
    return a + b

# Need tests to verify behavior
assert add(2, 3) == 5
assert add(0, 5) == 5
# ...infinite cases to test
```

**Lean:**
```lean
def add (n m : Nat) : Nat := n + m

-- Proof for ALL natural numbers, verified by type checker
theorem add_comm (n m : Nat) : add n m = add m n := by
  simp [add]
  rw [Nat.add_comm]
-- If this compiles, it's proven for all n, m ✓
```

### Why No Tests?

- **Proofs are complete**: You prove properties for ALL inputs, not just test cases
- **Type checker verifies**: The Lean compiler checks mathematical correctness
- **Compile = Verified**: When `lake build` succeeds, all theorems are proven

### When Might You "Test"?

- **Executable code**: If using Lean as a regular programming language (FPiL)
- **Performance**: Checking speed, not correctness
- **External I/O**: Verifying interaction with the outside world

For pure formal verification and proofs, compilation IS verification.

## Contributing Workflow

Standard GitHub flow with PR reviews:

1. Create a branch for your work
2. Make changes and commit
3. Open a Pull Request
4. CI automatically verifies everything
5. Request review if collaborating

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Documentation

- **[`docs/PROJECT_GUIDE.md`](docs/PROJECT_GUIDE.md)** - **START HERE!** Complete walkthrough of project structure, workflow, and best practices
- [`docs/GETTING_STARTED.md`](docs/GETTING_STARTED.md) - Detailed setup guide
- [`docs/DOCUMENTATION.md`](docs/DOCUMENTATION.md) - Code documentation practices

## Scripts

Utility scripts in `scripts/`:
- `setup.sh` - Install dependencies
- `verify.sh` - Run all checks
- `clean.sh` - Clean build artifacts

## License

MIT License - See [LICENSE](LICENSE)

## Resources

- [Lean 4 Documentation](https://lean-lang.org/lean4/doc/)
- [Lean 4 Manual](https://lean-lang.org/lean4/doc/whatIsLean.html)
- [Lean Zulip Chat](https://leanprover.zulipchat.com/) - Community help
- [Lean 4 GitHub](https://github.com/leanprover/lean4)

---

**Ready to start?** Open [`LeanSandbox/Basic.lean`](LeanSandbox/Basic.lean) and begin working through [TPiL](https://lean-lang.org/theorem_proving_in_lean4/)!
