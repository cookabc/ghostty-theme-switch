#!/bin/bash
# Uninstallation script for Ghostty Theme Switcher

set -e

SCRIPT_NAME="ghostty-theme"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Find installed script location
find_install_path() {
    # Check common locations
    local locations=(
        "$HOME/.local/bin/$SCRIPT_NAME"
        "/usr/local/bin/$SCRIPT_NAME"
        "$HOME/bin/$SCRIPT_NAME"
    )

    for path in "${locations[@]}"; do
        if [[ -f "$path" ]]; then
            echo "$path"
            return 0
        fi
    done

    return 1
}

# Main uninstallation
main() {
    echo -e "${CYAN}Ghostty Theme Switcher Uninstaller${NC}"
    echo ""

    INSTALL_PATH=$(find_install_path)

    if [[ -z "$INSTALL_PATH" ]]; then
        echo -e "${YELLOW}No installation found${NC}"
        exit 0
    fi

    echo "Found installation at: $INSTALL_PATH"
    read -p "Remove this file? [y/N] " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$INSTALL_PATH"
        echo -e "${GREEN}Uninstalled: $INSTALL_PATH${NC}"
        echo ""
        echo -e "${YELLOW}Note: You may want to remove the PATH entry from your shell config${NC}"
    else
        echo "Uninstall cancelled"
    fi
}

# Run main
main "$@"
