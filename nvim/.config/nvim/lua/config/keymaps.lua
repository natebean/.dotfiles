-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymap for clearing search highlight
vim.keymap.set("n", "<leader>n", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

-- Keymap for exiting Insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Use remap so we hit the commenting plugin's maps
local toggle_comment = { desc = "Toggle comment", remap = true }
-- vim.keymap.set("n", "<C-_>", "gcc", toggle_comment)
-- vim.keymap.set("v", "<C-_>", "gc", toggle_comment)

-- Alternative mapping for Ctrl+/ if terminal sends <C-/>
vim.keymap.set("n", "<C-/>", "gcc", toggle_comment)
vim.keymap.set("v", "<C-/>", "gc", toggle_comment)
