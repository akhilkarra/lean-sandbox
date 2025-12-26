#!/usr/bin/env bash
# Setup script for Lean Sandbox project

set -e

echo "🚀 Setting up Lean Sandbox..."
echo ""

# Check if elan is installed
if ! command -v elan &> /dev/null; then
    echo "❌ Elan (Lean version manager) is not installed."
    echo ""
    echo "Please install elan first:"
    echo "  curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh"
    echo ""
    exit 1
fi

echo "✓ Elan is installed"

# Check Lean version
echo "📦 Lean version:"
lean --version

# Check Lake version  
echo "📦 Lake version:"
lake --version

echo ""
echo "🔨 Updating dependencies..."
lake update

echo ""
echo "🏗️  Building project..."
lake build

echo ""
echo "🧪 Running tests..."
if lake exe test; then
    echo ""
    echo "✅ Setup complete! All tests passed."
    echo ""
    echo "Next steps:"
    echo "  • Run 'lake exe lean-sandbox' to see the demo"
    echo "  • Open the project in VS Code with the Lean 4 extension"
    echo "  • Read docs/GETTING_STARTED.md to learn more"
    echo "  • Explore LeanSandbox/ directory for examples"
else
    echo ""
    echo "⚠️  Setup complete but some tests failed."
    echo "This might be okay if you're just starting development."
    echo ""
    echo "Try running 'lake clean && lake build' if you see issues."
fi
