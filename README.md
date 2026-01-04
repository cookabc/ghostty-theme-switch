# Ghostty Theme Switcher

A command-line tool to quickly switch themes in the [Ghostty](https://ghostty.org) terminal emulator with **live preview**.

## Features

- **Live Preview with Arrow Keys** - Browse themes with ↑↓ keys, preview updates in real-time
- **200+ built-in themes** - Access all Ghostty's built-in themes
- **Interactive selection** - Pick themes visually with arrow keys or fzf
- **Quick commands** - Set light/dark themes, random theme, or specific themes
- **Cross-platform** - Works on macOS and Linux
- **Safe** - Automatically backs up your config before making changes

## Installation

### Quick install

```bash
git clone https://github.com/yourusername/ghostty-theme-switch.git
cd ghostty-theme-switch
./install.sh
```

### Manual install

```bash
cp src/ghostty-theme ~/.local/bin/
chmod +x ~/.local/bin/ghostty-theme
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

### Interactive Mode (Live Preview)

```bash
ghostty-theme
```

Use **arrow keys** to browse themes. A preview window shows the theme in real-time:
- `↑↓` - Navigate themes
- `Page Up/Down` - Jump by page
- `Home/End` - Jump to first/last theme
- `Enter` - Apply selected theme
- `Esc` or `q` - Cancel

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
```

## How Live Preview Works

1. Run `ghostty-theme` to start interactive mode
2. A **preview window** opens showing the current theme
3. In the main window, use **arrow keys** to browse
4. Each keypress updates the preview window instantly
5. Press **Enter** to apply, **Esc** to cancel

```
╔═══════════════════════════════════════════╗
║       Ghostty Theme Switcher             ║
╚═══════════════════════════════════════════╝
Current: Catppuccin Mocha  |  Previewing: Dracula

  0x96f
  12-bit Rainbow
  3024 Day
  ▶ Dracula         ← Selected
  Github
  Nord

[45/200]

  [↑↓] Navigate    [Enter] Apply    [Home/End] First/Last
  [PgUp/PgDn] Page    [Esc/q] Cancel
```

## Applying Changes

After accepting a theme, reload your Ghostty config to see it in all windows:
- **macOS**: Press `Cmd+Shift+,`
- **Linux**: Press `Ctrl+Shift+,`

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
- `fzf` (optional, for alternative interactive selection)

## License

MIT
