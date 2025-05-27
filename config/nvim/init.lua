vim.cmd("syntax off")  -- Keep this! Prevents E1155 + lets TreeSitter handle syntax
-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("dev-kraken.core")

-- Load plugins
require("dev-kraken.plugins")
