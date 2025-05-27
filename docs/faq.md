# Frequently Asked Questions (FAQ)

Common questions and answers about Dev-Kraken's dotfiles configuration.

## 🚀 General Questions

### Q: What are dotfiles?

**A:** Dotfiles are configuration files for various tools and applications on Unix-like systems. They're called "dotfiles" because they typically start with a dot (.) which makes them hidden by default. These files customize your development environment, including your shell, editor, terminal, and other tools.

### Q: Why should I use these dotfiles?

**A:** This configuration provides:
- **Consistent development environment** across machines
- **Modern tools integration** (eza, zoxide, fzf, etc.)
- **Powerful Neovim setup** with LSP, autocompletion, and debugging
- **Enhanced terminal experience** with tmux and Alacritty
- **Productivity features** like aliases, functions, and shortcuts
- **Professional-grade configuration** ready for enterprise use

### Q: Will these dotfiles work on my system?

**A:** The dotfiles are primarily designed for:
- **Linux** (tested on Arch Linux)
- **macOS** (with minor adjustments)
- **WSL on Windows** (Windows Subsystem for Linux)

Some features may need adaptation for other systems.

### Q: How do I keep my existing configuration?

**A:** Before installation:
1. Run `./scripts/backup.sh` to backup existing configurations
2. Review the backup to ensure nothing important is lost
3. After installation, merge any custom settings you want to keep

## 🛠️ Installation Questions

### Q: Do I need to install everything?

**A:** No! The installation script is modular. You can install:
- All components: `./scripts/install.sh`
- Specific component: `./scripts/install.sh --component zsh`
- Multiple components: `./scripts/install.sh --component zsh,nvim`

Available components: `zsh`, `nvim`, `tmux`, `alacritty`, `git`

### Q: What if I don't have administrator privileges?

**A:** Most configurations work without root access:
- Scripts install to user directories (`~/.config/`, `~/.local/`)
- You'll need to install tools like Neovim, tmux manually or ask your admin
- Use package managers that support user-level installation (conda, homebrew, nix)

### Q: How do I uninstall?

**A:** Use the uninstall script:
```bash
./scripts/uninstall.sh
```
This removes symlinks and can optionally restore backups.

### Q: Can I use only parts of the configuration?

**A:** Absolutely! Each component is independent:
- **ZSH only**: Great for shell enhancement
- **Neovim only**: Powerful editor setup
- **Tmux only**: Better terminal multiplexing
- **Mix and match**: Use any combination

## 🐚 ZSH Questions

### Q: I'm new to ZSH. Is this beginner-friendly?

**A:** Yes! The configuration includes:
- **Help system**: Run `help-devkraken` for available commands
- **Welcome message**: Shows key features on startup
- **Intuitive aliases**: Modern replacements for common commands
- **Autocomplete**: Suggestions as you type

### Q: How do I customize the prompt?

**A:** The prompt uses Powerlevel10k theme:
```bash
p10k configure  # Run configuration wizard
```
Or edit `~/.p10k.zsh` directly for advanced customization.

### Q: Can I add my own aliases?

**A:** Yes! Add them to the end of `~/.zshrc`:
```bash
# Personal aliases
alias myproject="cd ~/path/to/project"
alias deploy="./scripts/deploy.sh"
```

### Q: What if I prefer bash?

**A:** You can:
1. Extract useful aliases and functions to your `.bashrc`
2. Use ZSH just for development work
3. Set bash as default but use ZSH when needed: `exec zsh`

## 🔧 Neovim Questions

### Q: I'm a Vim user. Will I be comfortable?

**A:** Yes! This configuration:
- **Preserves Vim keybindings** and muscle memory
- **Adds modern features** without breaking compatibility
- **Includes familiar plugins** like NERDTree equivalent (neo-tree)
- **Maintains Vim philosophy** while adding IDE-like features

### Q: How do I add new language support?

**A:** For new programming languages:

