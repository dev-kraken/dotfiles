#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Backup Script
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_header() { echo -e "${PURPLE}🚀 $1${NC}"; }

# Backup function
backup_file() {
    local source="$1"
    local name="$2"
    
    if [[ -e "$source" ]]; then
        print_info "Backing up $name..."
        cp -r "$source" "$BACKUP_DIR/"
        print_success "Backed up $name"
        return 0
    else
        print_warning "$name not found, skipping..."
        return 1
    fi
}

# Main backup function
main() {
    print_header "Dev-Kraken's Dotfiles Backup"
    echo
    
    # Create backup directory
    print_info "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    
    # Counter for backed up files
    local backed_up=0
    
    # Backup configurations
    print_header "Backing up existing configurations..."
    
    # Neovim
    if backup_file "$HOME/.config/nvim" "nvim"; then
        ((backed_up++))
    fi
    
    # Tmux
    if backup_file "$HOME/.config/tmux" "tmux"; then
        ((backed_up++))
    fi
    
    if backup_file "$HOME/.tmux.conf" ".tmux.conf"; then
        ((backed_up++))
    fi
    
    # ZSH
    if backup_file "$HOME/.zshrc" ".zshrc"; then
        ((backed_up++))
    fi
    
    if backup_file "$HOME/.zshenv" ".zshenv"; then
        ((backed_up++))
    fi
    
    if backup_file "$HOME/.p10k.zsh" ".p10k.zsh"; then
        ((backed_up++))
    fi
    
    # Git
    if backup_file "$HOME/.gitconfig" ".gitconfig"; then
        ((backed_up++))
    fi
    
    if backup_file "$HOME/.gitignore_global" ".gitignore_global"; then
        ((backed_up++))
    fi
    
    # Oh My ZSH (partial backup - just custom directory)
    if backup_file "$HOME/.oh-my-zsh/custom" "oh-my-zsh-custom"; then
        ((backed_up++))
    fi
    
    echo
    print_header "Backup completed! 🎉"
    print_success "Backed up $backed_up configuration(s)"
    print_info "Backup location: $BACKUP_DIR"
    
    if [[ $backed_up -eq 0 ]]; then
        print_warning "No configurations found to backup"
        print_info "This might be a fresh system or configurations are in different locations"
    fi
    
    echo
    print_info "You can restore from this backup by copying files back to their original locations"
    print_info "To remove this backup: rm -rf $BACKUP_DIR"
}

# Run main function
main "$@" 