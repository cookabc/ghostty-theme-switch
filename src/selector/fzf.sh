#!/bin/bash
# fzf selector with preview

fzf_select() {
    local current
    current=$(get_current_theme)

    # Ensure preview script is available
    local preview_script="$XDG_DATA_HOME/ghostty-theme/fzf-preview.pl"
    [[ -z "$XDG_DATA_HOME" ]] && preview_script="$HOME/.local/share/ghostty-theme/fzf-preview.pl"

    if [[ ! -f "$preview_script" ]]; then
        mkdir -p "$(dirname "$preview_script")"
        cp "$SCRIPT_DIR/src/preview/fzf-preview.pl" "$preview_script"
        chmod +x "$preview_script"
    fi

    local selected
    selected=$(get_all_themes | \
        fzf --height=70% \
            --prompt="Theme> " \
            --query="$current" \
            --header="[Enter] Apply | [Esc] Cancel" \
            --border=rounded \
            --marker="●" \
            --pointer="→" \
            --color=header:cyan,pointer:cyan,marker:green,preview-border:cyan \
            --preview-window=right:30% \
            --preview="$preview_script {}")

    if [[ -n "$selected" ]]; then
        apply_theme "$selected"
    else
        echo "No theme selected"
    fi
}
