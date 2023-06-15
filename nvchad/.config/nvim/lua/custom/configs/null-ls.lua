
-- local null_ls = require("null-ls")
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.diagnostics.eslint,
-- 		null_ls.builtins.completion.spell,
-- 		null_ls.builtins.formatting.autopep8,
-- 		null_ls.builtins.diagnostics.flake8,
-- 	},
-- })

-- custom/configs/null-ls.lua

local null_ls = require "null-ls"

local opts = {
  sources = {
    -- null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint
  }
}

return opts

-- local formatting = null_ls.builtins.formatting
-- local lint = null_ls.builtins.diagnostics
--
-- local sources = {
--    formatting.prettier,
--    formatting.stylua,
-- 	 formatting.eslint,
-- 	 formatting.autopep8,
--
-- 	 lint.flake8,
--    lint.shellcheck,
--
-- 	 null_ls.builtins.completion.spell,
-- }
--
-- null_ls.setup {
--    debug = true,
--    sources = sources,
-- }



