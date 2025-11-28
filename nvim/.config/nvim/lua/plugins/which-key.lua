-- return {
--   {
--     "folke/which-key.nvim",
--     opts = function(_, opts)
--       opts.defaults = opts.defaults or {}
--       opts.defaults["<leader>a"] = { name = "+ai" }
--     end,
--   },
-- }
-- {
--   { "<leader>a", group = "ai" },
-- }
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}
