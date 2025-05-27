# 🚀 Dev-Kraken's Tmux Configuration

A powerful tmux setup optimized for seamless integration with Neovim, featuring the Catppuccin Mocha theme and enhanced productivity features.

## ✨ Features

### 🎨 Theme & UI
- **Catppuccin Mocha** theme (matches Neovim configuration)
- Beautiful status bar with battery, time, and online status
- Modern icons and clean layout
- Activity monitoring with visual indicators

### ⚡ Performance
- Optimized for Neovim integration
- Fast escape times (10ms) for responsive editing
- True color support (RGB)
- Undercurl support for better error highlighting

### 🧭 Navigation
- **Seamless Vim-style navigation** between tmux panes and Neovim splits
- Smart pane switching that detects when Neovim is active
- Intuitive keybindings consistent with Neovim

### 🔧 Session Management
- Session persistence with auto-save every 15 minutes
- Enhanced session switcher with fuzzy finding
- Automatic session restoration (manual trigger for safety)

### 🛠️ Developer Tools
- FZF integration for fuzzy finding
- Copy mode with vim-style keybindings
- Mouse support for modern workflow
- SSH agent forwarding for remote development

## 📦 Installation

### Quick Setup
```bash
# Install plugins
~/.config/tmux/install-plugins.sh

# Test integration
~/.config/tmux/test-nvim-integration.sh
```

### Manual Installation
1. **Ensure tmux is installed** (version 3.0+):
   ```bash
   tmux -V
   ```

2. **Install TPM** (Tmux Plugin Manager):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
   ```

3. **Start tmux and install plugins**:
   ```bash
   tmux
   # Press: Ctrl+Space + I (to install plugins)
   ```

## ⌨️ Key Bindings

### Core Controls
| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+Space` | Prefix | Main tmux prefix key |
| `Ctrl+Space + r` | Reload config | Reload tmux configuration |

### Pane Navigation (Seamless Neovim Integration)
| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+h` | Move left | Works in both tmux and Neovim |
| `Ctrl+j` | Move down | Works in both tmux and Neovim |
| `Ctrl+k` | Move up | Works in both tmux and Neovim |
| `Ctrl+l` | Move right | Works in both tmux and Neovim |

### Pane Management
| Key | Action | Description |
|-----|--------|-------------|
| `Prefix + \|` | Split horizontal | More intuitive split |
| `Prefix + -` | Split vertical | More intuitive split |
| `Prefix + x` | Kill pane | Close current pane |
| `Prefix + z` | Zoom pane | Toggle pane zoom |

### Pane Resizing
| Key | Action | Description |
|-----|--------|-------------|
| `Prefix + H` | Resize left | Repeatable |
| `Prefix + J` | Resize down | Repeatable |
| `Prefix + K` | Resize up | Repeatable |
| `Prefix + L` | Resize right | Repeatable |

### Window Management
| Key | Action | Description |
|-----|--------|-------------|
| `Prefix + c` | New window | Creates in current directory |
| `Ctrl+h` | Previous window | Repeatable |
| `Ctrl+l` | Next window | Repeatable |
| `Alt+c` | Kill window | Close current window |

### Session Management
| Key | Action | Description |
|-----|--------|-------------|
| `Prefix + S` | New session | Create named session |
| `Prefix + B` | Last session | Switch to previous session |
| `Prefix + o` | Session switcher | Enhanced session picker |
| `Prefix + Ctrl+s` | Session tree | Visual session browser |

### Enhanced Features
| Key | Action | Description |
|-----|--------|-------------|
| `Prefix + Ctrl+f` | FZF launcher | Fuzzy find everything |
| `Prefix + Enter` | Copy mode | Enter vim-style copy mode |
| `Prefix + T` | Display panes | Show pane numbers |
| `Prefix + C` | Clear history | Clear scrollback buffer |

### Copy Mode (Vim-style)
| Key | Action | Description |
|-----|--------|-------------|
| `v` | Visual selection | Start selecting text |
| `y` | Copy | Copy to system clipboard |
| `r` | Rectangle toggle | Toggle rectangle selection |

## 🔌 Installed Plugins

| Plugin | Purpose | Description |
|--------|---------|-------------|
| **tpm** | Plugin Manager | Tmux Plugin Manager |
| **tmux-sensible** | Defaults | Sensible default settings |
| **vim-tmux-navigator** | Navigation | Seamless Vim/tmux navigation |
| **catppuccin/tmux** | Theme | Beautiful Catppuccin theme |
| **tmux-resurrect** | Persistence | Session restoration |
| **tmux-continuum** | Auto-save | Automatic session saving |
| **tmux-fzf** | Fuzzy Finding | FZF integration |
| **tmux-sessionx** | Sessions | Enhanced session management |
| **tmux-yank** | Clipboard | Better copy functionality |
| **tmux-online-status** | Status | Network connectivity indicator |
| **tmux-battery** | Status | Battery status indicator |

## 🎨 Theme Configuration

The configuration uses **Catppuccin Mocha** theme to match your Neovim setup:

- **Background**: Dark mocha base
- **Accent**: Catppuccin peach for active elements
- **Text**: Catppuccin text colors
- **Status modules**: Directory, time, battery, online status

## 🔧 Customization

### Changing Theme Colors
Edit the Catppuccin section in `tmux.conf`:
```bash
set -g @catppuccin_flavor "mocha"  # Options: latte, frappe, macchiato, mocha
```

### Adding Custom Keybindings
Add your keybindings after the existing ones:
```bash
bind-key your_key your_command
```

### Modifying Status Bar
Customize status modules:
```bash
set -g @catppuccin_status_modules_right "directory date_time battery online_status"
```

## 🧪 Testing Integration

Run the integration test to verify everything works:

```bash
~/.config/tmux/test-nvim-integration.sh
```

### Manual Testing Steps
1. Start tmux: `tmux`
2. Create splits: `Prefix + |` and `Prefix + -`
3. Start Neovim in one pane: `nvim`
4. Create Neovim splits: `:split` or `:vsplit`
5. Test navigation: `Ctrl+h/j/k/l` should move seamlessly between all panes

## 🐛 Troubleshooting

### Plugins Not Loading
```bash
# Reinstall plugins
Prefix + I

