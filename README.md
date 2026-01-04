# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator with preview.

## Features

- **200+ built-in themes** - Access all Ghostty's built-in themes
- **Interactive selection** - Browse themes with arrow keys
- **Theme preview** - See themes in a preview window before applying
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

### Interactive Mode

```bash
ghostty-theme
```

Use arrow keys to browse themes, then press `Enter` to preview and confirm:
- `↑↓` - Navigate themes
- `Page Up/Down` - Jump by page
- `Home/End` - Jump to first/last theme
- `Enter` - Open preview window to apply theme
- `Esc` or `q` - Cancel

### Direct Commands

```bash
# Preview and apply a specific theme
ghostty-theme "Dracula"
ghostty-theme "TokyoNight"
ghostty-theme "Nord"

# Preview a random theme
ghostty-theme random

# Quick light/dark mode
ghostty-theme light
ghostty-theme dark

# List all themes
ghostty-theme list

# Show current theme
ghostty-theme current

# Apply theme WITHOUT preview
ghostty-theme --no-preview "Nord"
```

## How It Works

1. Select a theme (interactive mode or direct command)
2. A **preview window** opens with the theme applied
3. Choose:
   - `[y]` - Apply theme to your config
   - `[n]` - Cancel (no changes)

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
- Bash shell

## License

MIT
