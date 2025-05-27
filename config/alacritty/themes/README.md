# 🎨 Alacritty Themes

A curated collection of terminal themes optimized for development work.

## 📦 Available Themes

| Theme | Description | Best For |
|-------|-------------|----------|
| `catppuccin_mocha.toml` | ⭐ **Default** - Warm, easy on eyes | Development, long sessions |
| `catppuccin_macchiato.toml` | Softer variant of mocha | Alternative dark theme |
| `dracula.toml` | Popular purple-based theme | Night coding |
| `gruvbox_dark.toml` | Retro warm colors | Vintage aesthetic |
| `nord.toml` | Cool blue Arctic colors | Clean, minimal look |

## 🔧 How to Switch Themes

Edit your `alacritty.toml` file and change the import line:

```toml
import = [
    "~/.config/alacritty/themes/catppuccin_mocha.toml"
]
```

Or remove the import section and the theme will use default colors.

## 🎯 Recommended Theme

**Catppuccin Mocha** is the default theme as it matches your Neovim and Tmux setup for a consistent development environment.

## 🔄 Adding More Themes

To add more themes:
1. Download a `.toml` theme file
2. Place it in this directory
3. Update your `alacritty.toml` import section

Popular theme sources:
- [Alacritty Themes Repository](https://github.com/alacritty/alacritty-theme)
- [Catppuccin for Alacritty](https://github.com/catppuccin/alacritty) 