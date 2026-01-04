# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator with **live preview**.

## Features

- **Live Preview** - See themes in action before applying them
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

### Interactive Mode (with preview)

```bash
# Open interactive theme selector
ghostty-theme

# Select a theme, preview it in a new window, then decide to keep or discard
```

### Direct Commands

```bash
# Preview and apply a specific theme
ghostty-theme "Dracula"
ghostty-theme "Tokyo Night"
ghostty-theme "Nord"

# Preview a random theme
ghostty-theme random

# Quick light/dark mode
ghostty-theme light
ghostty-theme dark

# List all available themes
ghostty-theme list

# Show current theme
ghostty-theme current

# Apply theme WITHOUT preview (direct)
ghostty-theme --no-preview "Nord"

# Show help
ghostty-theme --help
```

## How Preview Works

1. Select a theme (via interactive mode or direct command)
2. A **new Ghostty window opens** with the selected theme applied
3. The preview window asks you to confirm:
   - **[y]** Yes - Apply the theme to your config
   - **[n]** No - Cancel and close (no changes made)
   - **[r]** Refresh - Clear the screen and show the prompt again
4. If you accept, the theme is saved to your config file

## Examples

```bash
# Browse themes interactively and preview before applying
ghostty-theme

# Preview Dracula theme
ghostty-theme "Dracula"

# Feeling adventurous? Preview a random theme
ghostty-theme random

# Skip preview and apply directly
ghostty-theme --no-preview "Nord"
```

## Applying Changes

After accepting a theme, reload your Ghostty config to see it in all windows:

- **macOS**: Press `Cmd+Shift+,`
- **Linux**: Press `Ctrl+Shift+,`

Or restart Ghostty.

## Uninstallation

```bash
./uninstall.sh
```

Or manually remove:

```bash
rm ~/.local/bin/ghostty-theme
rm -rf /tmp/ghostty-theme-preview
```

## Requirements

- Ghostty terminal emulator
- Bash shell
- `fzf` (optional, for better interactive selection)

## License

MIT
