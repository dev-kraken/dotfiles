#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Installation Script
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_header() { echo -e "${PURPLE}🚀 $1${NC}"; }

# Check if running from dotfiles directory
check_location() {
    if [[ ! -f "$PWD/scripts/install.sh" ]]; then
        print_error "Please run this script from the dotfiles directory"
        print_info "cd ~/.dotfiles && ./scripts/install.sh"
        exit 1
    fi
    DOTFILES_DIR="$PWD"
}

# Create backup directory
create_backup() {
    print_header "Creating backup directory..."
    mkdir -p "$BACKUP_DIR"
    print_success "Backup directory created: $BACKUP_DIR"
}

# Backup existing configuration
backup_config() {
    local source_path="$1"
    local backup_name="$2"
    
    if [[ -e "$source_path" ]]; then
        print_info "Backing up existing $backup_name..."
        cp -r "$source_path" "$BACKUP_DIR/$backup_name"
        print_success "Backed up $backup_name"
    fi
}

# Create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    # Remove existing file/directory if it exists
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        rm -rf "$target"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    print_success "Linked $description"
}

# Install Neovim configuration
install_neovim() {
    print_header "Installing Neovim configuration..."
    
    # Backup existing config
    backup_config "$HOME/.config/nvim" "nvim"
    
    # Copy entire nvim configuration
    if [[ -d "$HOME/.config/nvim" ]]; then
        cp -r "$HOME/.config/nvim" "$DOTFILES_DIR/config/"
        print_success "Copied current Neovim config to dotfiles"
    fi
    
    # Create symlink
    create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim" "Neovim configuration"
}

