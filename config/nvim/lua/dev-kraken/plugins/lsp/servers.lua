-- LSP server configurations

local M = {}

function M.setup()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local handlers = require("dev-kraken.plugins.lsp.handlers")

  -- Setup handlers first
  handlers.setup()

  -- Setup Mason
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "cssls",
      "html",
      "ts_ls", -- TypeScript/JavaScript (was tsserver)
      "pyright",
      "bashls",
      "jsonls",
      "yamlls",
      "intelephense", -- PHP
      "sqlls",
      "dockerls",
      "tailwindcss",
    },
    automatic_installation = true,
  })

  -- Default configuration for all servers
  local default_config = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  -- Server-specific configurations
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    intelephense = {
      settings = {
        intelephense = {
          files = {
            maxSize = 1000000,
          },
        },
      },
    },
    ts_ls = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literal",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    yamlls = {
      settings = {
        yaml = {
          keyOrdering = false,
        },
      },
    },
  }

  -- Setup each server manually
  local available_servers = mason_lspconfig.get_installed_servers()
  
  for _, server_name in ipairs(available_servers) do
    local config = vim.tbl_deep_extend("force", default_config, servers[server_name] or {})
    lspconfig[server_name].setup(config)
  end

  -- Also setup servers that might not be installed via Mason
  for server_name, server_config in pairs(servers) do
    if not vim.tbl_contains(available_servers, server_name) then
      local config = vim.tbl_deep_extend("force", default_config, server_config)
      pcall(function()
        lspconfig[server_name].setup(config)
      end)
    end
  end
end

return M
