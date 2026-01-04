# Ghostty Theme Switcher

A simple command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator.

## Features

- **200+ built-in themes** - Access all Ghostty's built-in themes
- **Interactive selection** - Pick themes visually with fzf or numbered menu
- **Quick commands** - Set light/dark themes, random theme, or specific themes
- **Cross-platform** - Works on macOS and Linux
- **Safe** - Automatically backs up your config before making changes

## Installation

### Quick install

```bash
# Clone the repository
git clone https://github.com/yourusername/ghostty-theme-switch.git
cd ghostty-theme-switch

# Run the installer
./install.sh
```

### Manual install

```bash
# Copy the script to your PATH
cp src/ghostty-theme ~/.local/bin/
chmod +x ~/.local/bin/ghostty-theme

# Make sure ~/.local/bin is in your PATH
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

```bash
# Interactive theme selector (with fzf if available)
ghostty-theme

# List all available themes
ghostty-theme list

# Show current theme
ghostty-theme current

# Set a specific theme
ghostty-theme "Dracula"
ghostty-theme "Tokyo Night"
ghostty-theme "Nord"

# Random theme
ghostty-theme random

# Quick light/dark mode
ghostty-theme light
ghostty-theme dark

# Show help
ghostty-theme --help
```

## Applying Changes

After switching themes, reload your Ghostty config:

- **macOS**: Press `Cmd+Shift+,`
- **Linux**: Press `Ctrl+Shift+,`

Or restart Ghostty.

## Examples

```bash
# See what themes are available
ghostty-theme list

# Try a dark theme
ghostty-theme "Dracula"

# Switch to a light theme for daytime
ghostty-theme light

# Feeling adventurous? Try a random theme
ghostty-theme random
```

## Uninstallation

```bash
./uninstall.sh
```

Or manually remove:

```bash
rm ~/.local/bin/ghostty-theme
```

## Requirements

- Ghostty terminal emulator
- Bash shell
- `fzf` (optional, for better interactive selection)

## License

MIT
