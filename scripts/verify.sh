#!/usr/bin/env bash
# Verification script - runs all checks

set -e

echo "🔍 Running comprehensive verification..."
echo ""

# Build project
echo "1️⃣  Building project..."
if lake build; then
    echo "✓ Build successful"
else
    echo "✗ Build failed"
    exit 1
fi

echo ""

# Run tests
echo "2️⃣  Running tests..."
if lake exe test; then
    echo "✓ All tests passed"
else
    echo "✗ Tests failed"
    exit 1
fi

echo ""

# Run main executable
echo "3️⃣  Running main executable..."
if lake exe lean-sandbox > /dev/null 2>&1; then
    echo "✓ Main executable runs successfully"
else
    echo "✗ Main executable failed"
    exit 1
fi

echo ""

# Check for warnings
echo "4️⃣  Checking for warnings..."
if lake build 2>&1 | grep -i "warning"; then
    echo "⚠️  Warnings found (not fatal)"
else
    echo "✓ No warnings"
fi

echo ""
echo "═══════════════════════════════════"
echo "✅ All verifications passed!"
echo "═══════════════════════════════════"
