# 🖥️ Dev-Kraken's Alacritty Configuration

A modern, GPU-accelerated terminal emulator configuration with beautiful themes and optimized performance.

## 📁 Structure

```
alacritty/
├── alacritty.toml      # Main configuration file
├── themes/             # Color scheme themes
└── README.md          # This file
```

## ⚡ Features

- **Modern TOML Configuration**: Using the latest Alacritty configuration format
- **Custom Color Schemes**: Beautiful themes in the themes directory
- **Performance Optimized**: GPU acceleration and optimized settings
- **Font Configuration**: Configured for development workflow
- **Key Bindings**: Enhanced shortcuts for productivity

## 🛠️ Installation

The installation script will automatically:
1. Create `~/.config/alacritty/` directory
2. Symlink configuration files
3. Set proper permissions

Manual installation:
```bash
# Create config directory
mkdir -p ~/.config/alacritty

# Symlink configuration
ln -sf $(pwd)/config/alacritty/alacritty.toml ~/.config/alacritty/
ln -sf $(pwd)/config/alacritty/themes ~/.config/alacritty/
```

## 🎨 Themes

Switch themes by modifying the `import` section in `alacritty.toml`:

```toml
import = [
    "~/.config/alacritty/themes/tokyo-night.toml"
]
```

Available themes in the `themes/` directory.

## ⌨️ Key Bindings

| Key Combination | Action |
|----------------|--------|
| `Ctrl + Shift + C` | Copy |
| `Ctrl + Shift + V` | Paste |
| `Ctrl + Shift + N` | New window |
| `Ctrl + Shift + Plus` | Increase font size |
| `Ctrl + Minus` | Decrease font size |
| `Ctrl + 0` | Reset font size |

## 🔧 Customization

### Font Configuration
Edit the `[font]` section in `alacritty.toml`:
```toml
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 12.0
```

### Colors
Modify the `[colors]` section or import theme files.

### Window Settings
Adjust window behavior in the `[window]` section.

## 📚 Documentation

- [Alacritty Configuration Reference](https://alacritty.org/config-alacritty.html)
- [Alacritty GitHub Repository](https://github.com/alacritty/alacritty)

## 🐛 Troubleshooting

### Common Issues

1. **Font not found**: Install the specified font family
2. **Config not loading**: Check file permissions and paths
3. **GPU issues**: Disable GPU acceleration temporarily

### Validation
```bash
# Validate configuration
alacritty --print-events
```

## 🔄 Updates

Configuration files are managed through this dotfiles repository. Pull latest changes and re-run the installation script to update. 