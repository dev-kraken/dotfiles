-- Key mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General keymaps
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":q!<CR>", opts)
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bD", ":%bdelete<CR>", opts)
keymap("n", "<leader>bo", ":%bdelete|edit #|bdelete #<CR>", opts)

-- Window/Split management
keymap("n", "<leader>sv", "<C-w>v", opts) -- split vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- split horizontally
keymap("n", "<leader>se", "<C-w>=", opts) -- make splits equal
keymap("n", "<leader>sx", ":close<CR>", opts) -- close current split

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- PHP/Laravel specific keymaps
keymap("n", "<leader>pa", ":terminal php artisan ", { noremap = true })
keymap("n", "<leader>pm", ":terminal php artisan migrate<CR>", opts)
keymap("n", "<leader>pc", ":terminal php artisan config:clear && php artisan cache:clear<CR>", opts)
keymap("n", "<leader>pr", ":terminal php artisan route:list<CR>", opts)
keymap("n", "<leader>pt", ":terminal php artisan test<CR>", opts)
keymap("n", "<leader>ps", ":terminal php artisan serve<CR>", opts)

-- Docker keymaps
keymap("n", "<leader>dc", ":terminal docker-compose ", { noremap = true })
keymap("n", "<leader>du", ":terminal docker-compose up -d<CR>", opts)
keymap("n", "<leader>dd", ":terminal docker-compose down<CR>", opts)
keymap("n", "<leader>db", ":terminal docker build .", opts)
keymap("n", "<leader>dl", ":terminal docker logs -f ", { noremap = true })

-- MySQL/Database keymaps
keymap("n", "<leader>ms", ":terminal mysql -u root -p<CR>", opts)

-- Quick fix navigation
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cc", ":cclose<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)

-- Location list navigation
keymap("n", "<leader>lo", ":lopen<CR>", opts)
keymap("n", "<leader>lc", ":lclose<CR>", opts)
keymap("n", "]l", ":lnext<CR>", opts)
keymap("n", "[l", ":lprev<CR>", opts)

-- Terminal functions
keymap("n", "<leader>tf", "<cmd>lua _FLOAT_TERM_TOGGLE()<CR>", { desc = "Float terminal" })
keymap("n", "<leader>th", "<cmd>lua _HORIZONTAL_TERM_TOGGLE()<CR>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>lua _VERTICAL_TERM_TOGGLE()<CR>", { desc = "Vertical terminal" })
keymap("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
keymap("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Node REPL" })
keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Python REPL" })
keymap("n", "<leader>tP", "<cmd>lua _PHP_TOGGLE()<CR>", { desc = "PHP REPL" })
keymap("n", "<leader>tH", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Htop" })

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>E", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "Recent files" })
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
keymap("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
keymap("n", "<leader>fs", ":Telescope grep_string<CR>", { desc = "Grep string under cursor" })
keymap("n", "<leader>fw", ":Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Diagnostics" })
keymap("n", "<leader>fj", ":Telescope jumplist<CR>", { desc = "Jumplist" })
keymap("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Marks" })
keymap("n", "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffer fuzzy find" })

-- LSP
keymap("n", "gd", ":Telescope lsp_definitions<CR>", { desc = "Go to definition" })
keymap("n", "gr", ":Telescope lsp_references<CR>", { desc = "Go to references" })
keymap("n", "gi", ":Telescope lsp_implementations<CR>", { desc = "Go to implementation" })
keymap("n", "<leader>lD", ":Telescope lsp_type_definitions<CR>", { desc = "Type definition" })
keymap("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
keymap("n", "<leader>lw", ":Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })
keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", { desc = "Format file" })
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover info" })
keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
keymap("n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", { desc = "Show line diagnostics" })

-- Git
keymap("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status" })
keymap("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })
keymap("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
keymap("n", "<leader>gf", ":Telescope git_files<CR>", { desc = "Git files" })

-- Trouble
keymap("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Toggle Trouble" })
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", { desc = "Document diagnostics" })
keymap("n", "<leader>xl", ":TroubleToggle loclist<CR>", { desc = "Location list" })
keymap("n", "<leader>xq", ":TroubleToggle quickfix<CR>", { desc = "Quickfix list" })
keymap("n", "gR", ":TroubleToggle lsp_references<CR>", { desc = "LSP references" })

-- REST Client
keymap("n", "<leader>rr", ":Rest run<CR>", { desc = "Run REST request" })
keymap("n", "<leader>rl", ":Rest run last<CR>", { desc = "Run last REST request" })

-- Database
keymap("n", "<leader>bu", ":DBUIToggle<CR>", { desc = "Toggle database UI" })
keymap("n", "<leader>bf", ":DBUIFindBuffer<CR>", { desc = "Find database buffer" })
keymap("n", "<leader>br", ":DBUIRenameBuffer<CR>", { desc = "Rename database buffer" })
keymap("n", "<leader>bq", ":DBUILastQueryInfo<CR>", { desc = "Last query info" })

-- TreeSitter inspection (modern alternatives to deprecated commands)
keymap("n", "<leader>ti", vim.treesitter.inspect_tree, { desc = "TreeSitter: Inspect Tree" })
keymap("n", "<leader>th", function()
  local captures = vim.treesitter.get_captures_at_cursor(0)
  if #captures == 0 then
    print("No TreeSitter captures under cursor")
  else
    print("TreeSitter captures: " .. table.concat(captures, ", "))
  end
end, { desc = "TreeSitter: Show Captures Under Cursor" })
