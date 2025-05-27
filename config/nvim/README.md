# 🚀 Dev-Kraken's Neovim Configuration

A comprehensive, modern Neovim setup optimized for PHP, JavaScript/TypeScript, Laravel, Docker, and fullstack development. Built with performance, productivity, and learning in mind.

## ✨ Features

### 🎨 UI & Experience

- **Beautiful Catppuccin colorscheme** with multiple variants
- **Smart statusline** with git info, LSP status, and file info
- **Buffer tabs** for easy file navigation
- **File explorer** with git integration
- **Dashboard** with quick actions
- **Which-key** for discovering keybindings
- **Indent guides** and color highlighting
- **TreeSitter syntax highlighting** (modern, fast, accurate)

### 🧠 Language Support

- **PHP** with Intelephense LSP (Laravel support)
- **JavaScript/TypeScript** with full LSP support
- **HTML/CSS** with autocompletion
- **JSON/YAML** with schema validation
- **Docker** with Dockerfile syntax
- **SQL** with database integration
- **Bash/Shell** scripting support
- **Lua** for Neovim configuration

### 🔧 Development Tools

- **LSP** with auto-completion, diagnostics, and formatting
- **TreeSitter** for advanced syntax highlighting
- **Git integration** with signs, blame, and diff views
- **Fuzzy finder** for files, text, and commands
- **Terminal integration** with floating and split terminals
- **Auto-pairs** and surround operations
- **Comment toggling** with context awareness
- **Todo comments** highlighting

### 🐳 DevOps Integration

- **Docker** support with compose integration
- **Kubernetes** YAML validation
- **REST client** for API testing
- **Terraform** syntax support
- **GitHub** integration with PR/issue management
- **Database client** for SQL operations

## 📦 Installation

### Prerequisites

- **Neovim 0.9+**
- **Git**
- **NVM & Node.js** (for language servers)
- **PHP** (for PHP development)
- **Composer** (for PHP packages)
- A **Nerd Font** (recommended: JetBrains Mono Nerd Font)

### Quick Install

1. **Backup existing config** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Install via dotfiles repository**:

   ```bash
   # Clone the full dotfiles repository
   git clone https://github.com/dev-kraken/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   
   # Install Neovim configuration (and optionally other components)
   ./scripts/install.sh --component nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

   Plugins will auto-install on first launch.

4. **Health check**:
   ```vim
   :checkhealth
   ```

### Manual Setup

If you prefer to set it up manually:

1. Create the directory structure:

   ```bash
   mkdir -p ~/.config/nvim/lua/dev-kraken/{core,plugins/lsp,utils}
   ```

2. Copy all files to their respective locations according to the structure below.

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── README.md                   # This file
├── lua/
│   └── dev-kraken/
│       ├── core/
│       │   ├── init.lua       # Core settings loader
│       │   ├── options.lua    # Vim options and settings
│       │   ├── keymaps.lua    # Key mappings
│       │   └── autocmds.lua   # Auto commands
│       ├── plugins/
│       │   ├── init.lua       # Plugin manager setup
│       │   ├── lsp/
│       │   │   ├── init.lua   # LSP configuration loader
│       │   │   ├── servers.lua # LSP server configurations
│       │   │   └── handlers.lua # LSP handlers and formatting
│       │   ├── completion.lua  # Autocompletion setup
│       │   ├── treesitter.lua  # Syntax highlighting
│       │   ├── telescope.lua   # Fuzzy finder
│       │   ├── git.lua        # Git integration
│       │   ├── ui.lua         # UI plugins (theme, statusline, etc.)
│       │   ├── editor.lua     # Editor enhancement plugins
│       │   ├── terminal.lua   # Terminal integration
│       │   └── devops.lua     # DevOps specific plugins
│       └── utils/
│           ├── init.lua       # Utility functions loader
│           └── helpers.lua    # Helper functions
```

## ⌨️ Complete Key Mappings Reference

### 🔑 Leader Key
**Leader Key**: `<Space>` (Space bar)

---

### 📁 Essential File & Navigation

| Key          | Action               | Description                    |
|--------------|----------------------|--------------------------------|
| `<leader>e`  | Toggle File Explorer | Open/close nvim-tree           |
| `<leader>E`  | Focus File Explorer  | Focus on nvim-tree window      |
| `<leader>w`  | Save File            | Save current file              |
| `<leader>q`  | Quit                 | Close current window           |
| `<leader>Q`  | Force Quit           | Force close without saving    |
| `<leader>h`  | Clear Highlights     | Clear search highlights        |
| `<C-s>`      | Save File            | Save (works in insert mode)   |

