# 🐙 Dev-Kraken's Git Configuration

Comprehensive Git configuration with useful aliases, colors, and global ignore patterns.

## 📁 Structure

```
git/
├── .gitconfig           # Main Git configuration
├── .gitignore_global    # Global ignore patterns
└── README.md           # This file
```

## ⚡ Features

- **Developer-friendly aliases** for common commands
- **Colored output** for better readability
- **Global gitignore** covering multiple languages
- **Modern defaults** (main branch, auto-setup remote)
- **Neovim integration** as default editor

## 🛠️ Installation

The installation script will automatically:
1. Create `~/.gitconfig` symlink
2. Create `~/.gitignore_global` symlink
3. Set up git to use the global ignore file

Manual installation:
```bash
# Symlink configuration files
ln -sf $(pwd)/config/git/.gitconfig ~/.gitconfig
ln -sf $(pwd)/config/git/.gitignore_global ~/.gitignore_global

# Tell git to use the global ignore file
git config --global core.excludesfile ~/.gitignore_global
```

## 🎨 Customization

### Personal Information
Edit the `[user]` section in `.gitconfig`:
```ini
[user]
    name = Your Name
    email = your.email@example.com
```

### Useful Aliases Included

| Alias | Command | Description |
|-------|---------|-------------|
| `git st` | `status` | Show status |
| `git co` | `checkout` | Checkout branch |
| `git br` | `branch` | List branches |
| `git ci` | `commit` | Commit changes |
| `git cam` | `commit -am` | Add all and commit |
| `git lg` | Complex log | Pretty graph log |
| `git ll` | Complex log | Detailed graph log |
| `git unstage` | `reset HEAD --` | Unstage files |

### Color Configuration
The configuration includes colored output for:
- Branch listings
- Diff output
- Status information
- General Git output

## 🚫 Global Gitignore

The global gitignore covers:
- **Editor files** (.vscode, .idea, vim swaps)
- **OS files** (.DS_Store, Thumbs.db)
- **Language artifacts** (node_modules, __pycache__)
- **Build files** (*.o, *.exe, dist/)
- **Temporary files** (*.tmp, *.log, cache/)
- **Environment files** (.env, *.key)

## 🔧 Additional Setup

### SSH Key Configuration
```bash
# Generate SSH key (if needed)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add to SSH agent
ssh-add ~/.ssh/id_ed25519
```

### Git Credential Helper
The config includes credential caching for 1 hour. For longer periods:
```bash
git config --global credential.helper 'cache --timeout=28800'  # 8 hours
```

## 📚 Documentation

- [Git Configuration Reference](https://git-scm.com/docs/git-config)
- [Gitignore Documentation](https://git-scm.com/docs/gitignore)
- [Git Aliases Guide](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases)

## 🔄 Updates

Configuration files are managed through this dotfiles repository. Pull latest changes and re-run the installation script to update. 