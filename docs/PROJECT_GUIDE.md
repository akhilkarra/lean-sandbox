# Complete Project Guide: Structure, Workflow, and Best Practices

This guide explains how your Lean 4 sandbox project works and how to develop following both Lean best practices and industry-standard software engineering practices.

---

## Table of Contents

1. [Project Structure Overview](#project-structure-overview)
2. [How the Build System Works](#how-the-build-system-works)
3. [Development Workflow](#development-workflow)
4. [Lean Best Practices](#lean-best-practices)
5. [Software Engineering Best Practices](#software-engineering-best-practices)
6. [CI/CD Pipeline](#cicd-pipeline)
7. [Common Tasks](#common-tasks)

---

## Project Structure Overview

```
lean-sandbox/
├── .github/
│   └── workflows/
│       ├── ci.yml              # Automated testing on every push/PR
│       ├── release.yml         # Automated releases
│       └── lean_action_ci.yml  # Lean-specific CI
│
├── docs/
│   ├── GETTING_STARTED.md      # Beginner setup guide
│   └── DOCUMENTATION.md        # Documentation standards
│
├── scripts/
│   ├── setup.sh                # One-time project setup
│   ├── verify.sh               # Run all checks locally
│   └── clean.sh                # Clean build artifacts
│
├── LeanSandbox/
│   └── Basic.lean              # Your main learning/working file
│
├── LeanSandbox.lean            # Library root (imports all modules)
├── Main.lean                   # Executable entry point
├── Test.lean                   # Scratch file for experiments
├── lakefile.toml               # Project configuration
├── lake-manifest.json          # Locked dependency versions (like package-lock.json)
├── lean-toolchain              # Specifies exact Lean version to use
└── README.md                   # Project documentation
```

### Key Files Explained

#### `lakefile.toml` - Project Configuration
This is like `package.json` (Node.js) or `Cargo.toml` (Rust). It defines:
- Project metadata (name, version, description)
- What to build (libraries and executables)
- Dependencies (external Lean packages)

#### `lean-toolchain` - Version Lock
Contains a single line like `leanprover/lean4:v4.26.0`. This ensures everyone uses the exact same Lean version. Like `.nvmrc` for Node.js.

#### `lake-manifest.json` - Dependency Lock
Auto-generated file that locks dependency versions. Like `package-lock.json` or `Cargo.lock`. Commit this to ensure reproducible builds.

#### `LeanSandbox.lean` - Library Root
The "index" file for your library. It imports all your modules. When someone writes `import LeanSandbox`, Lean looks here to see what's available.

#### `LeanSandbox/` Directory
Your library modules live here. Each `.lean` file is a module that must be imported in `LeanSandbox.lean` to be included in the build.

---

## How the Build System Works

### Lake - Lean's Build Tool

Lake is to Lean what:
- `cargo` is to Rust
- `npm`/`yarn` is to JavaScript
- `pip` is to Python

### Build Process

```bash
lake build
```

What happens:
1. **Read `lakefile.toml`** - Determine what to build
2. **Check `lean-toolchain`** - Ensure correct Lean version
3. **Resolve dependencies** - Read `lake-manifest.json`
4. **Type-check all files** - This is where proofs are verified!
5. **Compile to executable** - Generate binaries for `Main.lean`
6. **Cache results** - `.lake/` directory stores build artifacts

**Key Insight:** Step 4 is where the magic happens. If type-checking succeeds, all your proofs are mathematically verified!

### Build Artifacts

```
.lake/
├── build/          # Compiled .olean files (like .o object files)
├── packages/       # Downloaded dependencies
└── lakefile.olean  # Compiled lakefile
```

These are like `node_modules/` or `target/` - don't commit them. Already in `.gitignore`.

---

## Development Workflow

### Day-to-Day Development

#### 1. **Working on Proofs/Definitions**

```bash
# Open your working file
code LeanSandbox/Basic.lean
```

**In VS Code:**
- Lean extension shows errors inline (red squiggles)
- Green checkmark (✓) = file is verified
- Hover over terms to see types
- Use `#check` to inspect definitions
- Use `#eval` to run computations

**Best Practice:**
```lean
-- Add a docstring (/** ... */) above every definition
/-- Adds two natural numbers -/
def add (n m : Nat) : Nat := n + m

-- Use clear names
def isEven (n : Nat) : Bool := n % 2 == 0  -- Good
def f (x : Nat) : Bool := x % 2 == 0        -- Bad

-- Group related definitions
namespace MyModule
  def helper1 := ...
  def helper2 := ...
end MyModule
```

#### 2. **Quick Experiments**

Use `Test.lean` for throwaway code:
```lean
-- Test.lean
import LeanSandbox

#check Nat.add
#eval 2 + 2

-- Try something without committing
def experimentalIdea := ...
```

#### 3. **Building and Verification**

```bash
# Build everything and verify all proofs
lake build

# Run the executable
lake exe lean-sandbox

# Clean and rebuild from scratch
lake clean && lake build
```

**Best Practice:** Build frequently! If you wait until you have 100 lines, finding the error is hard. Build every 5-10 lines.

#### 4. **Creating New Modules**

When you want to organize code into topics:

```bash
# Create a new module
touch LeanSandbox/Chapter2.lean
```

Write some code:
```lean
-- LeanSandbox/Chapter2.lean
/-!
# Chapter 2: Propositional Logic

Working through TPiL Chapter 2
-/

namespace Chapter2

/-- My first proof -/
theorem and_comm (p q : Prop) : p ∧ q → q ∧ p := by
  intro ⟨hp, hq⟩
  exact ⟨hq, hp⟩

end Chapter2
```

**Register it:**
```lean
-- LeanSandbox.lean
import LeanSandbox.Basic
import LeanSandbox.Chapter2  -- Add this line
```

Now `lake build` will check this file too.

---

## Lean Best Practices

### 1. **Documentation Comments**

```lean
/-!
# Module-level documentation

Describes what this file contains.
Can use markdown!
-/

/-- Single-line doc comment for definitions -/
def myFunction (n : Nat) : Nat := n + 1

/-! ## Section headers
Group related items
-/
```

### 2. **Naming Conventions**

```lean
-- Types: PascalCase
inductive MyType := ...

-- Functions/definitions: camelCase
def myFunction := ...

-- Theorems: snake_case (following Mathlib convention)
theorem my_theorem := ...

-- Constants: camelCase or SCREAMING_SNAKE_CASE
def maxSize := 100
def MAX_SIZE := 100
```

### 3. **Proof Style**

**Term-mode proofs** (direct construction):
```lean
-- Preferred for simple proofs
theorem add_zero (n : Nat) : n + 0 = n := Nat.add_zero n
```

**Tactic-mode proofs** (step-by-step):
```lean
-- For complex proofs
theorem add_comm (n m : Nat) : n + m = m + n := by
  rw [Nat.add_comm]  -- Each line is a proof step
```

**Best Practice:** Use the simplest proof that's readable. Don't use tactics when `rfl` works.

### 4. **Organizing Proofs**

```lean
/-! ## Main Theorem -/

/-- The theorem statement -/
theorem main_result : ... := by
  -- Use helper lemmas
  have helper1 := helper_lemma1
  have helper2 := helper_lemma2
  -- Continue proof
  ...

/-! ## Helper Lemmas -/

private theorem helper_lemma1 : ... := ...
private theorem helper_lemma2 : ... := ...
```

### 5. **Type Annotations**

```lean
-- Always annotate function types (even if Lean can infer)
def add (n m : Nat) : Nat := n + m  -- Good
def add n m := n + m                 -- Bad (unclear types)

-- Annotate intermediate steps in complex proofs
theorem complex : ... := by
  have step1 : SpecificType := ...  -- Good
  have step1 := ...                  -- Bad (unclear)
```

### 6. **Error Messages**

When you get an error:
```
tactic 'rewrite' failed, did not find instance of the pattern in the target expression
```

**Debugging:**
1. Hover over term to see its type
2. Use `#check` to inspect
3. Add intermediate `have` statements
4. Simplify to minimal example

---

## Software Engineering Best Practices

### 1. **Version Control Workflow**

```bash
# Create a feature branch
git checkout -b add-chapter2-proofs

# Make changes
# ... edit files ...

# Build and verify
lake build

# Commit with clear message
git add LeanSandbox/Chapter2.lean
git commit -m "Add: Propositional logic proofs from TPiL Chapter 2

- Prove conjunction commutativity
- Prove disjunction commutativity
- Add docstrings explaining each proof"

# Push and create PR
git push origin add-chapter2-proofs
```

**Best Practice:**
- One logical change per commit
- Descriptive commit messages
- Reference issues: `Fix #42: Correct add_comm proof`

### 2. **Pull Request Workflow**

```bash
# Create PR
gh pr create --title "Add Chapter 2 proofs" --body "..."

# CI runs automatically:
# ✓ Builds on Ubuntu
# ✓ Builds on macOS
# ✓ Runs all executables
# ✓ Checks formatting

# If CI passes, merge
# If CI fails, fix and push again (CI re-runs)
```

**Best Practice:**
- Never merge if CI fails
- Get reviews for complex proofs
- Keep PRs small and focused

### 3. **Code Organization**

```
LeanSandbox/
├── Basic.lean           # Core definitions used everywhere
├── Chapter2.lean        # TPiL Chapter 2 work
├── Chapter3.lean        # TPiL Chapter 3 work
├── Exercises/
│   ├── Week1.lean       # If doing exercises
│   └── Week2.lean
└── Projects/
    └── MyProof.lean     # Longer projects
```

**Best Practice:**
- Related code in the same file
- One major topic per file
- Use subdirectories for grouping

### 4. **Dependencies**

To add a dependency (like Mathlib):

```bash
# Add dependency
lake update

# In lakefile.toml, add:
# require mathlib from git
#   "https://github.com/leanprover-community/mathlib4.git"
```

**Best Practice:**
- Pin versions in `lake-manifest.json` (commit it)
- Update dependencies intentionally, not randomly
- Test after updates

### 5. **Continuous Integration**

Your project has 3 CI workflows:

**`ci.yml`** - Main CI:
- Runs on every push to main
- Runs on every PR
- Tests on Ubuntu and macOS
- Builds project
- Runs executables

**`release.yml`** - Automated releases:
- Triggers on version tags (v0.1.0)
- Creates GitHub releases
- Attaches build artifacts

**`lean_action_ci.yml`** - Lean-specific checks:
- Uses official Lean GitHub Action
- Additional Lean ecosystem checks

**Best Practice:**
- Don't commit until local `lake build` passes
- Fix CI failures immediately
- Don't merge failing PRs

---

## CI/CD Pipeline

### What Runs on Every Push

```yaml
# .github/workflows/ci.yml

1. Checkout code
2. Install Lean (via Elan)
3. Cache dependencies (speeds up builds)
4. Update Lake
5. Build project ← THIS VERIFIES ALL PROOFS
6. Run executables (smoke test)
```

**The Build Step is Key:**
When CI runs `lake build`, it type-checks everything. If this succeeds, ALL your proofs are verified on a clean machine. This is your guarantee of correctness!

### Local Development vs. CI

**Local:**
```bash
lake build  # Might use cached results
```

**CI:**
```bash
lake clean
lake build  # Always clean build
```

CI is more strict - it catches:
- Missing imports
- Platform-specific issues
- Uncommitted files you depend on

---

## Common Tasks

### Adding a New Theorem

```lean
-- 1. Write theorem statement with docstring
/-- Addition is commutative for natural numbers -/
theorem add_comm (n m : Nat) : n + m = m + n := by
  sorry  -- Placeholder

-- 2. Build to check syntax
-- $ lake build

-- 3. Replace sorry with proof
theorem add_comm (n m : Nat) : n + m = m + n := by
  rw [Nat.add_comm]

-- 4. Build again to verify
-- $ lake build
```

### Refactoring Code

```bash
# 1. Create branch
git checkout -b refactor-basic

# 2. Make changes
# 3. Build to ensure nothing breaks
lake build

# 4. Run any executables that depend on it
lake exe lean-sandbox

# 5. Commit and push
git commit -m "Refactor: Simplify add definition"
```

### Debugging a Proof

```lean
theorem tricky : complicated_statement := by
  -- Step 1: See what you have
  sorry

-- Build and hover over goal to see state

theorem tricky : complicated_statement := by
  -- Step 2: Try simple tactics
  intro x
  sorry

-- Build and check if goal simplified

theorem tricky : complicated_statement := by
  intro x
  cases x
  -- Continue until done
```

**Best Practice:** Work incrementally. Add one line, build, check goal. Repeat.

### Creating Documentation

```bash
# Generate documentation (if you set up doc-gen4)
lake build doc

# For now, write good docstrings:
/-- 
This function does X.

## Example
```lean
#eval myFunction 5  -- Returns 10
```

## Note
This assumes Y condition holds.
-/
def myFunction := ...
```

---

## Summary: The Verification Guarantee

**The Key Insight:**

```
lake build succeeds
↓
All files type-check
↓
All theorems are proven correct
↓
100% verified (no bugs in proofs)
```

**Unlike traditional code:**
```
npm test passes
↓
Test cases pass
↓
Code probably works (for tested cases)
↓
Bugs might exist in untested paths
```

**Your workflow:**
1. Write code/proofs
2. Run `lake build`
3. If it compiles: Verified! ✓
4. If not: Fix errors and repeat

**No separate testing needed for proofs** - the type checker is the ultimate test!

---

## Quick Reference

| Task | Command |
|------|---------|
| Build everything | `lake build` |
| Run executable | `lake exe lean-sandbox` |
| Clean build | `lake clean` |
| Update dependencies | `lake update` |
| Create new file | `touch LeanSandbox/NewFile.lean` |
| Register new file | Add to `LeanSandbox.lean` |
| Check without building | `lean --version` |
| Format code | (Auto-formats in VS Code) |

| VS Code Shortcut | Action |
|-----------------|--------|
| Cmd/Ctrl + Shift + P | Command palette |
| `Lean 4: Restart Server` | Fix stuck errors |
| Hover over term | See type |
| Cmd/Ctrl + Click | Go to definition |

---

**Next Steps:** Start working through [TPiL](https://lean-lang.org/theorem_proving_in_lean4/) in [`LeanSandbox/Basic.lean`](../LeanSandbox/Basic.lean)!
