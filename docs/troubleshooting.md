# Troubleshooting Guide

This guide helps you resolve common issues with Dev-Kraken's dotfiles configuration.

## 🔍 Quick Diagnosis

### Run the Validation Script

Before troubleshooting specific issues, always start with:

```bash
cd ~/.dotfiles
./scripts/validate.sh
```

This will identify most configuration problems automatically.

## 🐚 ZSH Issues

### ZSH Not Starting Properly

**Symptoms:**
- Shell falls back to bash
- Error messages on terminal startup
- Missing prompt theme

**Solutions:**

1. **Check if ZSH is installed:**
   ```bash
   which zsh
   # Should return: /usr/bin/zsh or /bin/zsh
   ```

2. **Set ZSH as default shell:**
   ```bash
   chsh -s $(which zsh)
   # Log out and back in
   ```

3. **Test ZSH configuration:**
   ```bash
   zsh -n ~/.zshrc
   # Should return no errors
   ```

4. **Reset ZSH configuration:**
   ```bash
   cd ~/.dotfiles
   ./scripts/install.sh
   ```

### Powerlevel10k Theme Issues

**Symptoms:**
- Prompt shows incorrect characters
- Missing icons or symbols
- Slow prompt rendering

**Solutions:**

1. **Install a Nerd Font:**
   ```bash
   # Download and install JetBrainsMono Nerd Font
   mkdir -p ~/.local/share/fonts
   cd ~/.local/share/fonts
   curl -fLo "JetBrainsMono Regular Nerd Font Complete.ttf" \
     https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
   fc-cache -fv
   ```

2. **Reconfigure Powerlevel10k:**
   ```bash
   p10k configure
   ```

3. **Check terminal font settings:**
   - Ensure your terminal uses a Nerd Font
   - Set font size to 12-14pt for best results

### Oh My ZSH Plugin Errors

**Symptoms:**
- Plugin not found errors
- Command not found for plugin commands
- Slow shell startup

**Solutions:**

1. **Reinstall plugins:**
   ```bash
   cd ~/.dotfiles
   rm -rf ~/.oh-my-zsh/custom/plugins/zsh-*
   ./scripts/install.sh
   ```

2. **Check plugin directory:**
   ```bash
   ls -la ~/.oh-my-zsh/custom/plugins/
   # Should show: zsh-autosuggestions, zsh-syntax-highlighting
   ```

3. **Manual plugin installation:**
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
   ```

## 🔧 Neovim Issues

### Neovim Won't Start

**Symptoms:**
- Error messages on startup
- Plugins not loading
- Configuration errors

**Solutions:**

1. **Check Neovim version:**
   ```bash
   nvim --version
   # Should be 0.8.0 or higher
   ```

2. **Test configuration:**
   ```bash
   nvim --headless -c "checkhealth" -c "qa"
   ```

3. **Reset Neovim configuration:**
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.cache/nvim
   nvim
   # Let Lazy.nvim reinstall plugins
   ```

### LSP Servers Not Working

**Symptoms:**
- No autocompletion
- No error highlighting
- Missing hover information

**Solutions:**

1. **Check LSP status:**
   ```vim
   :LspInfo
   :checkhealth lsp
   ```

2. **Install missing LSP servers with NVM:**
   ```bash
   # Ensure NVM is installed
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   source ~/.zshrc
   
   # Install Node.js and LSP servers
   nvm install --lts
   nvm use --lts
   npm install -g typescript-language-server
   npm install -g vscode-langservers-extracted
   npm install -g @tailwindcss/language-server
   ```

3. **Restart Neovim and check:**
   ```vim
   :LspRestart
   :checkhealth lsp
   ```

### Plugin Manager Issues

**Symptoms:**
- Plugins not installing
- Lazy.nvim errors
- Missing plugin functionality

**Solutions:**

