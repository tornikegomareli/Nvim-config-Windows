local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Import the comment utility
local comment_utils = require("utils.comments")

-- Helper function to find project root
local function get_project_root()
  -- Try to find root based on common project markers
  local markers = {
    ".git", -- Git repository
    ".gitignore", -- Git ignore file
    "package.json", -- Node.js projects
    "Cargo.toml", -- Rust projects
    "Project.swift", -- Swift projects
    "Package.swift", -- Swift package
    "build.gradle", -- Gradle projects
    "pom.xml", -- Maven projects
    "Makefile", -- Make projects
  }

  -- Common patterns to identify Xcode project structure
  -- But not only xcode, basically iOS, or Swift project.
  local xcode_markers = {
    "*.xcodeproj",
    "*.xcworkspace",
    "Package.swift",
  }

  -- Start from the current buffer's directory
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")
  local root = current_dir

  -- Function to check for markers in a directory
  local function has_marker(dir, pattern)
    local result = vim.fn.glob(dir .. "/" .. pattern)
    return result ~= ""
  end

  -- Search upward until we find a marker or hit the filesystem root
  while root ~= "/" do
    -- Check for any project markers
    for _, marker in ipairs(markers) do
      if has_marker(root, marker) then
        return root
      end
    end

    -- Special check for Xcode project markers
    for _, marker in ipairs(xcode_markers) do
      if has_marker(root, marker) then
        return root
      end
    end

    -- Move up one directory
    root = vim.fn.fnamemodify(root, ":h")
  end

  -- If no root found, return the current directory
  return current_dir
end

-- Common file ignore patterns
local ignore_patterns = {
  "%.git/.*",
  "%.xcodeproj/.*",
  "%.build/.*",
  "%.derived/.*",
  "%.swiftpm/.*",
  "DerivedData/.*",
  "%.generated/.*",
  "%.idea/.*",
  "%.gradle/.*",
  "%.spm/.*",
  "fastlane/.*",
  "Pods/.*",
}

-- Functions
local open_plugins_lua = function()
  vim.cmd("edit C:/Users/Tornike/AppData/Local/nvim")
end

-- Fuzzy finding
vim.api.nvim_set_keymap("n", "<M-f>", ":Telescope current_buffer_fuzzy_find<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-O>", ":Telescope find_files<CR>", opts)

-- LSP
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- Text Selecting
-- Map Ctrl + A to select all text
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", opts)
vim.api.nvim_set_keymap("i", "<C-a>", "<Esc>ggVG", opts)
vim.api.nvim_set_keymap("v", "<C-a>", "<Esc>ggVG", opts)

-- Map Ctrl + Z to undo
vim.api.nvim_set_keymap("n", "<C-z>", "u", opts)
vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u", opts)
vim.api.nvim_set_keymap("v", "<C-z>", "<C-o>u", opts)

-- Map Ctrl + C to copy visually selected text to system clipboard
vim.api.nvim_set_keymap("n", "<C-c>", '"+y', opts)
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', opts)
vim.api.nvim_set_keymap("i", "<C-c>", '<Esc>"+y', opts)

-- Map Ctrl + V to paste text from system clipboard
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', opts)
vim.api.nvim_set_keymap("v", "<C-v>", '"+p', opts)
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pa', opts)

-- Map Ctrl + X to cut visually selected text to system clipboard
vim.api.nvim_set_keymap("n", "<C-x>", '"+d', opts)
vim.api.nvim_set_keymap("v", "<C-x>", '"+d', opts)
vim.api.nvim_set_keymap("i", "<C-x>", '<Esc>"+da', opts)

-- Project navigation (similar to VS Code/modern IDEs)
vim.api.nvim_set_keymap("n", "<C-S-J>", ":NvimTreeFindFileToggle<CR>", opts)

-- General mappings
keymap.set("n", ";", ":", { desc = "Enter command mode" })
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>fed", open_plugins_lua, { desc = "Open plugins.lua" })

-- Save file
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", opts)
vim.api.nvim_set_keymap("i", "<C-s>", "<C-\\><C-n>:w<CR>", opts)

-- Default Telescope mappings
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

-- Default file finder
keymap.set("n", "<CR>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Navigation
vim.api.nvim_set_keymap("n", "gb", "<C-o>", opts)

-- Find files (ALT+SHIFT+O)
keymap.set("n", "<M-S-o>", function()
  require("telescope.builtin").find_files({
    cwd = get_project_root(),
    hidden = true,
    no_ignore = false,
    file_ignore_patterns = ignore_patterns,
    previewer = false,
    layout_config = {
      height = 0.4,
    },
  })
end, { desc = "Find files (Xcode style)" })

-- Alternative mapping using leader key
keymap.set("n", "<leader>xf", function()
  require("telescope.builtin").find_files({
    cwd = get_project_root(),
    hidden = true,
    no_ignore = false,
    file_ignore_patterns = ignore_patterns,
    previewer = false,
    layout_config = {
      height = 0.4,
    },
  })
end, { desc = "Find files (Xcode style)" })

-- Search in files (ALT+SHIFT+F)
keymap.set("n", "<M-S-f>", function()
  require("telescope.builtin").live_grep({
    cwd = get_project_root(),
    additional_args = function()
      return { "--hidden" }
    end,
    file_ignore_patterns = ignore_patterns,
  })
end, { desc = "Search in files (Xcode style)" })

-- Alternative mapping using leader key
keymap.set("n", "<leader>xs", function()
  require("telescope.builtin").live_grep({
    cwd = get_project_root(),
    additional_args = function()
      return { "--hidden" }
    end,
    file_ignore_patterns = ignore_patterns,
  })
end, { desc = "Search in files (Xcode style)" })

-- Comment keybindings
vim.api.nvim_set_keymap("n", "<M-/>", ':lua require("utils.comment").toggle_comment()<CR>', opts)
vim.api.nvim_set_keymap("v", "<M-/>", ':lua require("utils.comment").toggle_comment()<CR>', opts)
