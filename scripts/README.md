# 🚀 Dev-Kraken's Dotfiles Scripts

This directory contains automated scripts for managing the dotfiles installation, updates, and maintenance.

## 📜 Available Scripts

### 🔧 Core Scripts

#### `install.sh`
**Purpose**: Main installation script for setting up the entire development environment.

**Usage:**
```bash
./scripts/install.sh                    # Install all components
./scripts/install.sh --component zsh    # Install specific component
./scripts/install.sh --help             # Show help
```

**Features:**
- ✅ Automatic backup creation
- ✅ Modular component installation
- ✅ NVM and Node.js setup
- ✅ ZSH, Oh My ZSH, and plugins
- ✅ Tmux Plugin Manager (TPM)
- ✅ Symlink management
- ✅ LSP server installation

**Components:**
- `zsh` - ZSH configuration and Oh My ZSH setup
- `nvim` - Neovim configuration and plugins
- `tmux` - Tmux configuration and plugins
- `alacritty` - Alacritty terminal configuration
- `git` - Git configuration and global settings

#### `validate.sh`
**Purpose**: Comprehensive validation of the dotfiles installation.

**Usage:**
```bash
./scripts/validate.sh
```

**Checks:**
- ✅ Core tools availability (nvim, tmux, zsh, git, alacritty)
- ✅ Configuration file symlinks
- ✅ Plugin managers (Oh My ZSH, TPM)
- ✅ NVM and Node.js installation
- ✅ Shell configuration

#### `uninstall.sh`
**Purpose**: Clean removal of dotfiles with backup restoration options.

**Usage:**
```bash
./scripts/uninstall.sh                  # Interactive uninstallation
./scripts/uninstall.sh --force          # Force removal without prompts
./scripts/uninstall.sh --restore-backup # Restore from backup
```

**Features:**
- 🗑️ Safe symlink removal
- 📦 Backup restoration
- 🛡️ Configuration preservation options
- 🔍 Dry-run mode available

#### `update.sh`
**Purpose**: Update dotfiles and plugins to latest versions.

**Usage:**
```bash
./scripts/update.sh                     # Update all components
./scripts/update.sh --no-plugins        # Skip plugin updates
./scripts/update.sh --component zsh     # Update specific component
```

**Updates:**
- 📥 Pull latest dotfiles from repository
- 🔌 Update Neovim plugins (Lazy.nvim)
- 🎨 Update ZSH plugins and themes
- 📦 Update tmux plugins (TPM)
- 🔄 Refresh configuration symlinks

#### `backup.sh`
**Purpose**: Create comprehensive backups of current configurations.

**Usage:**
```bash
./scripts/backup.sh                     # Create timestamped backup
./scripts/backup.sh --custom-name       # Specify backup name
./scripts/backup.sh --include-plugins   # Include plugin directories
```

**Backup Contents:**
- 📁 Configuration directories (~/.config/nvim, ~/.config/tmux, etc.)
- 📄 Individual config files (.zshrc, .gitconfig, etc.)
- 🔌 Plugin directories (optional)
- 📋 System information and installed packages list

#### `init-repo.sh`
**Purpose**: Initialize a new dotfiles repository from scratch.

**Usage:**
```bash
./scripts/init-repo.sh                  # Initialize new repo
./scripts/init-repo.sh --from-existing  # Import existing configs
```

**Features:**
- 🏗️ Repository structure creation
- 📝 Template file generation
- 🔗 Git repository initialization
- 📋 Documentation generation

## 🎯 Usage Examples

### Fresh Installation
```bash
# Clone the repository
git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Make scripts executable
chmod +x scripts/*

# Install everything
./scripts/install.sh

# Validate installation
./scripts/validate.sh
```

### Partial Installation
```bash
# Install only ZSH and Neovim
./scripts/install.sh --component zsh,nvim

# Install Git configuration only
./scripts/install.sh --component git
```

### Maintenance Workflow
```bash
# Create backup before updates
./scripts/backup.sh

# Update to latest
./scripts/update.sh

# Validate everything is working
./scripts/validate.sh
```

