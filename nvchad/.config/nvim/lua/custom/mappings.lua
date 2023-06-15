local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    ["<C-n>"] = "",
  },
}

-- ["<C-n>"] = { "<cmd> Telescope <CR>", "Telescope" },
-- ["<C-s>"] = { ":Telescope Files <CR>", "Telescope Files" },
--
-- Your custom mappings
M.bean_settings = {
  n = {
    ["<leader>h"] = { ":noh<return>", "no highlight" },
    ["<Leader>y"] = { '"+y', "Yank to system clipboard" },
    ["<Leader>p"] = { '"+p', "Paste from system clipboard" },
    ["<leader>wl"] = { "<C-w>l", "Move to right window" },
    ["<leader>wh"] = { "<C-w>h", "Move to left window" },
    ["<leader>wj"] = { "<C-w>j", "Move to down window" },
    ["<leader>wk"] = { "<C-w>k", "Move to up window" },
    ["<C-l>"] =  {"<C-w>l", "Move to right window" },
    ["<C-h>"] = { "<C-w>h", "Move to left window" },
    ["<C-j>"] = { "<C-w>j",  "Move to down window" },
    ["<C-k>"] = { "<C-w>k",  "Move to up window" },
    ["<leader>wH"] = { "<cmd>split<cr>",  "Horz split" },
    ["<leader>wV"] = { "<cmd>vsplit<cr>",  "Vertical split" },
    ["<leader>wt"] = { "<cmd>tabedit %<cr>",  "Open in tab" },
    ["<leader>e"] = { "<cmd>NvimTreeToggle<return>",  "Toggle NvimTreeToggle" },
    ["<leader>lf"] = { vim.lsp.buf.format,  "Format buffer" },
    ["<C-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
    ["L"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["H"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
  v = {
    ["<Leader>y"] = { '"+y', "Yank to system clipboard" },
    ["<Leader>p"] = { '"+p', "Paste from system clipboard" },
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>", "Not sure" }
  },
}

return M