# Update plugins  
Prefix + U

# Check plugin status
ls ~/.config/tmux/.tmux/plugins/
```

### Navigation Not Working
1. Ensure `vim-tmux-navigator` plugin is installed
2. Add to your Neovim config (already included in dev-kraken config):
   ```lua
   -- Plugin should be in your plugins list
   'christoomey/vim-tmux-navigator'
   ```

### Colors Not Displaying Correctly
1. Check terminal true color support:
   ```bash
   echo $TERM
   # Should show: tmux-256color or similar
   ```

2. Test colors:
   ```bash
   tmux display-message "#{client_termtype}"
   ```

### Session Restoration Issues
```bash
# Manual save
Prefix + Ctrl+s

# Manual restore  
Prefix + Ctrl+r
```

## 🚀 Integration with Neovim

This tmux configuration is specifically optimized for the Dev-Kraken Neovim setup:

### Perfect Integration Features
- **Shared color scheme** (Catppuccin Mocha)
- **Unified navigation** (Ctrl+hjkl works everywhere)
- **Consistent keybindings** (Space-based leader keys)
- **Terminal integration** (Toggleterm works seamlessly)
- **Session management** (Projects can be restored with layout)

### Recommended Workflow
1. Start tmux session for each project: `tmux new -s project-name`
2. Split into logical panes (editor, terminal, tests, logs)
3. Use Neovim in main pane with integrated terminal
4. Navigate seamlessly between all areas
5. Save/restore entire development environment

## 📚 Learning Resources

- **Tmux shortcuts**: `Prefix + ?` (shows all keybindings)
- **Plugin help**: Visit plugin repositories on GitHub
- **Catppuccin theme**: [Catppuccin for Tmux](https://github.com/catppuccin/tmux)

## 🤝 Contributing

Feel free to customize this configuration to your needs. The modular structure makes it easy to add, remove, or modify components.

---

**Author**: dev-kraken  
**Last Updated**: 2025  
**Compatible with**: Tmux 3.0+ | Neovim 0.8+ 