### Development Setup with NVM
```bash
# The install script automatically sets up NVM
./scripts/install.sh

# After installation, NVM is ready to use
nvm install 18.17.0    # Install specific Node.js version
nvm use 18.17.0        # Use specific version
nvm alias default 18   # Set as default

# Project-specific Node.js version
echo "18.17.0" > .nvmrc
nvm use                # Auto-uses version from .nvmrc
```

## 🔧 Script Configuration

### Environment Variables

```bash
# Dotfiles directory (auto-detected)
export DOTFILES_DIR="$HOME/.dotfiles"

# Backup directory naming
export BACKUP_PREFIX=".dotfiles-backup"

# Component selection
export INSTALL_COMPONENTS="zsh,nvim,tmux,alacritty,git"

# NVM configuration
export NVM_VERSION="v0.39.0"
export NODE_VERSION="--lts"
```

### Customization

#### Local Overrides
Create `scripts/config.local` for machine-specific settings:
```bash
# Custom backup location
BACKUP_DIR="$HOME/Backups/dotfiles"

# Skip certain components
SKIP_COMPONENTS="alacritty"

# Custom NVM directory
NVM_DIR="$HOME/.nvm-custom"
```

#### Hook Scripts
Add custom logic with hook scripts:
- `scripts/hooks/pre-install.sh` - Run before installation
- `scripts/hooks/post-install.sh` - Run after installation
- `scripts/hooks/pre-update.sh` - Run before updates
- `scripts/hooks/post-update.sh` - Run after updates

## 🛡️ Safety Features

### Automatic Backups
All scripts create timestamped backups before making changes:
```
~/.dotfiles-backup-20240527-143022/
├── nvim/
├── tmux/
├── zshrc
├── gitconfig
└── backup-info.txt
```

### Dry Run Mode
Test operations without making changes:
```bash
./scripts/install.sh --dry-run
./scripts/uninstall.sh --dry-run
./scripts/update.sh --dry-run
```

### Validation Checks
Scripts include comprehensive validation:
- ✅ Symlink integrity
- ✅ File permissions
- ✅ Tool availability
- ✅ Configuration syntax

## 🔍 Troubleshooting

### Common Issues

#### Permission Denied
```bash
# Fix script permissions
chmod +x scripts/*.sh

# Or run with bash explicitly
bash scripts/install.sh
```

#### Symlink Conflicts
```bash
# Remove conflicting files
rm ~/.zshrc ~/.tmux.conf ~/.gitconfig

# Re-run installation
./scripts/install.sh
```

#### NVM Installation Issues
```bash
# Manual NVM installation
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Source NVM in current session
source ~/.zshrc

# Install Node.js
nvm install --lts
nvm use --lts
```

### Debug Mode
Run scripts with debug output:
```bash
bash -x scripts/install.sh    # Debug installation
bash -x scripts/validate.sh   # Debug validation
```

### Log Files
Scripts generate logs in `/tmp/dotfiles-*.log`:
```bash
tail -f /tmp/dotfiles-install.log
tail -f /tmp/dotfiles-update.log
```

## 📚 Development

### Adding New Scripts
1. Create script in `scripts/` directory
2. Follow naming convention: `action.sh`
3. Include proper header and documentation
4. Add error handling and validation
5. Update this README

### Script Template
```bash
#!/bin/bash

# ==========================================
# Description of what this script does
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

# Main function
main() {
    print_info "Starting script execution..."
    
    # Script logic here
    
    print_success "Script completed successfully!"
}

# Run main function
main "$@"
```

### Testing Scripts
```bash
# Test with shellcheck
shellcheck scripts/*.sh

# Test with different shells
bash scripts/install.sh --dry-run
zsh scripts/install.sh --dry-run

# Test error conditions
# (manually introduce errors to test error handling)
```

## 📖 References

- [Bash Best Practices](https://bertvv.github.io/cheat-sheets/Bash.html)
- [Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [NVM Documentation](https://github.com/nvm-sh/nvm)
- [Dotfiles Best Practices](https://dotfiles.github.io/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-script`
3. Add your script with proper documentation
4. Test thoroughly on different systems
5. Submit a pull request

Remember to follow the existing code style and include comprehensive error handling! 