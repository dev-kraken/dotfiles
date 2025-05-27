-- LSP Configuration
local M = {}

-- Setup LSP handlers first
require("dev-kraken.plugins.lsp.handlers").setup()

-- Setup language servers
require("dev-kraken.plugins.lsp.servers").setup()

return M
