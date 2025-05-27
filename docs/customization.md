# Customization Guide

This guide explains how to customize Dev-Kraken's dotfiles to suit your personal preferences and workflow.

## 🎨 Theme Customization

### Consistent Theme Across All Tools

All configurations use the **Catppuccin Mocha** theme for visual consistency:

- **Neovim**: Dark theme with warm colors
- **Tmux**: Matching status bar and window styling  
- **Alacritty**: Coordinated terminal colors
- **ZSH**: Powerlevel10k with compatible colors

### Changing the Global Theme

To change the theme across all tools:

1. **Alacritty**: Edit `config/alacritty/alacritty.toml`
   ```toml
   [general]
   import = [
     "~/.config/alacritty/themes/dracula.toml"  # Change theme here
   ]
   ```

2. **Neovim**: Edit `config/nvim/lua/dev-kraken/plugins/ui.lua`
   ```lua
   return {
     "catppuccin/nvim",
     name = "catppuccin",
     config = function()
       vim.cmd.colorscheme "catppuccin-mocha"  -- Change variant here
     end
   }
   ```

3. **Tmux**: Edit `config/tmux/tmux.conf`
   ```bash
   # Look for theme settings and update accordingly
   ```

## ⌨️ Key Bindings Customization

### ZSH Custom Aliases

Add personal aliases to `config/zsh/.zshrc`:

```bash
# Personal aliases - add at the end of the file
alias myproject="cd ~/Projects/my-important-project"
alias serve="python -m http.server 8000"
alias weather-home="weather 'New York'"
```

### Custom ZSH Functions

Add to `config/zsh/.zshrc`:

```bash
# Custom function example
my_deploy() {
    if [ $# -ne 1 ]; then
        echo "Usage: my_deploy <environment>"
        return 1
    fi
    
    echo "Deploying to $1..."
    # Add your deployment logic here
}
```

### Neovim Key Mappings

Edit `config/nvim/lua/dev-kraken/core/keymaps.lua`:

```lua
-- Add custom keymaps
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Test Current File" })
```

### Tmux Key Bindings

Edit `config/tmux/tmux.conf`:

```bash
# Custom key bindings
bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
```

## 🔧 Tool-Specific Customization

### Git Configuration

Edit `config/git/.gitconfig`:

```ini
[user]
    name = Your Actual Name
    email = your.real.email@domain.com

[alias]
    # Add custom aliases
    unstash = stash pop
    graph = log --graph --oneline --decorate
    
[core]
    # Customize editor
    editor = code --wait  # Use VS Code instead of nvim
```

### Alacritty Font Configuration

Edit `config/alacritty/alacritty.toml`:

```toml
[font]
size = 16  # Increase font size

[font.normal]
family = "JetBrainsMono Nerd Font"  # Change font family
style = "Regular"
```

### Powerlevel10k Prompt

Customize prompt elements:

```bash
# Run the configuration wizard
p10k configure

# Or edit ~/.p10k.zsh directly for advanced customization
```

## 🚀 Development Environment Customization

### NVM Configuration

The ZSH configuration includes NVM setup. Customize in `config/zsh/.zshrc`:

```bash
# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto-use node version in projects
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

### LSP Servers (Neovim)

Add language servers in `config/nvim/lua/dev-kraken/plugins/lsp/servers.lua`:

```lua
-- Add support for new languages
servers = {
  -- Existing servers...
  
  -- Add new language server
  rust_analyzer = {},
  gopls = {},
  pyright = {},
}
```

### Docker Integration

Add Docker compose shortcuts to `config/zsh/.zshrc`:

```bash
# Docker Compose shortcuts for specific projects
alias dc-up="docker-compose up -d"
alias dc-down="docker-compose down"
alias dc-logs="docker-compose logs -f"
alias dc-rebuild="docker-compose down && docker-compose build && docker-compose up -d"
```

## 📂 Project-Specific Customization

### Per-Project Configuration

Create `.dotfiles.local` in project directories:

```bash
# Project-specific aliases and functions
alias test="npm run test:watch"
alias build="npm run build:prod"
alias deploy="./scripts/deploy.sh"