1. **Install LSP server** (often via npm, pip, or package manager)
2. **Add to LSP configuration**:
   ```lua
   -- In config/nvim/lua/dev-kraken/plugins/lsp/servers.lua
   servers = {
     -- existing servers...
     rust_analyzer = {},  -- Add Rust support
     gopls = {},          -- Add Go support
   }
   ```

3. **Install syntax highlighting** (usually automatic with Treesitter)

### Q: Can I use my existing Vim plugins?

**A:** Many Vim plugins work with Neovim, but this configuration uses modern Lua-based alternatives:
- **Lazy.nvim** for plugin management
- **LSP** instead of older completion plugins
- **Treesitter** for syntax highlighting
- **Telescope** for fuzzy finding

You can add Vim plugins, but the modern alternatives are usually better.

### Q: How do I update plugins?

**A:** Use Lazy.nvim commands:
```vim
:Lazy update    " Update all plugins
:Lazy sync      " Sync plugin state
:Lazy clean     " Remove unused plugins
```

## 🖥️ Terminal Questions

### Q: Do I have to use Alacritty?

**A:** No! The configurations work with any terminal:
- **Alacritty**: Fast, GPU-accelerated (recommended)
- **iTerm2**: Great for macOS
- **GNOME Terminal**: Good for GNOME desktop
- **Windows Terminal**: For Windows/WSL

Just ensure your terminal supports:
- 24-bit color (truecolor)
- Unicode and Nerd Fonts
- Modern escape sequences

### Q: Why tmux over terminal tabs?

**A:** Tmux provides:
- **Session persistence**: Survives disconnections
- **Server/remote development**: Attach/detach sessions
- **Better window management**: Panes, windows, sessions
- **Programmable**: Scriptable layouts and automation
- **Integration**: Seamless with Neovim navigation

You can use both tmux and terminal tabs together.

### Q: How do I customize tmux colors?

**A:** Edit `config/tmux/tmux.conf`:
```bash
# Status bar colors
set -g status-bg colour235
set -g status-fg colour136

# Window colors
setw -g window-status-current-style bg=colour166,fg=colour15
```

## 🚀 Development Questions

### Q: Why NVM instead of system Node.js?

**A:** NVM provides:
- **Multiple Node versions**: Switch per project
- **Easy updates**: Install latest versions without conflicts
- **Project isolation**: Different versions for different projects
- **No sudo required**: User-level installation
- **Compatibility**: Better for development workflows

### Q: How do I manage different Node.js versions?

**A:** With NVM:
```bash
nvm install 18.17.0    # Install specific version
nvm use 18.17.0        # Use for current session
nvm alias default 18   # Set default version

# Project-specific version
echo "18.17.0" > .nvmrc
nvm use                # Auto-uses version from .nvmrc
```

### Q: Can I use these dotfiles for work projects?

**A:** Yes! The configuration is professional-grade:
- **Git integration**: Professional commit formatting
- **LSP support**: Enterprise-level code intelligence
- **Multiple languages**: Support for various tech stacks
- **Docker integration**: Container development workflows
- **Security conscious**: No embedded secrets or personal info

### Q: How do I add company-specific settings?

**A:** Create local configuration files:
- `~/.zshrc.local` - Machine-specific ZSH settings
- `~/.gitconfig.local` - Work-specific Git config
- Project `.dotfiles.local` - Project-specific settings

These files are sourced automatically but not tracked in git.

## 🔧 Customization Questions

### Q: How do I change the color scheme?

**A:** The configuration uses Catppuccin Mocha theme. To change:

1. **Alacritty**: Change theme import in `alacritty.toml`
2. **Neovim**: Modify colorscheme in Lua configuration
3. **Tmux**: Update color settings in `tmux.conf`
4. **ZSH**: Adjust Powerlevel10k colors

### Q: Can I use a different font?

**A:** Yes! Update font settings in:
- **Alacritty**: `[font.normal] family = "Your Font"`
- **Terminal**: Terminal preferences
- **Requirement**: Must be a Nerd Font for icons

### Q: How do I add new key bindings?

