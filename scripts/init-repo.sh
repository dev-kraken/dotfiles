#!/bin/bash

# ==========================================
# Dev-Kraken's Dotfiles Repository Initialization
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

# Check if running from dotfiles directory
check_location() {
    if [[ ! -f "$PWD/scripts/init-repo.sh" ]]; then
        print_error "Please run this script from the dotfiles directory"
        print_info "cd ~/.dotfiles && ./scripts/init-repo.sh"
        exit 1
    fi
}

# Initialize git repository
init_git() {
    print_header "Initializing Git repository..."
    
    if [[ -d ".git" ]]; then
        print_info "Git repository already exists"
        return 0
    fi
    
    # Initialize git
    git init
    print_success "Git repository initialized"
    
    # Add all files
    git add .
    print_success "Files staged for commit"
    
    # Create initial commit
    git commit -m "Initial commit: Dev-Kraken's dotfiles

- Complete Neovim configuration with LSP, completion, and modern UI
- ZSH configuration with Powerlevel10k and custom functions  
- Tmux configuration with seamless Neovim integration
- Installation, backup, update, and uninstall scripts
- Comprehensive documentation and troubleshooting guides

Features:
- Catppuccin Mocha theme consistency across all tools
- Smart keybindings with Space as leader/prefix
- Enhanced developer workflows for PHP, JS/TS, Docker
- Modern CLI tools integration (eza, zoxide, fzf)
- Automated plugin management and updates"
    
    print_success "Initial commit created"
}

# Set up remote repository (optional)
setup_remote() {
    print_header "Remote Repository Setup"
    
    echo
    read -p "Do you want to add a remote repository? (y/N): " add_remote
    
    if [[ "$add_remote" != "y" ]] && [[ "$add_remote" != "Y" ]]; then
        print_info "Skipping remote repository setup"
        return 0
    fi
    
    echo
    print_info "Enter your remote repository URL:"
    print_info "Examples:"
    print_info "  GitHub: https://github.com/dev-kraken/dotfiles.git"
    print_info "  GitLab: https://gitlab.com/dev-kraken/dotfiles.git"
    print_info "  SSH: git@github.com:dev-kraken/dotfiles.git"
    echo
    read -p "Remote URL: " remote_url
    
    if [[ -z "$remote_url" ]]; then
        print_warning "No URL provided, skipping remote setup"
        return 0
    fi
    
    # Add remote
    git remote add origin "$remote_url"
    print_success "Remote 'origin' added: $remote_url"
    
    # Ask about pushing
    echo
    read -p "Push to remote repository now? (y/N): " push_now
    
    if [[ "$push_now" == "y" ]] || [[ "$push_now" == "Y" ]]; then
        # Set upstream and push
        git branch -M main
        git push -u origin main
        print_success "Repository pushed to remote"
    else
        print_info "Repository ready for push. Use: git push -u origin main"
    fi
}

# Create additional helpful files
create_additional_files() {
    print_header "Creating additional repository files..."
    
    # Create LICENSE file if it doesn't exist
    if [[ ! -f "LICENSE" ]]; then
        cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 dev-kraken

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
        print_success "Created LICENSE file"
    fi
    
    # Create CHANGELOG.md if it doesn't exist
    if [[ ! -f "CHANGELOG.md" ]]; then
        cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-XX

### Added
- Initial release of Dev-Kraken's dotfiles
- Complete Neovim configuration with LSP support
- ZSH configuration with Powerlevel10k theme
- Tmux configuration with Neovim integration
- Installation and management scripts
- Comprehensive documentation

### Features
- Catppuccin Mocha theme consistency
- Modern development environment setup
- Automated plugin management
- Custom utility functions
- Cross-platform compatibility

[1.0.0]: https://github.com/dev-kraken/dotfiles/releases/tag/v1.0.0
EOF
        print_success "Created CHANGELOG.md"
    fi
    
    # Create CONTRIBUTING.md if it doesn't exist
    if [[ ! -f "CONTRIBUTING.md" ]]; then
        cat > CONTRIBUTING.md << 'EOF'
# Contributing to Dev-Kraken's Dotfiles

Thank you for your interest in contributing! This dotfiles repository is designed to be a comprehensive development environment setup.

## How to Contribute

### Reporting Issues
- Use the GitHub Issues page to report bugs or suggest features
- Include your OS, shell version, and terminal emulator
- Provide steps to reproduce any issues

### Contributing Code
1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test the changes thoroughly
5. Commit with descriptive messages
6. Push to your fork and create a Pull Request

### Areas for Contribution
- Additional language support and LSP configurations
- New utility functions and aliases
- Theme and UI improvements
- Platform-specific optimizations
- Documentation improvements

### Guidelines
- Follow the existing code style and organization
- Update documentation for any new features
- Test changes on different systems when possible
- Keep commits focused and atomic

## Development Setup

1. Clone your fork
2. Test changes in a virtual machine or isolated environment
3. Run the installation script to verify functionality
4. Check that all scripts work correctly

## Questions?

Feel free to open an issue for any questions about contributing!
EOF
        print_success "Created CONTRIBUTING.md"
    fi
}

# Generate repository statistics
show_stats() {
    print_header "Repository Statistics"
    
    echo
    print_info "📁 Directory structure:"
    tree -L 2 --dirsfirst 2>/dev/null || find . -type d -not -path '*/\.*' | head -20 | sort
    
    echo
    print_info "📝 File counts:"
    echo "  Configuration files: $(find config -type f | wc -l)"
    echo "  Scripts: $(find scripts -type f -name '*.sh' | wc -l)"
    echo "  Documentation: $(find . -name '*.md' | wc -l)"
    echo "  Total files: $(find . -type f -not -path '*/\.*' | wc -l)"
    
    if command -v git &> /dev/null && [[ -d ".git" ]]; then
        echo
        print_info "📊 Git information:"
        echo "  Repository: $(git rev-parse --show-toplevel)"
        echo "  Branch: $(git branch --show-current)"
        echo "  Commits: $(git rev-list --count HEAD)"
        echo "  Last commit: $(git log -1 --format="%h - %s (%cr)")"
        
        if git remote -v | grep -q origin; then
            echo "  Remote: $(git remote get-url origin)"
        fi
    fi
}

# Main initialization function
main() {
    print_header "Dev-Kraken's Dotfiles Repository Initialization"
    echo
    
    # Check location
    check_location
    
    # Initialize git repository
    init_git
    
    # Create additional files
    create_additional_files
    
    # Setup remote repository
    setup_remote
    
    # Show statistics
    show_stats
    
    echo
    print_header "Repository initialization completed! 🎉"
    echo
    print_success "Your dotfiles repository is ready!"
    echo
    print_info "Next steps:"
    print_info "1. Run ./scripts/install.sh to set up the dotfiles"
    print_info "2. Customize configurations as needed"
    print_info "3. Use ./scripts/update.sh to sync changes"
    print_info "4. Share your repository with others!"
    echo
    print_warning "Remember to review and update personal information in:"
    print_info "- Git configuration (config/zsh/.gitconfig)"
    print_info "- SSH keys and sensitive data"
    print_info "- Personal aliases and functions"
}

# Run main function
main "$@" 