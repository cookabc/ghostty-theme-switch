#!/bin/bash
# Simple selector (fallback when fzf not available)

simple_select() {
    local current
    current=$(get_current_theme)

    local -a themes
    while IFS= read -r line; do
        themes+=("$line")
    done < <(get_all_themes)

    if [[ ${#themes[@]} -eq 0 ]]; then
        echo -e "${RED}Error: No themes found. Is Ghostty installed?${NC}" >&2
        exit 1
    fi

    local page_size=15
    local page=0
    local total_pages=$(( (${#themes[@]} + page_size - 1) / page_size ))

    while true; do
        clear
        echo -e "${CYAN}${BOLD}╔═══════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}${BOLD}║       Ghostty Theme Selector              ║${NC}"
        echo -e "${CYAN}${BOLD}╚═══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${BOLD}Page $((page + 1))/$total_pages${NC} - ${YELLOW}n/p${NC} for next/prev, ${YELLOW}q${NC} to quit"
        echo ""

        local start=$((page * page_size))
        local end=$((start + page_size))
        [[ $end -gt ${#themes[@]} ]] && end=${#themes[@]}

        for ((i=start; i<end; i++)); do
            local num=$((i + 1))
            if [[ "${themes[$i]}" == "$current" ]]; then
                echo -e "  ${GREEN}[$num]${NC} ${themes[$i]} ${CYAN}(current)${NC}"
            else
                echo -e "  [$num] ${themes[$i]}"
            fi
        done

        echo ""
        echo -ne "${YELLOW}Enter number to apply (or n/p/q): ${NC}"

        local input
        read input

        case "$input" in
            q|Q|exit)
                echo ""
                echo "No changes made"
                exit 0
                ;;
            n|N|next)
                [[ $page -lt $((total_pages - 1)) ]] && ((page++))
                ;;
            p|P|prev)
                [[ $page -gt 0 ]] && ((page--))
                ;;
            *)
                if [[ "$input" =~ ^[0-9]+$ ]] && [[ $input -ge 1 ]] && [[ $input -le ${#themes[@]} ]]; then
                    apply_theme "${themes[$((input - 1))]}"
                    exit 0
                else
                    echo -e "${RED}Invalid selection${NC}"
                    sleep 1
                fi
                ;;
        esac
    done
}
