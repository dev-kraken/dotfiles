-- Utility functions module loader
local M = {}

-- Load helper functions
require("dev-kraken.utils.helpers")

-- Export all utility functions
M.helpers = require("dev-kraken.utils.helpers")

return M
