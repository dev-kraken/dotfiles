# Installation Guide

This guide provides detailed instructions for installing Dev-Kraken's dotfiles on different systems.

## Prerequisites

Before installing, ensure you have the following tools installed:

### Essential Tools

```bash
# Git (for cloning and version control)
sudo pacman -S git

# ZSH (shell)
sudo pacman -S zsh

# Neovim (text editor)
sudo pacman -S neovim

# Tmux (terminal multiplexer) 
sudo pacman -S tmux

# NVM (Node Version Manager) - for LSP servers and development
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.zshrc
nvm install --lts
nvm use --lts

# Python (for some Neovim plugins)
sudo pacman -S python python-pip

# Ripgrep (for searching)
sudo pacman -S ripgrep

# fd (for file finding)
sudo pacman -S fd
```

### Optional Tools

```bash
# Modern replacements for traditional tools
sudo pacman -S eza              # Modern ls replacement
sudo pacman -S zoxide           # Smart cd replacement  
sudo pacman -S fzf              # Fuzzy finder
sudo pacman -S bat              # Better cat with syntax highlighting
sudo pacman -S delta            # Better git diff
sudo pacman -S htop             # Process viewer
sudo pacman -S tree             # Directory tree viewer

# Development tools
sudo pacman -S docker           # Containerization
sudo pacman -S docker-compose   # Container orchestration
sudo pacman -S kubectl          # Kubernetes CLI
sudo pacman -S terraform        # Infrastructure as code
```

## Installation Methods

### Method 1: Quick Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles

# Run the installation script
cd ~/.dotfiles && chmod +x scripts/* && ./scripts/install.sh
```

### Method 2: Manual Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Make scripts executable**:
   ```bash
   chmod +x scripts/*
   ```

3. **Create backup** (optional but recommended):
   ```bash
   ./scripts/backup.sh
   ```

4. **Install configurations**:
   ```bash
   ./scripts/install.sh
   ```

### Method 3: Step-by-Step Manual Setup

If you prefer to set up components individually:

#### 1. Install Oh My ZSH
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### 2. Install Powerlevel10k Theme
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### 3. Install ZSH Plugins
```bash
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### 4. Install Tmux Plugin Manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
```

#### 5. Create Symlinks
```bash
# Neovim
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim

# Tmux
ln -sf ~/.dotfiles/config/tmux ~/.config/tmux
ln -sf ~/.dotfiles/config/tmux/tmux.conf ~/.tmux.conf

# ZSH
ln -sf ~/.dotfiles/config/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/config/zsh/.p10k.zsh ~/.p10k.zsh
```

## Post-Installation Setup

### 1. Configure Powerlevel10k
```bash
# Run the configuration wizard
p10k configure
```

### 2. Install Tmux Plugins
```bash
# Start tmux and press prefix + I (Space + I by default)
tmux new-session -d
tmux send-keys 'C-Space I' C-m
```

### 3. Set ZSH as Default Shell
```bash
chsh -s $(which zsh)
```

### 4. Install Neovim Plugins
```bash
# Open Neovim - plugins will auto-install
nvim
```

### 5. Verify Installation
```bash
# Check health
nvim -c ":checkhealth"

# Test tmux
tmux new-session -s test

# Test ZSH features
help-devkraken
```

## System-Specific Instructions

### Arch Linux
All commands above use `pacman`. AUR packages can be installed with `yay`:

```bash
# Install yay if not present
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

# Install AUR packages
yay -S eza zoxide
```

### Ubuntu/Debian
Replace `pacman` commands with `apt`:

```bash
sudo apt update && sudo apt install -y git zsh neovim tmux python3 python3-pip ripgrep fd-find

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm use --lts
```

### macOS
Use Homebrew:

```bash
brew install git zsh neovim tmux python ripgrep fd eza zoxide fzf bat delta htop tree

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.zshrc
nvm install --lts
nvm use --lts
```

## Configuration Options

### Environment Variables

Set these in your environment if needed:

```bash
# Disable welcome message
export DEVKRAKEN_WELCOME=false

# Custom tmux config location
export TMUX_CONF=~/.config/tmux/tmux.conf

# Neovim configuration name
export NVIM_APPNAME=nvim
```

### Git Configuration

Update your Git information:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Troubleshooting

### Common Issues

1. **Permission denied on scripts**:
   ```bash
   chmod +x ~/.dotfiles/scripts/*
   ```

2. **ZSH not found**:
   ```bash
   # Install ZSH first
   sudo pacman -S zsh
   ```

3. **Neovim plugins not loading**:
   ```bash
   # Clear plugin cache and reinstall
   rm -rf ~/.local/share/nvim
   nvim
   ```

4. **Tmux plugins not working**:
   ```bash
   # Reload tmux config
   tmux source-file ~/.config/tmux/tmux.conf
   # Install plugins manually
   ~/.config/tmux/.tmux/plugins/tpm/scripts/install_plugins.sh
   ```

5. **Fonts not displaying correctly**:
   Install a Nerd Font:
   ```bash
   # Download and install a patched font
   mkdir -p ~/.local/share/fonts
   wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
   unzip FiraCode.zip -d ~/.local/share/fonts/
   fc-cache -fv
   ```

## Updating

To update your dotfiles installation:

```bash
cd ~/.dotfiles
./scripts/update.sh
```

## Uninstalling

To remove the dotfiles configuration:

```bash
cd ~/.dotfiles
./scripts/uninstall.sh
```

This will:
- Remove all symlinks
- Optionally restore from backup
- Optionally remove the dotfiles directory

## Next Steps

After installation:

1. Read the [customization guide](customization.md)
2. Check out the [troubleshooting guide](troubleshooting.md)
3. Restart your terminal
4. Start using your new development environment!

## Support

If you encounter issues:

1. Check the troubleshooting guide
2. Run `help-devkraken` for available functions
3. Check Neovim health: `:checkhealth`
4. Open an issue on the repository 