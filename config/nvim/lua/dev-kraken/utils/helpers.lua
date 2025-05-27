-- Helper utility functions
local M = {}

-- Check if a plugin is available
function M.is_available(plugin)
  local status, _ = pcall(require, plugin)
  return status
end

-- Get platform info
function M.get_platform()
  if vim.fn.has("win32") == 1 then
    return "windows"
  elseif vim.fn.has("unix") == 1 then
    if vim.fn.has("macunix") == 1 then
      return "macos"
    else
      return "linux"
    end
  end
  return "unknown"
end

-- Check if we're in a git repository
function M.is_git_repo()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result:match("true") ~= nil
  end
  return false
end

-- Get git root directory
function M.get_git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result and result ~= "" then
      return result:gsub("\n", "")
    end
  end
  return nil
end

-- Check if file exists
function M.file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end
  return false
end

-- Check if directory exists
function M.dir_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

-- Get current buffer file type
function M.get_filetype()
  return vim.bo.filetype
end

-- Check if current buffer is a specific file type
function M.is_filetype(ft)
  return vim.bo.filetype == ft
end

-- Get current working directory
function M.get_cwd()
  return vim.fn.getcwd()
end

-- Change to project root (git root if available, otherwise current directory)
function M.cd_to_project_root()
  local git_root = M.get_git_root()
  if git_root then
    vim.cmd("cd " .. git_root)
    return git_root
  end
  return M.get_cwd()
end

-- Toggle boolean option
function M.toggle_option(option)
  vim.o[option] = not vim.o[option]
  print(option .. " = " .. tostring(vim.o[option]))
end

-- Create autocommand group
function M.augroup(name, opts)
  opts = opts or {}
  return vim.api.nvim_create_augroup(name, { clear = opts.clear ~= false })
end

-- Create autocommand
function M.autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

-- Safe keymap creation
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Create command
function M.command(name, fn, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, fn, opts)
end

-- Get visual selection
function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  
  if #lines == 0 then
    return ""
  end
  
  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end
  
  return table.concat(lines, "\n")
end

-- Format file size
function M.format_file_size(size)
  local units = { "B", "KB", "MB", "GB", "TB" }
  local unit_index = 1
  
  while size > 1024 and unit_index < #units do
    size = size / 1024
    unit_index = unit_index + 1
  end
  
  return string.format("%.1f %s", size, units[unit_index])
end

-- Get project files (respecting .gitignore)
function M.get_project_files()
  local files = {}
  local handle = io.popen("find . -type f -not -path '*/.*' -not -path '*/node_modules/*' -not -path '*/vendor/*' 2>/dev/null")
  if handle then
    for line in handle:lines() do
      table.insert(files, line:sub(3)) -- Remove "./" prefix
    end
    handle:close()
  end
  return files
end

-- Laravel specific helpers
M.laravel = {
  -- Check if we're in a Laravel project
  is_laravel_project = function()
    return M.file_exists("artisan") and M.file_exists("composer.json")
  end,
  
  -- Get Laravel app path
  get_app_path = function()
    if M.laravel.is_laravel_project() then
      return M.get_cwd() .. "/app"
    end
    return nil
  end,
  
  -- Get Laravel routes
  get_routes_file = function()
    if M.laravel.is_laravel_project() then
      return M.get_cwd() .. "/routes/web.php"
    end
    return nil
  end,
}

-- PHP specific helpers
M.php = {
  -- Check if current file is a PHP file
  is_php_file = function()
    return M.is_filetype("php")
  end,
  
  -- Get PHP class name from file path
  get_class_name = function(file_path)
    local file_name = vim.fn.fnamemodify(file_path or vim.fn.expand("%"), ":t:r")
    return file_name
  end,
  
  -- Get PHP namespace from file path (Laravel convention)
  get_namespace = function(file_path)
    file_path = file_path or vim.fn.expand("%:p")
    local app_path = M.laravel.get_app_path()
    
    if app_path and file_path:find(app_path, 1, true) then
      local relative_path = file_path:sub(#app_path + 2):gsub("/[^/]+%.php$", "")
      if relative_path ~= "" then
        return "App\\" .. relative_path:gsub("/", "\\")
      else
        return "App"
      end
    end
    
    return nil
  end,
}

-- Docker specific helpers
M.docker = {
  -- Check if we're in a Docker project
  is_docker_project = function()
    return M.file_exists("Dockerfile") or M.file_exists("docker-compose.yml") or M.file_exists("docker-compose.yaml")
  end,
  
  -- Get docker-compose file
  get_compose_file = function()
    if M.file_exists("docker-compose.yml") then
      return "docker-compose.yml"
    elseif M.file_exists("docker-compose.yaml") then
      return "docker-compose.yaml"
    end
    return nil
  end,
}

-- Git specific helpers
M.git = {
  -- Get current git branch
  get_current_branch = function()
    local handle = io.popen("git branch --show-current 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      if result and result ~= "" then
        return result:gsub("\n", "")
      end
    end
    return nil
  end,
  
  -- Get git status
  get_status = function()
    local handle = io.popen("git status --porcelain 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return result
    end
    return nil
  end,
  
  -- Check if repository has uncommitted changes
  has_changes = function()
    local status = M.git.get_status()
    return status and status ~= ""
  end,
}

-- Terminal specific helpers
M.terminal = {
  -- Run command in floating terminal
  run_float = function(cmd)
    if M.is_available("toggleterm") then
      local Terminal = require("toggleterm.terminal").Terminal
      local term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
        float_opts = {
          border = "double",
        },
      })
      term:toggle()
    else
      vim.cmd("terminal " .. cmd)
    end
  end,
  
  -- Run command in horizontal split
  run_horizontal = function(cmd)
    if M.is_available("toggleterm") then
      local Terminal = require("toggleterm.terminal").Terminal
      local term = Terminal:new({
        cmd = cmd,
        direction = "horizontal",
        close_on_exit = false,
      })
      term:toggle()
    else
      vim.cmd("split | terminal " .. cmd)
    end
  end,
}

-- Notification helpers
M.notify = {
  -- Send info notification
  info = function(msg, title)
    if M.is_available("notify") then
      require("notify")(msg, "info", { title = title or "Info" })
    else
      print("[INFO] " .. (title and title .. ": " or "") .. msg)
    end
  end,
  
  -- Send warning notification
  warn = function(msg, title)
    if M.is_available("notify") then
      require("notify")(msg, "warn", { title = title or "Warning" })
    else
      print("[WARN] " .. (title and title .. ": " or "") .. msg)
    end
  end,
  
  -- Send error notification
  error = function(msg, title)
    if M.is_available("notify") then
      require("notify")(msg, "error", { title = title or "Error" })
    else
      print("[ERROR] " .. (title and title .. ": " or "") .. msg)
    end
  end,
}

return M
