-- Auto commands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General auto commands
local general = augroup("General", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Don't auto comment new line
autocmd("BufEnter", {
  group = general,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
    end
  end,
})

-- File type specific settings
local filetype = augroup("FileType", { clear = true })

-- PHP settings
autocmd("FileType", {
  group = filetype,
  pattern = "php",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- JavaScript/TypeScript settings
autocmd("FileType", {
  group = filetype,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- HTML/CSS settings
autocmd("FileType", {
  group = filetype,
  pattern = { "html", "css", "scss", "sass" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- YAML settings
autocmd("FileType", {
  group = filetype,
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- JSON settings
autocmd("FileType", {
  group = filetype,
  pattern = "json",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- SQL settings
autocmd("FileType", {
  group = filetype,
  pattern = "sql",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Dockerfile settings
autocmd("FileType", {
  group = filetype,
  pattern = "dockerfile",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Auto format on save
local format = augroup("Format", { clear = true })

autocmd("BufWritePre", {
  group = format,
  pattern = { "*.php", "*.js", "*.ts", "*.jsx", "*.tsx", "*.css", "*.scss", "*.html", "*.json", "*.yaml", "*.yml" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Laravel specific
local laravel = augroup("Laravel", { clear = true })

-- Set PHP files in Laravel projects to use Laravel syntax
autocmd({ "BufNewFile", "BufRead" }, {
  group = laravel,
  pattern = "*/laravel/*/*.php",
  command = "set filetype=php.laravel",
})

-- Auto detect Laravel projects
autocmd({ "BufNewFile", "BufRead" }, {
  group = laravel,
  pattern = "*",
  callback = function()
    if vim.fn.filereadable("artisan") == 1 then
      vim.g.laravel_project = true
    end
  end,
})

-- Terminal settings
local terminal = augroup("Terminal", { clear = true })

autocmd("TermOpen", {
  group = terminal,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