1. **Clean plugin directory:**
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.cache/nvim
   ```

2. **Reinstall plugins:**
   ```bash
   nvim
   # Wait for automatic installation
   ```

3. **Manual sync:**
   ```vim
   :Lazy sync
   :Lazy update
   ```

## 🖥️ Tmux Issues

### Tmux Won't Start

**Symptoms:**
- Configuration errors
- Server startup failed
- Plugin loading errors

**Solutions:**

1. **Test configuration:**
   ```bash
   tmux -f ~/.config/tmux/tmux.conf new-session -d test
   tmux list-sessions
   tmux kill-session -t test
   ```

2. **Check tmux version:**
   ```bash
   tmux -V
   # Should be 3.0 or higher
   ```

3. **Reset tmux configuration:**
   ```bash
   cd ~/.dotfiles
   rm -rf ~/.config/tmux/.tmux/plugins
   ./scripts/install.sh
   ```

### Plugin Manager (TPM) Issues

**Symptoms:**
- Plugins not loading
- TPM not found
- Plugin installation failed

**Solutions:**

1. **Install TPM:**
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
   ```

2. **Install plugins:**
   ```bash
   ~/.config/tmux/.tmux/plugins/tpm/bin/install_plugins
   ```

3. **Or use the provided script:**
   ```bash
   ~/.config/tmux/install-plugins.sh
   ```

### Tmux-Neovim Navigation Issues

**Symptoms:**
- Ctrl+h/j/k/l not working
- Can't navigate between tmux and nvim

**Solutions:**

1. **Check plugin installation:**
   ```bash
   ls -la ~/.config/tmux/.tmux/plugins/vim-tmux-navigator
   ```

2. **Verify Neovim plugin:**
   ```vim
   :checkhealth vim-tmux-navigator
   ```

3. **Reinstall navigation plugin:**
   ```bash
   cd ~/.config/tmux/.tmux/plugins
   rm -rf vim-tmux-navigator
   git clone https://github.com/christoomey/vim-tmux-navigator
   ```

## 🖥️ Alacritty Issues

### Theme Not Loading

**Symptoms:**
- Default colors showing
- Theme file not found
- Configuration errors

**Solutions:**

1. **Check theme path:**
   ```bash
   ls -la ~/.config/alacritty/themes/
   ```

2. **Verify configuration:**
   ```bash
   alacritty --print-events
   ```

3. **Fix theme import:**
   ```toml
   # In alacritty.toml
   [general]
   import = [
     "~/.config/alacritty/themes/catppuccin_mocha.toml"
   ]
   ```

### Font Issues

**Symptoms:**
- Font not found warnings
- Incorrect font rendering
- Missing ligatures

**Solutions:**

1. **Install required font:**
   ```bash
   # Install Iosevka Term or JetBrainsMono Nerd Font
   mkdir -p ~/.local/share/fonts
   # Download and install font files
   fc-cache -fv
   ```

2. **Update font configuration:**
   ```toml
   [font.normal]
   family = "JetBrainsMono Nerd Font"  # Use installed font
   ```

## 🐙 Git Issues

### Git Configuration Not Applied

**Symptoms:**
- Wrong name/email in commits
- Aliases not working
- Global gitignore not active

**Solutions:**

1. **Check git configuration:**
   ```bash
   git config --list --show-origin
   ```

2. **Verify symlinks:**
   ```bash
   ls -la ~/.gitconfig ~/.gitignore_global
   ```

3. **Reinstall git configuration:**
   ```bash
   cd ~/.dotfiles
   ./scripts/install.sh
   ```

4. **Set personal information:**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@domain.com"
   ```

## 🚀 NVM and Node.js Issues

### NVM Not Found

**Symptoms:**
- `nvm: command not found`
- Node.js commands not working
- LSP servers failing

**Solutions:**

1. **Install NVM:**
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   source ~/.zshrc
   ```

2. **Install Node.js:**
   ```bash
   nvm install --lts
   nvm use --lts
   nvm alias default node
   ```