**A:** Each tool has specific files:
- **Neovim**: `config/nvim/lua/dev-kraken/core/keymaps.lua`
- **Tmux**: `config/tmux/tmux.conf`
- **ZSH**: Add to `~/.zshrc`

## 🛡️ Troubleshooting Questions

### Q: Something broke after installation. What now?

**A:** Follow this process:
1. **Run validation**: `./scripts/validate.sh`
2. **Check logs**: Look for error messages
3. **Reset component**: `./scripts/install.sh --component broken_component`
4. **Full reset**: `./scripts/uninstall.sh && ./scripts/install.sh`
5. **Check documentation**: Review troubleshooting guide

### Q: How do I get help?

**A:** Multiple resources available:
1. **Built-in help**: `help-devkraken` command
2. **Validation script**: `./scripts/validate.sh`
3. **Health checks**: `:checkhealth` in Neovim
4. **Documentation**: Comprehensive guides in `docs/`
5. **Community**: Tool-specific forums and GitHub issues

### Q: Can I contribute improvements?

**A:** Absolutely! The dotfiles are designed to evolve:
- **Fork the repository**
- **Make improvements**
- **Test thoroughly**
- **Submit pull requests**
- **Document changes**

## 🔄 Maintenance Questions

### Q: How do I update the dotfiles?

**A:** Regular updates:
```bash
cd ~/.dotfiles
git pull                # Get latest changes
./scripts/update.sh     # Update configurations
```

### Q: How often should I update?

**A:** Recommended schedule:
- **Weekly**: Plugin updates (`:Lazy update`)
- **Monthly**: Full dotfiles update
- **As needed**: When new features are released
- **Before major projects**: Ensure stability

### Q: Will updates break my customizations?

**A:** Updates are designed to preserve customizations:
- **Local files** (`.zshrc.local`) are preserved
- **Personal settings** in Git config remain
- **Custom plugins** in separate directories are kept
- **Backups** created automatically

### Q: How do I backup my customizations?

**A:** Regular backup strategy:
```bash
# Built-in backup
./scripts/backup.sh

# Custom backup
tar -czf my-dotfiles-$(date +%Y%m%d).tar.gz \
  ~/.zshrc.local ~/.gitconfig.local ~/.config/nvim/lua/custom/
```

## 📱 Platform-Specific Questions

### Q: Differences between Linux and macOS?

**A:** Minor platform differences:
- **Package managers**: pacman vs brew
- **Paths**: Some tools in different locations
- **Clipboard**: Different commands (pbcopy vs xclip)
- **Font installation**: Different procedures

The configuration automatically detects and adapts to the platform.

### Q: Can I use this on Windows?

**A:** Yes, with WSL (Windows Subsystem for Linux):
1. **Install WSL2** with Ubuntu or similar
2. **Run the installation** in WSL environment
3. **Use Windows Terminal** for best experience
4. **Configure integration** with Windows tools if needed

### Q: What about remote servers?

**A:** Great for remote development:
- **SSH into server**
- **Clone and install** dotfiles
- **Use tmux sessions** for persistence
- **Develop remotely** with full IDE experience

## 🎯 Performance Questions

### Q: Will this slow down my terminal?

**A:** The configuration is optimized for performance:
- **Fast startup**: Lazy loading and optimizations
- **Efficient tools**: Modern replacements (eza, zoxide)
- **Minimal overhead**: Only load what's needed
- **Benchmarked**: Regular performance testing

If you experience slowness, check the troubleshooting guide.

### Q: How much disk space does this use?

**A:** Approximate disk usage:
- **Configuration files**: ~50MB
- **Neovim plugins**: ~500MB
- **ZSH plugins**: ~50MB
- **Total**: Under 1GB including all tools

### Q: Can I run this on low-spec machines?

**A:** Yes! The configuration includes:
- **Resource monitoring**: Performance aliases
- **Lightweight alternatives**: Can disable heavy features
- **Minimal mode**: Comment out resource-intensive plugins
- **Scalable**: Adjust based on machine capabilities

Remember: You can always ask for help by creating an issue on the repository! 