# Project-specific environment
export API_URL="http://localhost:3000"
export DEBUG_MODE=true
```

Source in your shell:

```bash
# Add to .zshrc
load_project_config() {
    if [[ -f ".dotfiles.local" ]]; then
        source ".dotfiles.local"
        echo "Loaded project-specific configuration"
    fi
}

# Auto-load when changing directories
add-zsh-hook chpwd load_project_config
```

### Workspace-Specific Settings

Create `~/.zshrc.local` for machine-specific configuration:

```bash
# Machine-specific settings that won't be committed
export WORK_DIR="/path/to/work/projects"
export PERSONAL_DIR="/path/to/personal/projects"

# Machine-specific aliases
alias work="cd $WORK_DIR"
alias personal="cd $PERSONAL_DIR"

# Different git configuration for work
work_git() {
    git config user.email "work.email@company.com"
    git config user.name "Work Name"
}
```

## 🔍 Plugin Customization

### Neovim Plugins

Add new plugins in `config/nvim/lua/dev-kraken/plugins/`:

```lua
-- Create new plugin file: config/nvim/lua/dev-kraken/plugins/my-plugins.lua
return {
  {
    "new/plugin",
    config = function()
      -- Plugin configuration
    end
  }
}
```

### ZSH Plugins

Add Oh My ZSH plugins in `config/zsh/.zshrc`:

```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    # Add new plugins here
    kubectl
    aws
    terraform
)
```

### Tmux Plugins

Add plugins in `config/tmux/tmux.conf`:

```bash
# Add new tmux plugins
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'new/tmux-plugin'

# Plugin-specific configuration
set -g @resurrect-capture-pane-contents 'on'
```

## 🎯 Performance Customization

### Faster Shell Startup

Optimize ZSH loading:

```bash
# Disable features you don't use
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# Use compiled .zshrc
compile_zshrc() {
    zcompile ~/.zshrc
}
```

### Neovim Performance

Optimize in `config/nvim/lua/dev-kraken/core/options.lua`:

```lua
-- Performance settings
vim.opt.lazyredraw = true
vim.opt.regexpengine = 1
vim.opt.updatetime = 250
```

## 📱 Platform-Specific Customization

### macOS Specific

```bash
# macOS-specific aliases in .zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias finder="open ."
    alias brew-update="brew update && brew upgrade"
fi
```

### Linux Specific

```bash
# Linux-specific configuration
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias open="xdg-open"
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
fi
```

### Windows (WSL) Specific

```bash
# WSL-specific settings
if grep -q microsoft /proc/version; then
    export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
    alias explorer="explorer.exe"
fi
```

## 🔄 Backup and Restore Customizations

### Backup Custom Settings

```bash
# Create backup of customizations
backup_custom() {
    tar -czf "dotfiles-custom-$(date +%Y%m%d).tar.gz" \
        ~/.zshrc.local \
        ~/.gitconfig.local \
        ~/.config/nvim/lua/custom/ \
        ~/Projects/.dotfiles.local
}
```

### Version Control Custom Settings

```bash
# Create separate git repo for customizations
mkdir ~/.dotfiles-custom
cd ~/.dotfiles-custom
git init
echo "# Personal Dotfiles Customizations" > README.md
```

## 🆘 Troubleshooting Customizations

### Reset to Defaults

```bash
# Reset specific configuration
./scripts/install.sh --component zsh
./scripts/install.sh --component nvim

# Full reset
./scripts/uninstall.sh
./scripts/install.sh
```

### Test Configurations

```bash
# Test ZSH config
zsh -n ~/.zshrc

# Test tmux config
tmux -f ~/.config/tmux/tmux.conf new-session -d test

# Validate Neovim config
nvim --headless -c "checkhealth" -c "qa"
```

## 📚 Advanced Customization Resources

- [Neovim Configuration Guide](https://neovim.io/doc/user/lua-guide.html)
- [ZSH Customization](https://zsh.sourceforge.io/Guide/)
- [Tmux Configuration](https://github.com/tmux/tmux/wiki)
- [Alacritty Configuration](https://alacritty.org/config-alacritty.html)
- [Oh My ZSH Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

Remember to test your customizations thoroughly and keep backups of working configurations! 