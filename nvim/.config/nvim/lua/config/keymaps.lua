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
--
-- Add this to your keymaps.lua or init.lua

vim.keymap.set("v", "<leader>yc", function()
  -- Get the start and end line numbers of the visual selection
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  -- Ensure start is always before end (handles selecting backwards)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Get the actual content lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Get the file path relative to the project root (more readable for AI)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  local filetype = vim.bo.filetype

  -- Build the formatted string
  local output = {}
  table.insert(output, "File: " .. filename)
  table.insert(output, "```" .. filetype)

  for i, line in ipairs(lines) do
    local line_num = start_line + i - 1
    -- Format:  123 | code goes here
    table.insert(output, string.format("%4d | %s", line_num, line))
  end

  table.insert(output, "```")

  -- Join with newlines and copy to system clipboard (+)
  local result = table.concat(output, "\n")
  vim.fn.setreg("+", result)

  vim.notify("Copied " .. #lines .. " lines with context to clipboard", vim.log.levels.INFO)
end, { desc = "Copy selection with file & line numbers for AI" })