3. **Verify installation:**
   ```bash
   node --version
   npm --version
   ```

### Node Version Issues

**Symptoms:**
- Wrong Node.js version
- Package installation failures
- LSP server compatibility issues

**Solutions:**

1. **Check current version:**
   ```bash
   nvm current
   nvm list
   ```

2. **Use correct version:**
   ```bash
   nvm use --lts
   nvm alias default node
   ```

3. **Project-specific version:**
   ```bash
   # Create .nvmrc in project root
   echo "18.17.0" > .nvmrc
   nvm use
   ```

## 🔧 Permission Issues

### Symlink Creation Failed

**Symptoms:**
- Permission denied errors
- Symlinks not created
- Installation script fails

**Solutions:**

1. **Check file permissions:**
   ```bash
   ls -la ~/.dotfiles/config/
   ```

2. **Fix permissions:**
   ```bash
   chmod -R 755 ~/.dotfiles/
   ```

3. **Remove existing files:**
   ```bash
   rm -f ~/.zshrc ~/.tmux.conf ~/.gitconfig
   ./scripts/install.sh
   ```

## 📊 Performance Issues

### Slow Shell Startup

**Symptoms:**
- Long delay when opening terminal
- Slow command execution
- High CPU usage

**Solutions:**

1. **Profile ZSH startup:**
   ```bash
   time zsh -i -c exit
   ```

2. **Disable unnecessary plugins:**
   ```bash
   # Edit .zshrc and comment out slow plugins
   ```

3. **Compile ZSH configuration:**
   ```bash
   zcompile ~/.zshrc
   ```

### Slow Neovim Startup

**Symptoms:**
- Long Neovim load times
- Plugin loading delays
- High memory usage

**Solutions:**

1. **Profile startup:**
   ```bash
   nvim --startuptime startup.log
   ```

2. **Optimize plugin loading:**
   ```lua
   -- Use lazy loading in plugin configuration
   {
     "plugin/name",
     lazy = true,
     event = "VeryLazy"
   }
   ```

## 🆘 Emergency Reset

### Complete Reset

If all else fails, completely reset the configuration:

```bash
# Backup current settings
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
cp ~/.tmux.conf ~/.tmux.conf.backup 2>/dev/null || true

# Remove all configuration
rm -rf ~/.config/nvim ~/.config/tmux ~/.config/alacritty
rm -f ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.gitignore_global ~/.p10k.zsh

# Reinstall everything
cd ~/.dotfiles
git pull
./scripts/install.sh

# Restore personal settings
git config --global user.name "Your Name"
git config --global user.email "your.email@domain.com"
```

### Partial Reset

Reset specific components:

```bash
# Reset only ZSH
rm -f ~/.zshrc ~/.p10k.zsh
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-*
./scripts/install.sh

# Reset only Neovim
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
./scripts/install.sh

# Reset only Tmux
rm -rf ~/.config/tmux ~/.tmux.conf
./scripts/install.sh
```

## 📞 Getting More Help

### Check Health Commands

```bash
# Overall validation
./scripts/validate.sh

# ZSH health
zsh -n ~/.zshrc

# Neovim health
nvim -c ":checkhealth" -c ":qa"

# Tmux health
tmux info

# Git health
git config --list
```

### Log Files and Debugging

```bash
# ZSH debug mode
zsh -x

# Neovim with verbose logging
nvim -V9nvim.log

# Tmux with verbose logging
tmux -v new-session

# Alacritty debug
alacritty --print-events
```

### Community Resources

- [Neovim GitHub Issues](https://github.com/neovim/neovim/issues)
- [Oh My ZSH GitHub](https://github.com/ohmyzsh/ohmyzsh)
- [Tmux Manual](https://man.openbsd.org/OpenBSD-current/man1/tmux.1)
- [Alacritty Configuration Guide](https://alacritty.org/config-alacritty.html)

Remember: Always backup your working configuration before making changes! 