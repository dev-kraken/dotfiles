-- Git integration plugins configuration

return {
  -- Git signs for git status in sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff This ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
      end,
    },
  },

  -- Fugitive - Git commands
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git Pull" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },

  -- Better git commit experience
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Choose Ours" })
      vim.keymap.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Choose Theirs" })
      vim.keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Choose Both" })
      vim.keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", { desc = "Choose None" })
      vim.keymap.set("n", "]x", "<Plug>(git-conflict-prev-conflict)", { desc = "Previous Conflict" })
      vim.keymap.set("n", "[x", "<Plug>(git-conflict-next-conflict)", { desc = "Next Conflict" })
    end,
  },

  -- Git worktree management
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")

      -- Keymaps
      vim.keymap.set("n", "<leader>gww", function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end, { desc = "Git Worktrees" })

      vim.keymap.set("n", "<leader>gwc", function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end, { desc = "Create Git Worktree" })
    end,
  },
}
