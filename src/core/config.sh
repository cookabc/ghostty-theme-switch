#!/bin/bash
# Core configuration functions

# Configuration file paths in order of preference
GHOSTTY_CONFIG_PATHS=(
    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    "$XDG_CONFIG_HOME/ghostty/config"
    "$HOME/.config/ghostty/config"
)

# Get the Ghostty configuration file path
get_config_file() {
    for config_path in "${GHOSTTY_CONFIG_PATHS[@]}"; do
        if [[ -f "$config_path" ]]; then
            echo "$config_path"
            return 0
        fi
    done
    return 1
}

# Get the themes directory based on platform
get_themes_dir() {
    local themes_dir

    # Check macOS
    if [[ -d "/Applications/Ghostty.app/Contents/Resources/ghostty/themes" ]]; then
        themes_dir="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
    # Check Linux (AppImage or package installation)
    elif command -v ghostty &>/dev/null; then
        # Try to get themes from ghostty resources
        themes_dir=$(ghostty +list-themes 2>/dev/null | head -1)
        if [[ -z "$themes_dir" ]] || [[ ! -d "$themes_dir" ]]; then
            # Fallback to common Linux paths
            if [[ -d "/usr/share/ghostty/themes" ]]; then
                themes_dir="/usr/share/ghostty/themes"
            elif [[ -d "/usr/local/share/ghostty/themes" ]]; then
                themes_dir="/usr/local/share/ghostty/themes"
            fi
        fi
    fi

    if [[ -n "$themes_dir" && -d "$themes_dir" ]]; then
        echo "$themes_dir"
        return 0
    fi
    return 1
}

# Get current theme from config
get_current_theme() {
    local config_file
    config_file=$(get_config_file) || {
        echo "Unknown"
        return 1
    }

    if [[ -f "$config_file" ]]; then
        awk -F'= *' '/^theme[[:space:]]*=/ {print $2}' "$config_file" | tr -d '"' | tr -d "'" | head -1
    else
        echo "Unknown"
    fi
}

# Apply theme to config
apply_theme() {
    local new_theme="$1"
    local config_file
    config_file=$(get_config_file) || {
        echo -e "${RED}Error: Ghostty config not found${NC}" >&2
        return 1
    }

    # Backup before modifying
    cp "$config_file" "${config_file}.bak"

    if grep -qE "^theme[[:space:]]*=" "$config_file"; then
        awk -v new_theme="$new_theme" '/^theme[[:space:]]*=/ {$0 = "theme = " new_theme} 1' "$config_file" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"
    else
        echo "theme = $new_theme" >> "$config_file"
    fi

    echo -e "${GREEN}✓ Applied: ${BOLD}$new_theme${NC}"
}
