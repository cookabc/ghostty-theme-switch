#!/bin/bash
# Integration tests for ghostty-theme

# Don't exit on error in tests - we handle errors ourselves

TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$(cd "$TEST_DIR/../.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0

# Test helper
assert_eq() {
    local expected="$1"
    local actual="$2"
    local test_name="$3"

    if [[ "$expected" == "$actual" ]]; then
        echo -e "${GREEN}✓ PASS${NC}: $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC}: $test_name"
        echo "  Expected: $expected"
        echo "  Actual:   $actual"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local test_name="$3"

    if [[ "$haystack" == *"$needle"* ]]; then
        echo -e "${GREEN}✓ PASS${NC}: $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC}: $test_name"
        echo "  Expected output to contain: $needle"
        echo "  Actual output: $haystack"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test version output
test_version() {
    echo "Testing version command..."

    local output=$("$SOURCE_DIR/ghostty-theme" version | sed 's/\x1b\[[0-9;]*m//g')
    local exit_code=$?

    [[ "$output" == *"ghostty-theme"* ]]
    assert_eq "0" "$?" "Version command shows tool name"

    [[ "$output" == *"2.5"* ]]
    assert_eq "0" "$?" "Version shows correct version"
}

# Test help output
test_help() {
    echo "Testing help command..."

    local output=$("$SOURCE_DIR/ghostty-theme" help | sed 's/\x1b\[[0-9;]*m//g')

    [[ "$output" == *"Usage"* ]]
    assert_eq "0" "$?" "Help shows usage"

    [[ "$output" == *"list"* ]]
    assert_eq "0" "$?" "Help shows list command"

    [[ "$output" == *"random"* ]]
    assert_eq "0" "$?" "Help shows random command"
}

# Test list command with mock ghostty
test_list() {
    echo "Testing list command..."

    if ! command -v ghostty &>/dev/null; then
        echo -e "${YELLOW}⊘ SKIP${NC}: ghostty not installed"
        return
    fi

    local output=$("$SOURCE_DIR/ghostty-theme" list | sed 's/\x1b\[[0-9;]*m//g')

    [[ "$output" == *"Available themes"* ]]
    assert_eq "0" "$?" "List shows header"
}

# Test current command
test_current() {
    echo "Testing current command..."

    local output=$("$SOURCE_DIR/ghostty-theme" current | sed 's/\x1b\[[0-9;]*m//g')

    [[ "$output" == *"Current theme"* ]]
    assert_eq "0" "$?" "Current shows header"
}

# Test reload-hint command
test_reload_hint() {
    echo "Testing reload-hint command..."

    local output=$("$SOURCE_DIR/ghostty-theme" reload-hint)

    if [[ "$(uname)" == "Darwin" ]]; then
        assert_eq "Cmd+Shift+," "$output" "Reload hint shows correct macOS shortcut"
    else
        assert_eq "Ctrl+Shift+," "$output" "Reload hint shows correct Linux shortcut"
    fi
}

# Run all tests
run_integration_tests() {
    echo "========================================"
    echo "  Integration Tests - CLI Commands"
    echo "========================================"
    echo ""

    test_version
    test_help
    test_current
    test_reload_hint

    echo ""
    echo "========================================"
    echo "  Results: $TESTS_PASSED passed, $TESTS_FAILED failed"
    echo "========================================"

    if [[ $TESTS_FAILED -gt 0 ]]; then
        exit 1
    fi
}

run_integration_tests
