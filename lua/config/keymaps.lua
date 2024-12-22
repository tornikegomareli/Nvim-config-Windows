-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Functions
local open_plugins_lua = function()
  vim.cmd("edit C:/Users/Tornike/AppData/Local/nvim/init.lua")
end

-- Fuzzy finding
vim.api.nvim_set_keymap("n", "<M-f>", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })
-- Find files like in modern IDEs
vim.api.nvim_set_keymap("n", "<C-O>", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- LSP
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- Text Selecting
-- Map Ctrl + A to select all text
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })

-- Map Ctrl + Z to undo
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-z>", "<C-o>u", { noremap = true, silent = true })

-- Map Ctrl + C to copy visually selected text to system clipboard
vim.api.nvim_set_keymap("n", "<C-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-c>", '<Esc>"+y', { noremap = true, silent = true })

-- Map Ctrl + V to paste text from system clipboard
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })

-- Map Ctrl + X to cut visually selected text to system clipboard
vim.api.nvim_set_keymap("n", "<C-x>", '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-x>", '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-x>", '<Esc>"+da', { noremap = true, silent = true })

-- Project navigation (similar to VS Code/modern IDEs)
vim.api.nvim_set_keymap("n", "<C-S-J>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })

-- General mappings
local map = vim.keymap.set
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>fed", open_plugins_lua, { desc = "Open plugins.lua" })

-- Save file
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<C-\\><C-n>:w<CR>", { noremap = true, silent = true })

-- Telescope mappings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

-- Default file finder
vim.keymap.set("n", "<CR>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Navigation
vim.api.nvim_set_keymap("n", "gb", "<C-o>", { noremap = true, silent = true })

-- lua/config/keymaps.lua
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Find files (ALT+SHIFT+O)
keymap.set("n", "<M-S-o>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = false,
    file_ignore_patterns = {
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
    },
    previewer = false,
    layout_config = {
      height = 0.4, -- Make the window shorter
    },
  })
end, { desc = "Find files (Xcode style)" })

-- Alternative mapping using leader key
keymap.set("n", "<leader>xf", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = false,
    file_ignore_patterns = {
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
    },
    previewer = false,
    layout_config = {
      height = 0.4,
    },
  })
end, { desc = "Find files (Xcode style)" })

-- Search in files (ALT+SHIFT+F)
keymap.set("n", "<M-S-f>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" }
    end,
    file_ignore_patterns = {
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
    },
  })
end, { desc = "Search in files (Xcode style)" })

-- Alternative mapping using leader key
keymap.set("n", "<leader>xs", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" }
    end,
    file_ignore_patterns = {
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
    },
  })
end, { desc = "Search in files (Xcode style)" })
