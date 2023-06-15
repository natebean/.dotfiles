local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "tsserver", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.lua_ls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- local util = require('lspconfig/util')
--
-- local path = util.path
--
-- local function get_python_path(workspace)
--   print("Getting Python Path " .. type(workspace))
--   -- print("Getting Python Path ")
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     -- print("Found VIRTUAL_ENV: " .. vim.env.VIRTUAL_ENV)
--     return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
--   end
--
--   -- Find and use virtualenv from pipenv in workspace directory.
--   local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
--   if match ~= '' then
--     local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
--     return path.join(venv, 'bin', 'python')
--   end
--
--   -- Fallback to system Python.
--   -- print("Using System Python")
--   return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
-- end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  -- on_init = function(client)
  -- 	client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  -- end,
}



-- lspconfig["rust-analyzer"].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   -- Server-specific settings...
--   settings = {
--     ["rust-analyzer"] = {},
--   },
-- }
