#!/usr/bin/env bash
# Clean script - removes all build artifacts

echo "🧹 Cleaning build artifacts..."

# Remove Lake build directory
if [ -d ".lake" ]; then
    echo "  Removing .lake/"
    rm -rf .lake
fi

# Remove build directory
if [ -d "build" ]; then
    echo "  Removing build/"
    rm -rf build
fi

echo "✓ Clean complete!"
echo ""
echo "Run 'lake build' to rebuild the project."
