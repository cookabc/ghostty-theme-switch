#!/bin/bash
# Installation script for Ghostty Theme Switcher

set -e

VERSION="1.0.0"
SCRIPT_NAME="ghostty-theme"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SOURCE_DIR/src/$SCRIPT_NAME"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Print banner
print_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "╔═══════════════════════════════════════════╗"
    echo "║   Ghostty Theme Switcher Installer       ║"
    echo "║   Version $VERSION                          ║"
    echo "╚═══════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Detect install directory
detect_install_dir() {
    # Prefer ~/.local/bin if it exists or is in PATH
    if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]] || [[ -d "$HOME/.local/bin" ]]; then
        echo "$HOME/.local/bin"
    elif [[ -d "/usr/local/bin" ]]; then
        echo "/usr/local/bin"
    else
        echo "$HOME/.local/bin"
    fi
}

# Main installation
main() {
    print_banner

    # Check if source file exists
    if [[ ! -f "$SOURCE_FILE" ]]; then
        echo -e "${RED}Error: Source file not found: $SOURCE_FILE${NC}"
        echo -e "${YELLOW}Please run this script from the project directory${NC}"
        exit 1
    fi

    # Detect install directory
    INSTALL_DIR=$(detect_install_dir)
    INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"

    echo -e "${CYAN}Installation summary:${NC}"
    echo "  Source:  $SOURCE_FILE"
    echo "  Target:  $INSTALL_PATH"
    echo ""

    # Create install directory if needed
    if [[ ! -d "$INSTALL_DIR" ]]; then
        echo -e "${YELLOW}Creating directory: $INSTALL_DIR${NC}"
        mkdir -p "$INSTALL_DIR"

        # Add to PATH if not already there
        if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
            echo ""
            echo -e "${YELLOW}Adding $INSTALL_DIR to PATH...${NC}"

            # Detect shell config file
            SHELL_CONFIG=""
            if [[ -n "$ZSH_VERSION" ]]; then
                SHELL_CONFIG="$HOME/.zshrc"
            elif [[ -n "$BASH_VERSION" ]]; then
                SHELL_CONFIG="$HOME/.bashrc"
                [[ "$OSTYPE" == "darwin"* ]] && SHELL_CONFIG="$HOME/.bash_profile"
            fi

            if [[ -n "$SHELL_CONFIG" ]]; then
                echo "" >> "$SHELL_CONFIG"
                echo "# Added by ghostty-theme-switch installer" >> "$SHELL_CONFIG"
                echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_CONFIG"
                echo -e "${GREEN}Added to $SHELL_CONFIG${NC}"
                echo -e "${YELLOW}Restart your shell or run: source $SHELL_CONFIG${NC}"
            fi
        fi
    fi

    # Copy the script
    echo -e "${YELLOW}Installing $SCRIPT_NAME...${NC}"
    cp "$SOURCE_FILE" "$INSTALL_PATH"
    chmod +x "$INSTALL_PATH"

    echo -e "${GREEN}Successfully installed to: $INSTALL_PATH${NC}"
    echo ""
    echo -e "${CYAN}Usage:${NC}"
    echo "  $SCRIPT_NAME          # Interactive theme selector"
    echo "  $SCRIPT_NAME list     # List all themes"
    echo "  $SCRIPT_NAME current  # Show current theme"
    echo "  $SCRIPT_NAME <name>   # Set specific theme"
    echo "  $SCRIPT_NAME --help   # Show all options"
    echo ""
    echo -e "${GREEN}Installation complete!${NC}"
}

# Run main
main "$@"