---

### 🔍 Telescope (Fuzzy Finder)

| Key           | Action                    | Description                        |
|---------------|---------------------------|------------------------------------|
| `<leader>ff`  | Find Files                | Search files in project           |
| `<leader>fg`  | Live Grep                 | Search text in all files          |
| `<leader>fb`  | Find Buffers              | Search open buffers                |
| `<leader>fh`  | Help Tags                 | Search help documentation          |
| `<leader>fo`  | Recent Files              | Search recently opened files       |
| `<leader>fr`  | Recent Files              | Search recently opened files       |
| `<leader>fc`  | Commands                  | Search available commands          |
| `<leader>fk`  | Keymaps                   | Search key mappings                |
| `<leader>fs`  | Grep String Under Cursor | Search word under cursor           |
| `<leader>fw`  | Workspace Symbols         | Search workspace symbols           |
| `<leader>fd`  | Diagnostics               | Search diagnostics                 |
| `<leader>fj`  | Jumplist                  | Search jump history                |
| `<leader>fm`  | Marks                     | Search marks                       |
| `<leader>f/`  | Buffer Fuzzy Find         | Search in current buffer           |

---

### 📄 Buffer Management

| Key           | Action              | Description                    |
|---------------|---------------------|--------------------------------|
| `<leader>bn`  | Next Buffer         | Switch to next buffer          |
| `<leader>bp`  | Previous Buffer     | Switch to previous buffer      |
| `<leader>bd`  | Delete Buffer       | Close current buffer           |
| `<leader>bD`  | Delete All Buffers  | Close all buffers              |
| `<leader>bo`  | Delete Other Buffers| Close all except current       |
| `<S-l>`       | Next Buffer         | Alternative next buffer        |
| `<S-h>`       | Previous Buffer     | Alternative previous buffer    |

---

### 🪟 Window & Split Management

| Key            | Action              | Description                    |
|----------------|---------------------|--------------------------------|
| `<C-h>`        | Move Left           | Navigate to left window        |
| `<C-j>`        | Move Down           | Navigate to bottom window      |
| `<C-k>`        | Move Up             | Navigate to top window         |
| `<C-l>`        | Move Right          | Navigate to right window       |
| `<leader>sv`   | Vertical Split      | Split window vertically        |
| `<leader>sh`   | Horizontal Split    | Split window horizontally      |
| `<leader>se`   | Equal Splits        | Make splits equal size         |
| `<leader>sx`   | Close Split         | Close current split            |
| `<C-Up>`       | Resize Up           | Increase window height         |
| `<C-Down>`     | Resize Down         | Decrease window height         |
| `<C-Left>`     | Resize Left         | Decrease window width          |
| `<C-Right>`    | Resize Right        | Increase window width          |

---

### 🧠 LSP (Language Server Protocol)

| Key           | Action                 | Description                     |
|---------------|------------------------|---------------------------------|
| `gd`          | Go to Definition       | Jump to symbol definition       |
| `gr`          | Go to References       | Show all references             |
| `gi`          | Go to Implementation   | Jump to implementation          |
| `K`           | Hover Info             | Show documentation popup        |
| `<C-k>`       | Signature Help         | Show function signature         |
| `<leader>rn`  | Rename Symbol          | Rename symbol under cursor      |
| `<leader>ca`  | Code Actions           | Show available code actions     |
| `<leader>lf`  | Format File            | Format current file             |
| `<leader>ld`  | Line Diagnostics       | Show line diagnostics           |
| `<leader>ls`  | Document Symbols       | Show document symbols           |
| `<leader>lw`  | Workspace Symbols      | Show workspace symbols          |
| `<leader>lD`  | Type Definition        | Go to type definition           |
| `]d`          | Next Diagnostic        | Navigate to next diagnostic     |
| `[d`          | Previous Diagnostic    | Navigate to previous diagnostic |

---

### 📝 Advanced Editing & Movement

| Key           | Action                 | Description                     |
|---------------|------------------------|---------------------------------|
| `<A-j>`       | Move Line Down         | Move line(s) down               |
| `<A-k>`       | Move Line Up           | Move line(s) up                 |
| `J`           | Move Selection Down    | Move selection down (visual)    |
| `K`           | Move Selection Up      | Move selection up (visual)      |
| `<`           | Indent Left            | Decrease indentation (visual)   |
| `>`           | Indent Right           | Increase indentation (visual)   |
| `p`           | Better Paste           | Paste without yanking (visual)  |
| `<C-d>`       | Scroll Down Centered   | Scroll down and center cursor   |
| `<C-u>`       | Scroll Up Centered     | Scroll up and center cursor     |
| `n`           | Next Search Centered   | Next search result centered     |
| `N`           | Previous Search Centered| Previous search result centered |
| `gcc`         | Toggle Line Comment    | Comment/uncomment line          |
| `gc`          | Toggle Comment         | Comment/uncomment selection     |

