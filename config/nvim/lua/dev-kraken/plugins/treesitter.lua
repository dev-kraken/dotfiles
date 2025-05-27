-- Treesitter configuration for syntax highlighting and code parsing

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "yaml",
          "toml",
          "html",
          "css",
          "scss",
          "bash",
          "fish",
          "dockerfile",
          "go",
          "rust",
          "c",
          "cpp",
          "java",
          "php",
          "ruby",
          "sql",
          "graphql",
          "markdown",
          "markdown_inline",
          "terraform",
          "hcl",
          "helm",
        },

        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
      })

      -- Setup treesitter context
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        min_window_height = 20,
        line_numbers = true,
        multiline_threshold = 1,
        trim_scope = "outer",
        mode = "cursor",
      })
    end,
  },
}
