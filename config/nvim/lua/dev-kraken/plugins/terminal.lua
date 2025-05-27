-- Terminal Integration Plugins
return {
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Set terminal keymaps using modern autocmd API
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        end,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- Floating terminal
      local float_term = Terminal:new({
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _FLOAT_TERM_TOGGLE()
        float_term:toggle()
      end

      -- Horizontal terminal
      local horizontal_term = Terminal:new({
        direction = "horizontal",
        size = 15,
      })

      function _HORIZONTAL_TERM_TOGGLE()
        horizontal_term:toggle()
      end

      -- Vertical terminal
      local vertical_term = Terminal:new({
        direction = "vertical",
        size = vim.o.columns * 0.4,
      })

      function _VERTICAL_TERM_TOGGLE()
        vertical_term:toggle()
      end

      -- Lazygit
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Node REPL
      local node = Terminal:new({
        cmd = "node",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      function _NODE_TOGGLE()
        node:toggle()
      end

      -- Python REPL
      local python = Terminal:new({
        cmd = "python3",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      function _PYTHON_TOGGLE()
        python:toggle()
      end

      -- PHP REPL
      local php = Terminal:new({
        cmd = "php -a",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      function _PHP_TOGGLE()
        php:toggle()
      end

      -- Docker compose
      local docker_compose = Terminal:new({
        cmd = "docker-compose",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      function _DOCKER_COMPOSE_TOGGLE()
        docker_compose:toggle()
      end

      -- Htop
      local htop = Terminal:new({
        cmd = "htop",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      function _HTOP_TOGGLE()
        htop:toggle()
      end
    end,
  },
}
