-- Autocompletion configuration
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- source for command line
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- Tab completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- Configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
          },
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- Set configuration for specific filetype
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end,
}
