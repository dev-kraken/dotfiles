-- Vim options and settings

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "80,120"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Mouse
opt.mouse = "a"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- File encoding
opt.fileencoding = "utf-8"

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- PHP specific settings
vim.g.php_syntax_extensions_enabled = { "bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli", "openssl", "pcre", "pdo", "session", "simplexml", "soap", "sockets", "spl", "sqlite", "standard", "tokenizer", "wddx", "xml", "xmlreader", "xmlwriter", "zip", "zlib" }

-- Disable some built-in plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