# Install tmux configuration
install_tmux() {
    print_header "Installing tmux configuration..."
    
    # Backup existing configs
    backup_config "$HOME/.config/tmux" "tmux-config"
    backup_config "$HOME/.tmux.conf" "tmux.conf"
    
    # Copy existing tmux configuration
    if [[ -d "$HOME/.config/tmux" ]]; then
        cp -r "$HOME/.config/tmux"/* "$DOTFILES_DIR/config/tmux/" 2>/dev/null || true
        print_success "Copied current tmux config to dotfiles"
    fi
    
    # Create symlinks
    create_symlink "$DOTFILES_DIR/config/tmux" "$HOME/.config/tmux" "tmux configuration directory"
    
    # Link main tmux.conf if it exists in dotfiles
    if [[ -f "$DOTFILES_DIR/config/tmux/tmux.conf" ]]; then
        create_symlink "$DOTFILES_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf" "tmux.conf"
    fi
}

# Install ZSH configuration
install_zsh() {
    print_header "Installing ZSH configuration..."
    
    # Backup existing configs
    backup_config "$HOME/.zshrc" "zshrc"
    backup_config "$HOME/.p10k.zsh" "p10k.zsh"
    backup_config "$HOME/.zshenv" "zshenv"
    
    # Copy existing zsh configuration
    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$DOTFILES_DIR/config/zsh/"
        print_success "Copied current .zshrc to dotfiles"
    fi
    
    if [[ -f "$HOME/.p10k.zsh" ]]; then
        cp "$HOME/.p10k.zsh" "$DOTFILES_DIR/config/zsh/"
        print_success "Copied current .p10k.zsh to dotfiles"
    fi
    
    # Create symlinks
    create_symlink "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.zshrc" "ZSH configuration"
    
    if [[ -f "$DOTFILES_DIR/config/zsh/.p10k.zsh" ]]; then
        create_symlink "$DOTFILES_DIR/config/zsh/.p10k.zsh" "$HOME/.p10k.zsh" "Powerlevel10k configuration"
    fi
}

# Install Git configuration
install_git() {
    print_header "Installing Git configuration..."
    
    # Backup existing config
    backup_config "$HOME/.gitconfig" "gitconfig"
    backup_config "$HOME/.gitignore_global" "gitignore_global"
    
    # Create symlinks
    if [[ -f "$DOTFILES_DIR/config/git/.gitconfig" ]]; then
        create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig" "Git configuration"
    fi
    
    if [[ -f "$DOTFILES_DIR/config/git/.gitignore_global" ]]; then
        create_symlink "$DOTFILES_DIR/config/git/.gitignore_global" "$HOME/.gitignore_global" "Global gitignore"
        
        # Configure git to use global gitignore
        git config --global core.excludesfile ~/.gitignore_global
        print_success "Configured Git to use global gitignore"
    fi
    
    print_warning "Remember to update your name and email in ~/.gitconfig"
}

# Install Alacritty configuration
install_alacritty() {
    print_header "Installing Alacritty configuration..."
    
    # Backup existing config
    backup_config "$HOME/.config/alacritty" "alacritty"
    
    # Copy existing alacritty configuration
    if [[ -d "$HOME/.config/alacritty" ]]; then
        cp -r "$HOME/.config/alacritty"/* "$DOTFILES_DIR/config/alacritty/" 2>/dev/null || true
        print_success "Copied current Alacritty config to dotfiles"
    fi
    
    # Create symlinks
    create_symlink "$DOTFILES_DIR/config/alacritty" "$HOME/.config/alacritty" "Alacritty configuration directory"
    
    # Link individual files if they exist
    if [[ -f "$DOTFILES_DIR/config/alacritty/alacritty.toml" ]]; then
        create_symlink "$DOTFILES_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml" "Alacritty configuration"
    fi
    
    if [[ -d "$DOTFILES_DIR/config/alacritty/themes" ]]; then
        create_symlink "$DOTFILES_DIR/config/alacritty/themes" "$HOME/.config/alacritty/themes" "Alacritty themes"
    fi
}

# Set up Oh My ZSH and plugins
setup_oh_my_zsh() {
    print_header "Setting up Oh My ZSH and plugins..."
    
    # Install Oh My ZSH if not installed
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Installing Oh My ZSH..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My ZSH installed"
    else
        print_info "Oh My ZSH already installed"
    fi
    
    # Install Powerlevel10k theme
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
        print_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
        print_success "Powerlevel10k theme installed"
    else
        print_info "Powerlevel10k theme already installed"
    fi
    
    # Install ZSH plugins
    local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    
    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
        print_success "zsh-autosuggestions installed"
    fi
    
    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
        print_success "zsh-syntax-highlighting installed"
    fi
}

# Set up NVM and Node.js
setup_nvm() {
    print_header "Setting up NVM (Node Version Manager)..."
    
    # Install NVM if not installed
    if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
        print_info "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        
        # Source NVM to make it available immediately
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        
        print_success "NVM installed"
    else
        print_info "NVM already installed"
        # Source NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi
    
    # Install latest LTS Node.js if no version is installed
    if ! command -v node &> /dev/null; then
        print_info "Installing Node.js LTS..."
        nvm install --lts
        nvm use --lts
        nvm alias default node
        print_success "Node.js LTS installed and set as default"
    else
        local node_version=$(node --version)
        print_info "Node.js already available ($node_version)"
    fi
    
    # Install essential global packages for LSP servers
    print_info "Installing essential NPM packages for development..."
    npm install -g typescript-language-server > /dev/null 2>&1 || print_warning "Failed to install typescript-language-server"
    npm install -g vscode-langservers-extracted > /dev/null 2>&1 || print_warning "Failed to install vscode-langservers-extracted"
    npm install -g @tailwindcss/language-server > /dev/null 2>&1 || print_warning "Failed to install tailwindcss-language-server"
    print_success "Essential LSP servers installed"
}

# Install tmux plugins
setup_tmux_plugins() {
    print_header "Setting up tmux plugins..."
    
    # Install TPM if not installed
    if [[ ! -d "$HOME/.config/tmux/.tmux/plugins/tpm" ]]; then
        print_info "Installing Tmux Plugin Manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/.tmux/plugins/tpm"
        print_success "TPM installed"
    fi
    
    # Run tmux plugin installation script if it exists
    if [[ -f "$HOME/.config/tmux/install-plugins.sh" ]]; then
        print_info "Installing tmux plugins..."
        bash "$HOME/.config/tmux/install-plugins.sh"
    fi
}

# Set ZSH as default shell
set_zsh_default() {
    print_header "Setting ZSH as default shell..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        print_info "Changing default shell to ZSH..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to ZSH"
        print_warning "Please log out and log back in for the change to take effect"
    else
        print_info "ZSH is already the default shell"
    fi
}

# Main installation function
main() {
    print_header "Dev-Kraken's Dotfiles Installation"
    echo
    
    # Check location
    check_location
    
    # Create backup
    create_backup
    
    # Install configurations
    install_neovim
    install_tmux  
    install_zsh
    install_git
    install_alacritty
    
    # Setup tools
    setup_oh_my_zsh
    setup_nvm
    setup_tmux_plugins
    
    # Set default shell
    set_zsh_default
    
    echo
    print_header "Installation completed successfully! 🎉"
    echo
    print_info "Backup created at: $BACKUP_DIR"
    print_info "Dotfiles directory: $DOTFILES_DIR"
    echo
    print_warning "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
    print_info "Run 'p10k configure' to customize your Powerlevel10k prompt"
    echo
    print_success "Enjoy your new development environment!"
}

# Run main function
main "$@" 