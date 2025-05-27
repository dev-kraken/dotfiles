# 🐚 Dev-Kraken's ZSH Configuration

A powerful ZSH setup featuring Oh My Zsh, Powerlevel10k theme, and extensive customizations for developers.

## 📁 Structure

```
zsh/
├── .zshrc      # Main ZSH configuration (619 lines)
├── .p10k.zsh   # Powerlevel10k theme configuration
└── README.md   # This file
```

## ⚡ Features

- **Oh My ZSH framework** with curated plugins
- **Powerlevel10k theme** with instant prompt
- **Extensive aliases** for development workflows
- **Custom functions** for productivity
- **Modern tools integration** (eza, zoxide, fzf)
- **Enhanced history** management
- **Smart welcome system** with environment status

## 🔧 Key Components

### Core Configuration
- **History**: 50,000 entries with deduplication
- **Environment Variables**: Development-focused setup
- **XDG Base Directory** compliance
- **Plugin Management**: Carefully selected Oh My ZSH plugins

### Plugin List
- `git` - Git integration
- `zsh-autosuggestions` - Command suggestions
- `zsh-syntax-highlighting` - Syntax highlighting
- `docker` - Docker commands
- `kubectl` - Kubernetes integration
- `npm`, `nvm`, `python` - Language/version management
- `vscode`, `extract`, `web-search` - Utilities

### 🎨 Enhanced Aliases

#### File Operations (eza integration)
```bash
ls="eza --group-directories-first --icons"
ll="eza --long --header --group --icons --group-directories-first --git"
lt="eza --tree --level=2 --icons --group-directories-first"
```

#### Development Shortcuts
```bash
# Git
g="git"
ga="git add"
gc="git commit"
gp="git push"
gs="git status"

# Docker
d="docker"
dc="docker-compose"
dps="docker ps"

# Kubernetes
k="kubectl"
kgp="kubectl get pods"
```

#### System Management
```bash
# Navigation
..="cd .."
~="cd ~"

# Editors
vim="nvim"
v="nvim"

# System
ports="netstat -tulanp"
myip="curl -s ifconfig.me && echo"
```

### 🛠️ Custom Functions

#### Development
- `mkcd <dir>` - Create and enter directory
- `project <name>` - Quick project setup with git init
- `ghopen` - Open current repo in browser
- `npmclean` - Clean npm cache and node_modules (NVM managed)

#### System Utilities
- `pskill <name>` - Kill process by name
- `portfind <port>` - Find process using port
- `portkill <port>` - Kill process using specific port
- `extract <file>` - Extract any archive format
- `backup <file>` - Create timestamped backup

#### DevOps
- `sysupdate` - Update system packages (Arch Linux)
- `dcleanup` - Clean Docker containers and images
- `devkrakenssl <domain>` - Generate SSL certificates

#### Utilities
- `weather [city]` - Get weather information
- `note [text]` - Quick note taking system
- `search <pattern> <dir>` - Search in files

## 🎯 Powerlevel10k Configuration

### Features Enabled
- **Instant Prompt** for fast startup
- **Git status** integration
- **Command execution time**
- **Exit code** display
- **Background jobs** indicator
- **Node.js version** via NVM when in projects
- **Python virtual environment** detection

### Customization
Run `p10k configure` to customize the prompt appearance:
```bash
p10k configure
```

## 🔄 Environment Setup

### Development Tools
```bash
EDITOR=nvim
VISUAL=nvim
PAGER=less
BROWSER=firefox
```

### Path Configuration
```bash
PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
GOPATH="$HOME/go"
GOBIN="$GOPATH/bin"
```

### XDG Directories
```bash
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
```

## 🆘 Help System

### Built-in Help
- `help-devkraken` - List all custom functions
- `welcome` - Show environment status
- `devkraken_welcome` - Show welcome message

### Welcome Message Control
```bash
# Disable welcome message
export DEVKRAKEN_WELCOME=false

# Show only on manual request
export DEVKRAKEN_WELCOME=quiet
```

## 🛠️ Installation

The installation script will:
1. Install Oh My ZSH if not present
2. Install Powerlevel10k theme
3. Install required plugins
4. Create symlinks to configuration files

Manual installation:
```bash
# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Symlink configuration
ln -sf $(pwd)/config/zsh/.zshrc ~/.zshrc
ln -sf $(pwd)/config/zsh/.p10k.zsh ~/.p10k.zsh
```

## 🎨 Theme Integration

This ZSH configuration is designed to work seamlessly with:
- **Neovim**: Catppuccin Mocha theme
- **Tmux**: Matching status bar colors
- **Alacritty**: Coordinated terminal colors

## 🔧 Customization

### Adding Custom Aliases
Add to the end of `.zshrc`:
```bash
# Personal aliases
alias myalias="my command"
```

### Adding Custom Functions
```bash
my_function() {
    echo "Custom function"
}
```

### Local Customizations
Create `~/.zshrc.local` for machine-specific settings:
```bash
# This file is sourced automatically
export LOCAL_VAR="value"
```

## 📚 Dependencies

### Required
- **ZSH** - Shell
- **Git** - Version control
- **curl** - For installations

### Recommended
- **eza** - Modern ls replacement
- **zoxide** - Smart cd replacement
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative

## 🔄 Updates

Configuration is managed through the dotfiles repository. To update:
```bash
cd ~/.dotfiles
git pull
./scripts/update.sh
```

## 🐛 Troubleshooting

### Common Issues

1. **Slow startup**: Check instant prompt configuration
2. **Missing icons**: Install a Nerd Font
3. **Plugin errors**: Reinstall Oh My ZSH plugins
4. **Theme issues**: Run `p10k configure`

### Validation
```bash
# Check ZSH installation
./scripts/validate.sh

# Test configuration
zsh -n ~/.zshrc
```

## 📖 Resources

- [Oh My ZSH Documentation](https://ohmyz.sh/)
- [Powerlevel10k Guide](https://github.com/romkatv/powerlevel10k)
- [ZSH Manual](https://zsh.sourceforge.io/Doc/)
- [Modern Unix Commands](https://github.com/ibraheemdev/modern-unix) 