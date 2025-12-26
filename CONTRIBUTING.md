# Contributing to Lean Sandbox

Thank you for your interest in contributing to Lean Sandbox! This document provides guidelines for contributing to the project.

## 🎯 Types of Contributions

We welcome several types of contributions:

1. **New theorems and proofs**
2. **Bug fixes**
3. **Documentation improvements**
4. **Test additions**
5. **Performance improvements**
6. **Examples and tutorials**

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR_USERNAME/lean-sandbox.git
cd lean-sandbox
```

### 2. Set Up Development Environment

```bash
# Install dependencies
lake update

# Build the project
lake build

# Run tests to ensure everything works
lake exe test
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

## 📝 Contribution Guidelines

### Code Style

1. **Documentation**
   - Add module documentation (`/-! ... -/`) at the top of each file
   - Document all public definitions with `/-- ... -/`
   - Use clear, descriptive names

2. **Formatting**
   - Follow Lean 4 naming conventions
   - Use 2 spaces for indentation
   - Keep lines under 100 characters when possible

3. **Verification**
   - Mark verified theorems with ✓ in comments
   - Ensure all proofs are complete (no `sorry`)
   - Add tests for new functionality

### Example of Well-Documented Code

```lean
/-!
# Module Title

Brief description of what this module contains.

## Main definitions
- `foo`: Description
- `bar`: Description

## Main theorems
- `theorem_name`: Description
-/

namespace MyModule

/-- A function that does something useful -/
def myFunction (n : Nat) : Nat :=
  n + 1

/-- ✓ Theorem: myFunction increases the input by 1 -/
theorem myFunction_spec (n : Nat) : myFunction n = n + 1 := by
  rfl

end MyModule
```

### Testing

1. Add tests for new theorems in `Test.lean`
2. Ensure all tests pass:
   ```bash
   lake exe test
   ```
3. Consider adding integration tests if appropriate

### Commit Messages

Write clear, descriptive commit messages:

```
Add proof of Fermat's Little Theorem

- Implement theorem in LeanSandbox/Examples/NumberTheory.lean
- Add tests in Test.lean
- Update documentation
```

## 🔄 Pull Request Process

### 1. Before Submitting

- [ ] All tests pass (`lake exe test`)
- [ ] Project builds without errors (`lake build`)
- [ ] Documentation is updated
- [ ] Code follows style guidelines
- [ ] Commits are clean and descriptive

### 2. Submit Pull Request

1. Push your branch to GitHub:
   ```bash
   git push origin feature/your-feature-name
   ```

2. Open a Pull Request on GitHub
3. Fill out the PR template with:
   - Description of changes
   - Related issues (if any)
   - Testing done
   - Screenshots (if applicable)

### 3. Review Process

- Maintainers will review your PR
- Address any feedback or requested changes
- Once approved, your PR will be merged!

## 🐛 Reporting Bugs

### Bug Reports Should Include:

1. **Description**: Clear description of the bug
2. **Steps to Reproduce**:
   ```
   1. Run command X
   2. See error Y
   ```
3. **Expected Behavior**: What should happen
4. **Actual Behavior**: What actually happens
5. **Environment**:
   - OS (macOS, Linux, Windows)
   - Lean version (`lean --version`)
   - Lake version (`lake --version`)

### Example Bug Report

```markdown
## Bug: Theorem X fails to verify

**Description**
The theorem `example_theorem` in `LeanSandbox/Examples/Lists.lean` fails to verify.

**Steps to Reproduce**
1. Run `lake build`
2. See compilation error in Lists.lean:45

**Expected Behavior**
Theorem should verify successfully

**Actual Behavior**
Error: "type mismatch..."

**Environment**
- macOS 14.0
- Lean version 4.5.0
- Lake version 4.5.0
```

## 💡 Suggesting Enhancements

We love new ideas! When suggesting enhancements:

1. Check if it's already suggested in [Issues](https://github.com/YOUR_USERNAME/lean-sandbox/issues)
2. Create a new issue with:
   - Clear title
   - Detailed description
   - Use cases
   - Example code (if applicable)

## 📚 Documentation

Documentation improvements are always welcome:

- Fix typos or unclear explanations
- Add examples
- Improve module documentation
- Create tutorials

## ❓ Questions?

- Check [existing issues](https://github.com/YOUR_USERNAME/lean-sandbox/issues)
- Ask on [Lean Zulip Chat](https://leanprover.zulipchat.com/)
- Open a new issue with the "question" label

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Thank You!

Your contributions make this project better for everyone. We appreciate your time and effort!
