#!/bin/bash
# Unit tests for config functions

# Don't exit on error in tests - we handle errors ourselves

TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$(cd "$TEST_DIR/../.." && pwd)"

# Colors for test output
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

# Mock ghostty for testing
setup_mock_ghostty() {
    export PATH="$TEST_DIR/mock-bin:$PATH"
}

# Test config path detection
test_get_config_file() {
    echo "Testing get_config_file..."

    # Create temp config for testing
    local temp_config=$(mktemp)
    echo "theme = TestTheme" > "$temp_config"

    # Mock HOME
    local old_home="$HOME"
    export HOME="$TEST_DIR/test-home"

    mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
    cp "$temp_config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

    # Source and test
    source "$SOURCE_DIR/src/core/config.sh"

    local result=$(get_config_file)
    assert_eq "$HOME/Library/Application Support/com.mitchellh.ghostty/config" "$result" "Detects macOS config path"

    # Cleanup
    rm -rf "$HOME"
    rm -f "$temp_config"
    export HOME="$old_home"
}

# Test theme application
test_apply_theme() {
    echo "Testing apply_theme..."

    export HOME="$TEST_DIR/test-home"
    mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
    echo "theme = OldTheme" > "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    local config_file="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    local backup_config="${config_file}.bak"

    source "$SOURCE_DIR/src/core/config.sh"

    # Apply new theme
    apply_theme "NewTheme" >/dev/null

    # Check config was updated
    grep -q "theme = NewTheme" "$config_file"
    assert_eq "0" "$?" "Updates theme in config"

    # Check backup was created
    grep -q "theme = OldTheme" "$backup_config"
    assert_eq "0" "$?" "Creates backup of config"

    # Cleanup
    rm -rf "$HOME"
}

# Test current theme extraction
test_get_current_theme() {
    echo "Testing get_current_theme..."

    local temp_config=$(mktemp)
    echo -e "theme = Dracula\nfont-size = 13" > "$temp_config"

    export HOME="$TEST_DIR/test-home"
    mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
    cp "$temp_config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

    source "$SOURCE_DIR/src/core/config.sh"

    local result=$(get_current_theme)
    assert_eq "Dracula" "$result" "Extracts current theme from config"

    # Cleanup
    rm -rf "$HOME"
    rm -f "$temp_config"
}

# Run all tests
run_tests() {
    echo "========================================"
    echo "  Unit Tests - Core Functions"
    echo "========================================"
    echo ""

    setup_mock_ghostty
    test_get_config_file
    test_apply_theme
    test_get_current_theme

    echo ""
    echo "========================================"
    echo "  Results: $TESTS_PASSED passed, $TESTS_FAILED failed"
    echo "========================================"

    if [[ $TESTS_FAILED -gt 0 ]]; then
        exit 1
    fi
}

run_tests
