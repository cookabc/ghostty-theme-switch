# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator with **in-terminal preview**.

## Features

- **200+ built-in themes** - Access all Ghostty's built-in themes
- **In-terminal preview** - Preview panel showing theme info while browsing
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

- **Left panel**: Theme list (fuzzy search with typing)
- **Right panel**: Preview showing theme name, colors, and sample code
- `↑↓` - Navigate themes
- `Enter` - Apply selected theme
- `Esc` - Cancel

### Direct Commands

```bash
# Apply a specific theme
ghostty-theme "Dracula"
ghostty-theme "TokyoNight"
ghostty-theme "Nord"

# Apply a random theme
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

After applying a theme, reload your Ghostty config:
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
- fzf (optional, for fuzzy search and preview)

## License

MIT
