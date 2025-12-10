-- return {
--   "stevearc/oil.nvim",
--   ---@module 'oil'
--   ---@type oil.SetupOpts
--   opts = {},
--   -- Optional dependencies
--   dependencies = { { "nvim-mini/mini.icons", opts = {} } },
--   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
--   lazy = false,
-- }
return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["q"] = "actions.close",
      ["H"] = "actions.parent",
      ["L"] = "actions.select",
      ["gh"] = "actions.toggle_hidden",
      ["gs"] = "actions.change_sort",
    },
  },
  keys = {
    -- Primary navigation
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },

    -- Leader mappings
    { "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" },
    { "<leader>O", "<cmd>Oil .<CR>", desc = "Open Oil (cwd)" },

    -- Finder-style mapping
    { "<leader>fo", "<cmd>Oil<CR>", desc = "Find files (Oil)" },
  },
}
