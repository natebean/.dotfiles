-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymap for clearing search highlight
vim.keymap.set("n", "<leader>n", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

-- Keymap for exiting Insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })
