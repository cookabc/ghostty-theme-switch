# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator with **live preview**.

## Features

- **200+ built-in themes** - Access all Ghostty's built-in themes
- **Live preview** - Preview themes in a new Ghostty window before applying
- **fzf integration** - Fuzzy search theme selector with [fzf](https://github.com/junegunn/fzf)
- **Fallback selector** - Simple numbered list selector when fzf is not available
- **Quick commands** - Set light/dark themes, random theme, or specific themes
- **Cross-platform** - Works on macOS and Linux
- **Safe** - Automatically backs up your config before making changes

## Installation

```bash
git clone https://github.com/yourusername/ghostty-theme-switch.git
cd ghostty-theme-switch
./install.sh
```

**Recommended**: Install [fzf](https://github.com/junegunn/fzf) for the best experience:
```bash
brew install fzf  # macOS
```

## Usage

### Interactive Mode with Preview

```bash
ghostty-theme
```

1. Select a theme (fzf fuzzy search or numbered list)
2. A **new Ghostty window** opens showing the theme preview
3. Choose:
   - `[y]` - Apply theme to your config
   - `[n]` - Cancel (no changes)

**With fzf installed**: Fuzzy search theme selector
- Type to filter themes
- `↑↓` - Navigate
- `Enter` - Open preview window
- `Esc` - Cancel

**Without fzf**: Simple numbered selector
- Enter theme number to preview
- `n/p` - Next/prev page
- `q` - Quit

### Direct Commands

```bash
# Preview and apply a specific theme
ghostty-theme "Dracula"
ghostty-theme "TokyoNight"
ghostty-theme "Nord"

# Preview and apply a random theme
ghostty-theme random

# Quick light/dark mode
ghostty-theme light
ghostty-theme dark

# List all available themes
ghostty-theme list

# Show current theme
ghostty-theme current

# Show version
ghostty-theme version
```

## Applying Changes

After accepting a theme, reload your Ghostty config:
- **macOS**: `Cmd+Shift+,`
- **Linux**: `Ctrl+Shift+,`

## Uninstallation

```bash
./uninstall.sh
```

Or manually:

```bash
rm ~/.local/bin/ghostty-theme
rm -rf /tmp/ghostty-theme-preview
```

## Requirements

- Ghostty terminal emulator
- Bash or zsh shell
- fzf (optional, for fuzzy search)

## License

MIT
