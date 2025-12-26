# Development Workflow Diagram

## File Organization Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Your Code                                                   │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  LeanSandbox/Basic.lean  ─┐                                 │
│  LeanSandbox/Chapter2.lean├──> LeanSandbox.lean             │
│  LeanSandbox/MyProof.lean ─┘         │                      │
│                                       │ imports              │
│                                       ▼                       │
│                                   Main.lean ───> Executable  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Build Process Flow

```
┌──────────────┐
│  lake build  │
└──────┬───────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  1. Read lakefile.toml                  │
│     • What files to build?              │
│     • What dependencies?                │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  2. Check lean-toolchain                │
│     • Using correct Lean version?       │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  3. Resolve dependencies                │
│     • Read lake-manifest.json           │
│     • Download if needed                │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  4. TYPE CHECK & VERIFY ★★★             │
│     • Parse all .lean files             │
│     • Check types                       │
│     • Verify all proofs                 │
│     ← THIS IS WHERE VERIFICATION HAPPENS│
└──────┬──────────────────────────────────┘
       │
       ├─ Success ──────────┐
       │                    │
       │                    ▼
       │            ┌────────────────────┐
       │            │  5. Compile        │
       │            │     • Generate .c  │
       │            │     • Link binary  │
       │            └─────────┬──────────┘
       │                      │
       │                      ▼
       │            ┌───────────────────────┐
       │            │  ✓ Build successful!  │
       │            │  All proofs verified! │
       │            └───────────────────────┘
       │
       └─ Failure ──────────┐
                            │
                            ▼
                    ┌────────────────────┐
                    │  ✗ Build failed    │
                    │  Fix errors shown  │
                    └────────────────────┘
```

## Development Cycle

```
     ┌─────────────────────────────────────────┐
     │                                         │
     │         Daily Development Loop          │
     │                                         │
     └─────────────────┬───────────────────────┘
                       │
          ┌────────────▼────────────┐
          │                         │
          │  1. Edit .lean file     │
          │     • Add definitions   │
          │     • Write proofs      │
          │     • Add docstrings    │
          │                         │
          └────────────┬────────────┘
                       │
          ┌────────────▼────────────┐
          │                         │
          │  2. Save file           │
          │     • VS Code extension │
          │       checks inline     │
          │     • See errors live   │
          │                         │
          └────────────┬────────────┘
                       │
          ┌────────────▼────────────┐
          │                         │
          │  3. lake build          │
          │     • Verify everything │
          │     • Check for errors  │
          │                         │
          └────────────┬────────────┘
                       │
                ┌──────┴──────┐
                │             │
          Errors?          Success!
                │             │
         ┌──────▼─────┐  ┌───▼────────┐
         │            │  │            │
         │  Fix & go  │  │  Commit    │
         │  back to 1 │  │            │
         │            │  └───┬────────┘
         └────────────┘      │
                             │
                    ┌────────▼─────────┐
                    │                  │
                    │  4. Push to Git  │
                    │     • CI runs    │
                    │     • Auto-verify│
                    │                  │
                    └──────────────────┘
```

## What Happens in Different Environments

```
┌─────────────────────────────────────────────────────────────┐
│  Local Development (Your Computer)                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  • Edit files in VS Code                                    │
│  • Lean extension shows errors in real-time                 │
│  • lake build verifies everything                           │
│  • May use cached builds (faster)                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘

                         git push
                            ▼

┌─────────────────────────────────────────────────────────────┐
│  GitHub                                                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  • Code stored in repository                                │
│  • Triggers CI workflows                                    │
│                                                              │
└─────────────────────────────────────────────────────────────┘

                            ▼

┌─────────────────────────────────────────────────────────────┐
│  CI Environment (GitHub Actions)                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Fresh Ubuntu VM                                         │
│  2. Install Lean                                            │
│  3. lake clean && lake build  ← Clean build, no cache      │
│  4. Test executables                                        │
│                                                              │
│  ✓ If successful: All proofs verified independently!       │
│  ✗ If failed: Notification sent, must fix                  │
│                                                              │
└─────────────────────────────────────────────────────────────┘

                            ▼

┌─────────────────────────────────────────────────────────────┐
│  Results                                                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  • Green checkmark on GitHub = Verified ✓                   │
│  • Red X on GitHub = Fix needed ✗                           │
│  • Can merge PR only if CI passes                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Type Checking = Verification

```
Traditional Code:              Lean Code:
──────────────────            ──────────────

Write code                    Write code + proofs
     ↓                              ↓
Compile (syntax check)        Type check (proof verification)
     ↓                              ↓
Run tests                     [No separate tests needed!]
     ↓                              ↓
Maybe correct ¯\_(ツ)_/¯         100% correct ✓

Test coverage: 80%?           Proof coverage: 100%
Bugs might exist              Bugs proven impossible
```

## File Dependencies

```
LeanSandbox/Basic.lean
    ▲
    │ imports
    │
Test.lean ────────┐
                  │
Main.lean ────────┤
                  │
                  ▼
        LeanSandbox.lean
              ▲
              │ imports all modules
              │
        lakefile.toml
              ▲
              │ defines project
              │
         lake build
```

## When Things Go Wrong

```
Error in file
    ↓
┌─────────────────────────────────────┐
│ 1. Check VS Code inline error       │
│    • Red squiggle shows exact spot  │
│    • Hover for error message        │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ 2. Simplify to minimal example      │
│    • Comment out code               │
│    • Find smallest failing case     │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ 3. Use #check and #eval             │
│    • Inspect types                  │
│    • Test values                    │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ 4. Restart Lean server if stuck     │
│    • Cmd+Shift+P: "Lean 4: Restart" │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ 5. Check documentation/ask for help │
│    • Lean Zulip chat                │
│    • Stack Overflow                 │
└─────────────────────────────────────┘
```

---

See [PROJECT_GUIDE.md](PROJECT_GUIDE.md) for detailed explanations!
