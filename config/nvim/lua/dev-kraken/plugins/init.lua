-- Plugin manager setup and plugin list

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Import plugin configurations
local ui_plugins = require("dev-kraken.plugins.ui")
local editor_plugins = require("dev-kraken.plugins.editor")
local terminal_plugins = require("dev-kraken.plugins.terminal")
local devops_plugins = require("dev-kraken.plugins.devops")

-- Additional core plugins
local core_plugins = {
  -- Telescope (Fuzzy finder)
  require("dev-kraken.plugins.telescope"),
  
  -- Treesitter (Syntax highlighting)
  require("dev-kraken.plugins.treesitter"),
  
  -- Autocompletion
  require("dev-kraken.plugins.completion"),
  
  -- Git integration
  require("dev-kraken.plugins.git"),
  
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim", -- JSON schemas
    },
    config = function()
      require("dev-kraken.plugins.lsp")
    end,
  },

  -- Laravel/PHP specific
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "tpope/vim-dotenv", -- Temporarily disabled due to netrw event conflict
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async", -- Required for Laravel.nvim
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel routes" },
      { "<leader>lm", ":Laravel related<cr>", desc = "Laravel related" },
    },
    event = { "VeryLazy" },
    config = function()
      require("laravel").setup()
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },
}

-- Combine all plugin configurations
local all_plugins = {}

-- Add UI plugins
for _, plugin in ipairs(ui_plugins) do
  table.insert(all_plugins, plugin)
end

-- Add editor plugins
for _, plugin in ipairs(editor_plugins) do
  table.insert(all_plugins, plugin)
end

-- Add terminal plugins
for _, plugin in ipairs(terminal_plugins) do
  table.insert(all_plugins, plugin)
end

-- Add devops plugins
for _, plugin in ipairs(devops_plugins) do
  table.insert(all_plugins, plugin)
end

-- Add core plugins
for _, plugin in ipairs(core_plugins) do
  table.insert(all_plugins, plugin)
end

-- Setup lazy.nvim with all plugins
require("lazy").setup(all_plugins, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
