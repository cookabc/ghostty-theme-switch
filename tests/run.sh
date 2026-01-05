#!/bin/bash
# Test runner - runs all tests

# Don't exit on error - let tests handle their own errors

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "========================================"
echo "  Ghostty Theme Switcher - Test Suite"
echo "========================================"
echo ""

# Run unit tests
echo "Running unit tests..."
echo "----------------------------------------"
bash "$SCRIPT_DIR/unit/test_config.sh"
echo ""

# Run integration tests
echo "Running integration tests..."
echo "----------------------------------------"
bash "$SCRIPT_DIR/integration/test_cli.sh"
echo ""

echo "========================================"
echo "  All tests passed!"
echo "========================================"
