# 🚀 Dev-Kraken's Dotfiles

A comprehensive collection of configuration files for a modern development environment featuring Neovim, ZSH with Powerlevel10k, tmux, and Alacritty.

## 📁 Repository Structure

```
dotfiles/
├── config/
│   ├── alacritty/         # Alacritty terminal configuration
│   ├── git/               # Git configuration and global gitignore
│   ├── nvim/              # Neovim configuration
│   ├── tmux/              # Tmux configuration  
│   └── zsh/               # ZSH configuration
├── scripts/
│   ├── install.sh         # Main installation script
│   ├── validate.sh        # Validate installation
│   ├── backup.sh          # Backup existing configs
│   ├── update.sh          # Update configurations
│   └── uninstall.sh       # Remove symlinks
├── docs/
│   ├── installation.md    # Installation guide
│   ├── customization.md   # Customization options
│   └── troubleshooting.md # Common issues
└── README.md              # This file
```

## ✨ Features

### 🖥️ Alacritty Configuration
- **Modern TOML configuration** format
- **GPU-accelerated rendering** for smooth performance
- **Custom themes collection** with easy switching
- **Font optimization** for development
- **Enhanced key bindings** for productivity

### 🐙 Git Configuration
- **Developer-friendly aliases** for common commands
- **Colored output** for better readability
- **Global gitignore** covering multiple languages and frameworks
- **Modern defaults** (main branch, auto-setup remote)
- **Neovim integration** as default editor

### 🔧 Neovim Configuration
- **Modern Lua-based setup** with lazy.nvim plugin manager
- **LSP support** for PHP, JavaScript/TypeScript, HTML/CSS, and more
- **Catppuccin Mocha theme** for beautiful UI
- **Enhanced completion** with nvim-cmp
- **File explorer** with nvim-tree
- **Fuzzy finding** with Telescope
- **Git integration** with fugitive and gitsigns
- **Terminal integration** with toggleterm
- **DevOps tools** for Docker, Kubernetes, and more

### 🐚 ZSH Configuration  
- **Powerlevel10k theme** with instant prompt
- **Oh My ZSH** with curated plugins
- **Smart aliases** and custom functions
- **Developer shortcuts** for Git, Docker, NVM/Node.js
- **Modern tools** integration (eza, zoxide, fzf)
- **Enhanced history** management
- **Custom welcome message** system

### 🖥️ Tmux Configuration
- **Seamless Neovim integration** with vim-tmux-navigator
- **Catppuccin Mocha theme** matching Neovim
- **Smart key bindings** with Space prefix
- **Session management** with auto-save/restore
- **Status bar** with battery, time, and indicators
- **FZF integration** for fuzzy finding
- **Copy mode** with vim-style bindings

## 🚀 Quick Installation

```bash
# Clone the repository
git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles

# Run the installation script
cd ~/.dotfiles && ./scripts/install.sh
```

## 📋 Manual Installation

### Prerequisites

Ensure you have the following installed:
- **Git** - Version control
- **ZSH** - Shell
- **Neovim** 0.8+ - Text editor
- **Tmux** 3.0+ - Terminal multiplexer
- **Alacritty** - GPU-accelerated terminal emulator
- **NVM & Node.js** - For LSP servers and version management
- **Python** - For some Neovim plugins
- **Ripgrep** - For searching
- **fd** - For file finding

### Step-by-Step Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Backup existing configurations**:
   ```bash
   ./scripts/backup.sh
   ```

3. **Install configurations**:
   ```bash
   ./scripts/install.sh
   ```

4. **Install additional tools** (optional):
   ```bash
   # Install Powerlevel10k
   git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   
   # Install ZSH plugins
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

## 🎨 Customization

### Theme Consistency
All configurations use the **Catppuccin Mocha** theme for visual consistency:
- Neovim: Dark theme with warm colors
- Tmux: Matching status bar and window styling  
- ZSH: Powerlevel10k with compatible colors

### Key Bindings
Consistent key bindings across all tools:
- **Space** as leader/prefix key
- **Ctrl+h/j/k/l** for navigation
- **Vim-style** bindings throughout

### Environment Variables
The configurations set up a complete development environment:
```bash
EDITOR=nvim
VISUAL=nvim
TMUX_CONF=~/.config/tmux/tmux.conf
```

## 🛠️ Available Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `install.sh` | Install all configurations | `./scripts/install.sh` |
| `validate.sh` | Validate installation | `./scripts/validate.sh` |
| `backup.sh` | Backup existing configs | `./scripts/backup.sh` |
| `update.sh` | Update from repository | `./scripts/update.sh` |
| `uninstall.sh` | Remove symlinks | `./scripts/uninstall.sh` |

## 📝 Custom Functions

The ZSH configuration includes many custom functions:

### Development
- `mkcd <dir>` - Create and enter directory
- `project <name>` - Quick project setup
- `ghopen` - Open GitHub repo in browser
- `artisan <cmd>` - Laravel artisan shortcut

### System Management  
- `pskill <name>` - Kill process by name
- `portfind <port>` - Find process using port
- `sysupdate` - Update system packages
- `dcleanup` - Clean Docker resources

### Utilities
- `extract <file>` - Extract any archive
- `backup <file>` - Create timestamped backup
- `weather [city]` - Get weather info
- `note [text]` - Quick note taking

## 🔄 Updating

To update your configurations from the repository:

```bash
cd ~/.dotfiles
git pull
./scripts/update.sh
```

## 🆘 Troubleshooting

### Validation First
Before troubleshooting specific issues, run the validation script:
```bash
./scripts/validate.sh
```

### Common Issues

1. **Neovim LSP not working**:
   ```bash
   :checkhealth
   :LspInfo
   ```

2. **Tmux plugins not loading**:
   ```bash
   # Install tmux plugins
   ~/.config/tmux/install-plugins.sh
   ```

3. **ZSH theme issues**:
   ```bash
   # Reconfigure Powerlevel10k
   p10k configure
   ```

4. **Alacritty not loading themes**:
   ```bash
   # Check configuration
   alacritty --print-events
   ```

### Getting Help

- Run `./scripts/validate.sh` to check your installation
- Check the [docs/](docs/) directory for detailed guides:
  - [Installation Guide](docs/installation.md) - Complete setup instructions
  - [Customization Guide](docs/customization.md) - Personalize your environment
  - [Troubleshooting Guide](docs/troubleshooting.md) - Fix common issues
  - [FAQ](docs/faq.md) - Frequently asked questions
  - [Scripts Documentation](scripts/README.md) - Script usage and development
- Run `help-devkraken` in ZSH for custom function help
- Use `welcome` command to see environment status

## 📄 License

This configuration is available under the MIT License. Feel free to use, modify, and share!

## 🙏 Acknowledgments

- [Neovim](https://neovim.io/) - The hyperextensible Vim-based text editor
- [Oh My ZSH](https://ohmyz.sh/) - Framework for managing ZSH configuration
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Fast and flexible ZSH theme
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Soothing pastel theme
- [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer

---

**Author**: dev-kraken  
**Last Updated**: 2025  
**Version**: 1.0.0 