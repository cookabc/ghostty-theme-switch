# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator.

## Features

- **200+ built-in themes** - Access all Ghostty's built-in themes
- **Interactive browser** - Built-in TUI theme browser with live preview
- **fzf integration** - Quick fuzzy selection if fzf is available
- **Quick commands** - Set light/dark themes, random theme, or specific themes
- **Cross-platform** - Works on macOS and Linux
- **Safe** - Automatically backs up your config before making changes

## Installation

```bash
git clone https://github.com/yourusername/ghostty-theme-switch.git
cd ghostty-theme-switch
./install.sh
```

## Usage

### Interactive Mode (Built-in Browser)

```bash
ghostty-theme
```

Opens Ghostty's built-in theme browser with live preview:
- `↑↓` - Navigate themes
- `Page Up/Down` - Jump by page
- `Home/End` - Jump to first/last theme
- `Enter` - Apply theme to config
- `Esc` or `F1` - Exit

### Quick Select (fzf)

If you have [fzf](https://github.com/junegunn/fzf) installed:

```bash
ghostty-theme quick
# or
ghostty-theme -q
```

### Direct Commands

```bash
# Apply a specific theme directly
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
```

## Requirements

- Ghostty terminal emulator
- Bash or zsh shell
- fzf (optional, for `--quick` mode)

## License

MIT