---

### 🌿 Git Integration

| Key           | Action              | Description                    |
|---------------|---------------------|--------------------------------|
| `<leader>gs`  | Git Status          | Show git status with Telescope |
| `<leader>gb`  | Git Branches        | Show git branches              |
| `<leader>gc`  | Git Commits         | Show git commits               |
| `<leader>gf`  | Git Files           | Show git files                 |

---

### 🐧 Terminal Integration

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>tf`  | Float Terminal          | Toggle floating terminal       |
| `<leader>th`  | Horizontal Terminal     | Toggle horizontal terminal     |
| `<leader>tv`  | Vertical Terminal       | Toggle vertical terminal       |
| `<leader>tg`  | Lazygit                 | Open Lazygit in terminal       |
| `<leader>tn`  | Node REPL               | Open Node.js REPL (via NVM)    |
| `<leader>tp`  | Python REPL             | Open Python REPL               |
| `<leader>tP`  | PHP REPL                | Open PHP REPL                  |
| `<leader>tH`  | Htop                    | Open system monitor            |

---

### 🐘 PHP & Laravel Development

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>pa`  | Artisan Command         | Run php artisan (interactive) |
| `<leader>pm`  | Run Migration           | Execute database migration     |
| `<leader>pc`  | Clear Cache             | Clear Laravel cache            |
| `<leader>pr`  | Route List              | Show Laravel routes            |
| `<leader>pt`  | Run Tests               | Execute Laravel tests          |
| `<leader>ps`  | Serve Application       | Start Laravel dev server       |

---

### 🐳 Docker & DevOps

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>dc`  | Docker Compose          | Run docker-compose (interactive)|
| `<leader>du`  | Docker Up               | Start docker-compose           |
| `<leader>dd`  | Docker Down             | Stop docker-compose            |
| `<leader>db`  | Docker Build            | Build Docker image             |
| `<leader>dl`  | Docker Logs             | View docker logs (interactive) |

---

### 🗄️ Database Operations

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>bu`  | Database UI             | Toggle database interface      |
| `<leader>bf`  | Find DB Buffer          | Find database buffer           |
| `<leader>br`  | Rename DB Buffer        | Rename database buffer         |
| `<leader>bq`  | Last Query Info         | Show last query information    |
| `<leader>ms`  | MySQL Shell             | Open MySQL command line        |

---

### 🌐 REST API Testing

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>rr`  | Run REST Request        | Execute REST API call          |
| `<leader>rl`  | Run Last REST           | Repeat last REST request       |

---

### 🔧 Quick Fix & Diagnostics

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>co`  | Open Quick Fix          | Open quickfix list             |
| `<leader>cc`  | Close Quick Fix         | Close quickfix list            |
| `]q`          | Next Quick Fix          | Next quickfix item             |
| `[q`          | Previous Quick Fix      | Previous quickfix item         |
| `<leader>lo`  | Open Location List      | Open location list             |
| `<leader>lc`  | Close Location List     | Close location list            |
| `]l`          | Next Location           | Next location item             |
| `[l`          | Previous Location       | Previous location item         |

---

