#!/bin/bash
# Theme operations

# Get all available themes
get_all_themes() {
    ghostty +list-themes 2>/dev/null | sed 's/ (resources)$//' | sort
}

# Apply theme directly with validation
apply_direct() {
    local new_theme="$1"

    if ! get_all_themes | grep -qx "$new_theme"; then
        echo -e "${RED}Error: Theme '$new_theme' not found${NC}" >&2
        echo -e "${YELLOW}Use 'ghostty-theme list' to see available themes${NC}" >&2
        exit 1
    fi

    apply_theme "$new_theme"
}

# Set random theme
set_random_theme() {
    local all_themes=()
    while IFS= read -r line; do
        all_themes+=("$line")
    done < <(get_all_themes)

    local count=${#all_themes[@]}
    if [[ $count -eq 0 ]]; then
        echo -e "${RED}Error: No themes found${NC}" >&2
        exit 1
    fi

    apply_theme "${all_themes[$((RANDOM % count))]}"
}

# Set light/dark mode theme
set_mode_theme() {
    local mode="$1"
    local theme_name

    case "$mode" in
        light)  theme_name="GitHub Light Default" ;;
        dark)   theme_name="Dracula" ;;
        *)      echo -e "${RED}Error: Invalid mode '$mode'${NC}" >&2; exit 1 ;;
    esac

    apply_theme "$theme_name"
}
