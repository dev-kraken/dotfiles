#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Uninstall Script
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
print_header() { echo -e "${PURPLE}🚀 $1${NC}"; }

# Remove symlink function
remove_symlink() {
    local target="$1"
    local description="$2"
    
    if [[ -L "$target" ]]; then
        print_info "Removing symlink: $description"
        rm "$target"
        print_success "Removed $description"
        return 0
    elif [[ -e "$target" ]]; then
        print_warning "$description exists but is not a symlink, skipping..."
        return 1
    else
        print_info "$description not found, skipping..."
        return 1
    fi
}

# Find and list backup directories
list_backups() {
    print_header "Available backups:"
    
    local backups=($(find "$HOME" -maxdepth 1 -name ".dotfiles-backup-*" -type d | sort -r))
    
    if [[ ${#backups[@]} -eq 0 ]]; then
        print_warning "No backup directories found"
        return 1
    fi
    
    for i in "${!backups[@]}"; do
        local backup_dir="${backups[$i]}"
        local timestamp=$(basename "$backup_dir" | sed 's/.dotfiles-backup-//')
        echo "  $((i+1)). $backup_dir (Created: $timestamp)"
    done
    
    return 0
}

# Restore from backup
restore_from_backup() {
    local backup_dir="$1"
    
    if [[ ! -d "$backup_dir" ]]; then
        print_error "Backup directory not found: $backup_dir"
        return 1
    fi
    
    print_header "Restoring from backup: $backup_dir"
    
    # Restore files
    local restored=0
    
    # Neovim
    if [[ -d "$backup_dir/nvim" ]]; then
        print_info "Restoring Neovim configuration..."
        rm -rf "$HOME/.config/nvim"
        cp -r "$backup_dir/nvim" "$HOME/.config/nvim"
        print_success "Neovim configuration restored"
        ((restored++))
    fi
    
    # Tmux
    if [[ -d "$backup_dir/tmux" ]]; then
        print_info "Restoring tmux configuration..."
        rm -rf "$HOME/.config/tmux"
        cp -r "$backup_dir/tmux" "$HOME/.config/tmux"
        print_success "Tmux configuration restored"
        ((restored++))
    fi
    
    if [[ -f "$backup_dir/.tmux.conf" ]]; then
        print_info "Restoring .tmux.conf..."
        cp "$backup_dir/.tmux.conf" "$HOME/.tmux.conf"
        print_success ".tmux.conf restored"
        ((restored++))
    fi
    
    # ZSH
    if [[ -f "$backup_dir/.zshrc" ]]; then
        print_info "Restoring .zshrc..."
        cp "$backup_dir/.zshrc" "$HOME/.zshrc"
        print_success ".zshrc restored"
        ((restored++))
    fi
    
    if [[ -f "$backup_dir/.p10k.zsh" ]]; then
        print_info "Restoring .p10k.zsh..."
        cp "$backup_dir/.p10k.zsh" "$HOME/.p10k.zsh"
        print_success ".p10k.zsh restored"
        ((restored++))
    fi
    
    if [[ -f "$backup_dir/.zshenv" ]]; then
        print_info "Restoring .zshenv..."
        cp "$backup_dir/.zshenv" "$HOME/.zshenv"
        print_success ".zshenv restored"
        ((restored++))
    fi
    
    # Git
    if [[ -f "$backup_dir/.gitconfig" ]]; then
        print_info "Restoring .gitconfig..."
        cp "$backup_dir/.gitconfig" "$HOME/.gitconfig"
        print_success ".gitconfig restored"
        ((restored++))
    fi
    
    if [[ -f "$backup_dir/.gitignore_global" ]]; then
        print_info "Restoring .gitignore_global..."
        cp "$backup_dir/.gitignore_global" "$HOME/.gitignore_global"
        print_success ".gitignore_global restored"
        ((restored++))
    fi
    
    # Oh My ZSH custom
    if [[ -d "$backup_dir/oh-my-zsh-custom" ]]; then
        print_info "Restoring Oh My ZSH custom directory..."
        rm -rf "$HOME/.oh-my-zsh/custom"
        cp -r "$backup_dir/oh-my-zsh-custom" "$HOME/.oh-my-zsh/custom"
        print_success "Oh My ZSH custom directory restored"
        ((restored++))
    fi
    
    print_success "Restored $restored configuration(s) from backup"
    return 0
}

# Interactive backup restoration
interactive_restore() {
    if ! list_backups; then
        return 1
    fi
    
    echo
    read -p "Enter backup number to restore from (or 'q' to skip): " choice
    
    if [[ "$choice" == "q" ]] || [[ "$choice" == "Q" ]]; then
        print_info "Skipping backup restoration"
        return 0
    fi
    
    local backups=($(find "$HOME" -maxdepth 1 -name ".dotfiles-backup-*" -type d | sort -r))
    local backup_index=$((choice - 1))
    
    if [[ $backup_index -ge 0 ]] && [[ $backup_index -lt ${#backups[@]} ]]; then
        restore_from_backup "${backups[$backup_index]}"
    else
        print_error "Invalid selection"
        return 1
    fi
}

# Main uninstall function
main() {
    print_header "Dev-Kraken's Dotfiles Uninstall"
    echo
    
    print_warning "This will remove all dotfiles symlinks"
    read -p "Are you sure you want to continue? (y/N): " confirm
    
    if [[ "$confirm" != "y" ]] && [[ "$confirm" != "Y" ]]; then
        print_info "Uninstall cancelled"
        exit 0
    fi
    
    print_header "Removing dotfiles symlinks..."
    
    # Counter for removed symlinks
    local removed=0
    
    # Remove symlinks
    if remove_symlink "$HOME/.config/nvim" "Neovim configuration"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.config/tmux" "tmux configuration"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.tmux.conf" ".tmux.conf"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.zshrc" ".zshrc"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.p10k.zsh" ".p10k.zsh"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.zshenv" ".zshenv"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.gitconfig" ".gitconfig"; then
        ((removed++))
    fi
    
    if remove_symlink "$HOME/.gitignore_global" ".gitignore_global"; then
        ((removed++))
    fi
    
    echo
    print_success "Removed $removed symlink(s)"
    
    # Ask about backup restoration
    echo
    print_header "Backup Restoration"
    print_info "Would you like to restore from a backup?"
    
    if interactive_restore; then
        print_success "Backup restoration completed"
    fi
    
    # Ask about removing dotfiles directory
    echo
    print_header "Cleanup"
    read -p "Remove dotfiles directory (~/.dotfiles)? (y/N): " remove_dotfiles
    
    if [[ "$remove_dotfiles" == "y" ]] || [[ "$remove_dotfiles" == "Y" ]]; then
        if [[ -d "$HOME/.dotfiles" ]]; then
            rm -rf "$HOME/.dotfiles"
            print_success "Dotfiles directory removed"
        else
            print_info "Dotfiles directory not found"
        fi
    fi
    
    # Ask about removing backups
    read -p "Remove all backup directories? (y/N): " remove_backups
    
    if [[ "$remove_backups" == "y" ]] || [[ "$remove_backups" == "Y" ]]; then
        local backups=($(find "$HOME" -maxdepth 1 -name ".dotfiles-backup-*" -type d))
        if [[ ${#backups[@]} -gt 0 ]]; then
            for backup in "${backups[@]}"; do
                rm -rf "$backup"
                print_success "Removed backup: $(basename "$backup")"
            done
        else
            print_info "No backup directories found"
        fi
    fi
    
    echo
    print_header "Uninstall completed! 🎉"
    echo
    print_info "Your configurations have been unlinked from the dotfiles repository"
    print_warning "Please restart your terminal to apply changes"
    
    if [[ $removed -eq 0 ]]; then
        print_warning "No symlinks were found to remove"
        print_info "Your configurations may not have been managed by dotfiles"
    fi
}

# Run main function
main "$@" 