### 🔍 Trouble (Diagnostics)

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>xx`  | Toggle Trouble          | Toggle Trouble diagnostics     |
| `<leader>xw`  | Workspace Diagnostics   | Show workspace diagnostics     |
| `<leader>xd`  | Document Diagnostics    | Show document diagnostics      |
| `<leader>xl`  | Location List           | Show location list in Trouble  |
| `<leader>xq`  | Quickfix List           | Show quickfix in Trouble       |
| `gR`          | LSP References          | Show LSP references in Trouble |

---

### 🌳 TreeSitter (Syntax Analysis)

| Key           | Action                  | Description                    |
|---------------|-------------------------|--------------------------------|
| `<leader>ti`  | Inspect Tree            | Open TreeSitter syntax tree   |
| `<leader>th`  | Show Captures           | Show syntax captures under cursor|

---

### 💡 Essential Neovim Commands

| Command                        | Description                           |
|--------------------------------|---------------------------------------|
| `:Inspect`                     | Show highlight groups under cursor    |
| `:InspectTree`                 | Show TreeSitter syntax tree          |
| `:Lazy`                        | Open plugin manager                   |
| `:Mason`                       | Open LSP server manager               |
| `:LspInfo`                     | Show LSP server information           |
| `:LspRestart`                  | Restart LSP servers                   |
| `:Telescope`                   | Open Telescope picker                 |
| `:checkhealth`                 | Check system health                   |
| `:TSUpdate`                    | Update TreeSitter parsers             |
| `:TSInstall <language>`        | Install TreeSitter parser             |

---

## 🔧 Customization

### Adding New Languages

1. **Add LSP server** in `lua/dev-kraken/plugins/lsp/servers.lua`:

   ```lua
   lspconfig.your_language_server.setup({
     on_attach = on_attach,
     capabilities = capabilities,
   })
   ```

2. **Add TreeSitter parser** in `lua/dev-kraken/plugins/treesitter.lua`:
   ```lua
   ensure_installed = {
     -- ... existing parsers
     "your_language",
   }
   ```

### Changing Theme

Edit `lua/dev-kraken/plugins/ui.lua` and modify the colorscheme section:

```lua
-- Change flavour to: latte, frappe, macchiato, or mocha
flavour = "mocha",
```

### Custom Key Mappings

Add your mappings in `lua/dev-kraken/core/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>your_key", ":YourCommand<CR>", { desc = "Your description" })
```

### Adding Plugins

Add new plugins in the appropriate file under `lua/dev-kraken/plugins/`:

- UI plugins → `ui.lua`
- Editor enhancements → `editor.lua`
- DevOps tools → `devops.lua`
- Terminal tools → `terminal.lua`

## 🐛 Troubleshooting

### Common Issues

1. **LSP not working**:

   ```vim
   :LspInfo
   :Mason
   ```

2. **TreeSitter issues**:

   ```vim
   :TSUpdate
   :checkhealth nvim-treesitter
   ```

3. **Plugin issues**:

   ```vim
   :Lazy
   :Lazy sync
   ```

4. **Health check**:
   ```vim
   :checkhealth
   ```

### Performance Issues

- Check startup time: `nvim --startuptime startup.log`
- Profile plugins: `:Lazy profile`
- Disable unused plugins

## 📚 Learning Resources

### 🏆 Essential Commands to Master First

1. **Navigation**: `<leader>ff` (find files), `<leader>e` (file explorer)
2. **Search**: `<leader>fg` (search text), `<leader>fb` (find buffers)
3. **LSP**: `gd` (go to definition), `gr` (references), `K` (hover)
4. **Git**: `<leader>gs` (git status), `<leader>gc` (commits)
5. **Terminal**: `<leader>tf` (floating terminal)

### 🚀 Advanced Workflow Commands

1. **Code Actions**: `<leader>ca` (fix issues automatically)
2. **Diagnostics**: `]d`/`[d` (navigate errors), `<leader>xx` (trouble panel)
3. **Refactoring**: `<leader>rn` (rename), `<leader>lf` (format)
4. **Project Search**: `<leader>fw` (workspace symbols), `<leader>fd` (diagnostics)
5. **PHP/Laravel**: `<leader>pa` (artisan), `<leader>pt` (tests)

### 📖 Recommended Learning Path

1. **Week 1**: Master basic navigation (`<leader>ff`, `<leader>e`, `<leader>fg`)
2. **Week 2**: Learn LSP commands (`gd`, `gr`, `K`, `<leader>ca`)
3. **Week 3**: Git workflow (`<leader>gs`, `<leader>gc`, `<leader>gb`)
4. **Week 4**: Terminal integration (`<leader>tf`, `<leader>tg`)
5. **Week 5**: Language-specific features (PHP, Docker commands)
6. **Week 6+**: Customize and add your own keymaps

## 🤝 Contributing

Feel free to submit issues, feature requests, or pull requests. This configuration is designed to be:

- **Modular**: Easy to add/remove components
- **Documented**: Clear explanations for all features
- **Beginner-friendly**: Good defaults with room to grow
- **Production-ready**: Stable and performant

## 📄 License

MIT License - Feel free to use and modify as needed.

## 🙏 Acknowledgments

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Catppuccin](https://github.com/catppuccin/nvim) - Beautiful colorscheme
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) - Modern syntax highlighting
- [LSP](https://github.com/neovim/nvim-lspconfig) - Language server protocol
- All the amazing plugin authors in the Neovim ecosystem

---

**Happy coding with Neovim! 🚀✨**
