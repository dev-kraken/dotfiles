#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Update Script
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_header() { echo -e "${PURPLE}🚀 $1${NC}"; }

# Check if running from dotfiles directory
check_location() {
    if [[ ! -f "$PWD/scripts/update.sh" ]] && [[ ! -d "$DOTFILES_DIR" ]]; then
        print_error "Dotfiles directory not found"
        print_info "Please run the install script first or clone the repository"
        exit 1
    fi
    
    if [[ -f "$PWD/scripts/update.sh" ]]; then
        DOTFILES_DIR="$PWD"
    fi
}

# Update repository
update_repo() {
    print_header "Updating dotfiles repository..."
    
    cd "$DOTFILES_DIR"
    
    # Check if it's a git repository
    if [[ ! -d ".git" ]]; then
        print_warning "Not a git repository, skipping git update"
        return 0
    fi
    
    # Get current branch
    local current_branch=$(git branch --show-current)
    print_info "Current branch: $current_branch"
    
    # Stash any local changes
    if ! git diff-index --quiet HEAD --; then
        print_info "Stashing local changes..."
        git stash push -m "Auto-stash before update $(date)"
    fi
    
    # Pull latest changes
    print_info "Pulling latest changes..."
    if git pull origin "$current_branch"; then
        print_success "Repository updated"
    else
        print_error "Failed to update repository"
        return 1
    fi
    
    # Apply stashed changes if any
    if git stash list | grep -q "Auto-stash before update"; then
        print_info "Applying stashed changes..."
        if git stash pop; then
            print_success "Stashed changes applied"
        else
            print_warning "Conflicts detected, please resolve manually"
            print_info "Run 'git status' to see conflicts"
        fi
    fi
}

# Update ZSH plugins
update_zsh_plugins() {
    print_header "Updating ZSH plugins..."
    
    local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    local themes_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
    
    # Update Oh My ZSH
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Updating Oh My ZSH..."
        cd "$HOME/.oh-my-zsh"
        git pull origin master
        print_success "Oh My ZSH updated"
    fi
    
    # Update Powerlevel10k
    if [[ -d "$themes_dir/powerlevel10k" ]]; then
        print_info "Updating Powerlevel10k..."
        cd "$themes_dir/powerlevel10k"
        git pull origin master
        print_success "Powerlevel10k updated"
    fi
    
    # Update zsh-autosuggestions
    if [[ -d "$plugins_dir/zsh-autosuggestions" ]]; then
        print_info "Updating zsh-autosuggestions..."
        cd "$plugins_dir/zsh-autosuggestions"
        git pull origin master
        print_success "zsh-autosuggestions updated"
    fi
    
    # Update zsh-syntax-highlighting
    if [[ -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        print_info "Updating zsh-syntax-highlighting..."
        cd "$plugins_dir/zsh-syntax-highlighting"
        git pull origin master
        print_success "zsh-syntax-highlighting updated"
    fi
}

# Update tmux plugins
update_tmux_plugins() {
    print_header "Updating tmux plugins..."
    
    local tpm_dir="$HOME/.config/tmux/.tmux/plugins/tpm"
    
    # Update TPM
    if [[ -d "$tpm_dir" ]]; then
        print_info "Updating Tmux Plugin Manager..."
        cd "$tpm_dir"
        git pull origin master
        print_success "TPM updated"
        
        # Update all tmux plugins
        print_info "Updating tmux plugins..."
        "$tpm_dir/scripts/update_plugin.sh" all
        print_success "Tmux plugins updated"
    fi
}

# Update Neovim plugins
update_neovim_plugins() {
    print_header "Updating Neovim plugins..."
    
    if command -v nvim &> /dev/null; then
        print_info "Updating Neovim plugins..."
        # Use headless mode to update plugins
        nvim --headless "+Lazy sync" +qa
        print_success "Neovim plugins updated"
    else
        print_warning "Neovim not found, skipping plugin update"
    fi
}

# Copy current configurations to dotfiles
sync_current_configs() {
    print_header "Syncing current configurations to dotfiles..."
    
    cd "$DOTFILES_DIR"
    
    # Sync Neovim config
    if [[ -d "$HOME/.config/nvim" ]] && [[ ! -L "$HOME/.config/nvim" ]]; then
        print_info "Syncing Neovim configuration..."
        rsync -av --delete "$HOME/.config/nvim/" "config/nvim/"
        print_success "Neovim config synced"
    fi
    
    # Sync tmux config
    if [[ -d "$HOME/.config/tmux" ]] && [[ ! -L "$HOME/.config/tmux" ]]; then
        print_info "Syncing tmux configuration..."
        rsync -av --delete "$HOME/.config/tmux/" "config/tmux/"
        print_success "Tmux config synced"
    fi
    
    # Sync ZSH config
    if [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]]; then
        print_info "Syncing ZSH configuration..."
        cp "$HOME/.zshrc" "config/zsh/.zshrc"
        print_success "ZSH config synced"
    fi
    
    if [[ -f "$HOME/.p10k.zsh" ]] && [[ ! -L "$HOME/.p10k.zsh" ]]; then
        print_info "Syncing Powerlevel10k configuration..."
        cp "$HOME/.p10k.zsh" "config/zsh/.p10k.zsh"
        print_success "Powerlevel10k config synced"
    fi
    
    # Sync Git config
    if [[ -f "$HOME/.gitconfig" ]] && [[ ! -L "$HOME/.gitconfig" ]]; then
        print_info "Syncing Git configuration..."
        cp "$HOME/.gitconfig" "config/zsh/.gitconfig"
        print_success "Git config synced"
    fi
}

# Reload configurations
reload_configs() {
    print_header "Reloading configurations..."
    
    # Reload ZSH configuration
    if [[ -n "$ZSH_VERSION" ]]; then
        print_info "Reloading ZSH configuration..."
        source "$HOME/.zshrc"
        print_success "ZSH configuration reloaded"
    fi
    
    # Reload tmux configuration
    if command -v tmux &> /dev/null && [[ -n "$TMUX" ]]; then
        print_info "Reloading tmux configuration..."
        tmux source-file "$HOME/.config/tmux/tmux.conf"
        print_success "Tmux configuration reloaded"
    fi
}

# Show update summary
show_summary() {
    print_header "Update Summary"
    echo
    print_info "✅ Repository updated"
    print_info "✅ ZSH plugins updated"
    print_info "✅ Tmux plugins updated"
    print_info "✅ Neovim plugins updated"
    print_info "✅ Configurations synced"
    print_info "✅ Configurations reloaded"
    echo
    print_success "All updates completed successfully! 🎉"
    echo
    print_warning "If you experience any issues, restart your terminal"
    print_info "Or run the install script again: ./scripts/install.sh"
}

# Main update function
main() {
    print_header "Dev-Kraken's Dotfiles Update"
    echo
    
    # Check location
    check_location
    
    # Update repository
    update_repo
    
    # Update plugins and tools
    update_zsh_plugins
    update_tmux_plugins
    update_neovim_plugins
    
    # Sync current configurations
    sync_current_configs
    
    # Reload configurations
    reload_configs
    
    # Show summary
    show_summary
}

# Run main function
main "$@" 