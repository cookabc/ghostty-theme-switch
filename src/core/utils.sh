#!/bin/bash
# Utility functions

# Reload instruction based on platform
RELOAD_HINT=$([[ "$(uname)" == "Darwin" ]] && echo "Cmd+Shift+," || echo "Ctrl+Shift+,")

# Print usage information
usage() {
    echo -e "${CYAN}Ghostty Theme Switcher${NC} v${VERSION}"
    echo ""
    echo "Usage:"
    echo "  ghostty-theme                    Interactive theme selector"
    echo "  ghostty-theme list               List all themes"
    echo "  ghostty-theme current            Show current theme"
    echo "  ghostty-theme <theme-name>       Apply specific theme"
    echo "  ghostty-theme random             Apply random theme"
    echo "  ghostty-theme light/dark         Apply light/dark theme"
    echo "  ghostty-theme version            Show version"
    echo ""
    echo "Examples:"
    echo "  ghostty-theme                    # Interactive selector with preview"
    echo "  ghostty-theme \"Dracula\"          # Apply Dracula theme"
    echo "  ghostty-theme random             # Random theme"
}

# List all themes with current indicator
list_themes() {
    local current
    current=$(get_current_theme)
    local has_current=false

    echo -e "${BOLD}Available themes:${NC}"
    echo ""

    while IFS= read -r theme; do
        if [[ -n "$theme" ]]; then
            if [[ "$theme" == "$current" ]]; then
                echo -e "  ${GREEN}●${NC} $theme ${CYAN}(current)${NC}"
                has_current=true
            else
                echo -e "  ○ $theme"
            fi
        fi
    done < <(get_all_themes)

    if [[ "$has_current" == "false" && "$current" != "Unknown" ]]; then
        echo ""
        echo -e "  ${YELLOW}Note: Current theme '$current' not in list${NC}"
    fi
}
