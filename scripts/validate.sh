#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Validation Script
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_header() { echo -e "${PURPLE}🔍 $1${NC}"; }

# Validation functions
validate_symlink() {
    local target="$1"
    local description="$2"
    
    if [[ -L "$target" ]]; then
        local link_target=$(readlink "$target")
        if [[ -e "$link_target" ]]; then
            print_success "$description is properly linked"
            return 0
        else
            print_error "$description link is broken: $link_target"
            return 1
        fi
    elif [[ -e "$target" ]]; then
        print_warning "$description exists but is not a symlink"
        return 0
    else
        print_error "$description is missing"
        return 1
    fi
}

validate_command() {
    local cmd="$1"
    local description="$2"
    
    if command -v "$cmd" &> /dev/null; then
        print_success "$description is available"
        return 0
    else
        print_error "$description is not available"
        return 1
    fi
}

# Main validation
main() {
    print_header "Validating Dev-Kraken's Dotfiles Installation"
    echo
    
    local errors=0
    
    # Check core tools
    print_header "Checking core tools..."
    validate_command "nvim" "Neovim" || ((errors++))
    validate_command "tmux" "Tmux" || ((errors++))
    validate_command "zsh" "ZSH" || ((errors++))
    validate_command "git" "Git" || ((errors++))
    validate_command "alacritty" "Alacritty" || ((errors++))
    
    # Check NVM and Node.js
    if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
        print_success "NVM is installed"
        # Source NVM to check Node.js
        source "$HOME/.nvm/nvm.sh"
        if command -v node &> /dev/null; then
            local node_version=$(node --version)
            print_success "Node.js is available via NVM ($node_version)"
        else
            print_warning "NVM is installed but no Node.js version is active"
        fi
    else
        print_warning "NVM is not installed (needed for LSP servers)"
    fi
    echo
    
    # Check configurations
    print_header "Checking configuration files..."
    validate_symlink "$HOME/.config/nvim" "Neovim configuration" || ((errors++))
    validate_symlink "$HOME/.config/tmux" "Tmux configuration" || ((errors++))
    validate_symlink "$HOME/.zshrc" "ZSH configuration" || ((errors++))
    validate_symlink "$HOME/.config/alacritty" "Alacritty configuration" || ((errors++))
    validate_symlink "$HOME/.gitconfig" "Git configuration" || ((errors++))
    validate_symlink "$HOME/.gitignore_global" "Global gitignore" || ((errors++))
    echo
    
    # Check optional configurations
    print_header "Checking optional configurations..."
    validate_symlink "$HOME/.p10k.zsh" "Powerlevel10k configuration" || print_info "Powerlevel10k config not found (optional)"
    echo
    
    # Check plugin managers
    print_header "Checking plugin managers..."
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_success "Oh My ZSH is installed"
    else
        print_error "Oh My ZSH is not installed"
        ((errors++))
    fi
    
    if [[ -d "$HOME/.config/tmux/.tmux/plugins/tpm" ]]; then
        print_success "TPM (Tmux Plugin Manager) is installed"
    else
        print_warning "TPM is not installed"
    fi
    echo
    
    # Check shell
    print_header "Checking shell configuration..."
    if [[ "$SHELL" == *"zsh" ]]; then
        print_success "ZSH is the default shell"
    else
        print_warning "ZSH is not the default shell (current: $SHELL)"
    fi
    echo
    
    # Summary
    if [[ $errors -eq 0 ]]; then
        print_header "Validation completed successfully! 🎉"
        print_success "All core configurations are properly installed"
    else
        print_header "Validation completed with $errors error(s)"
        print_error "Some configurations need attention"
        echo
        print_info "To fix issues, try running: ./scripts/install.sh"
    fi
}

# Run validation
main "$@" 