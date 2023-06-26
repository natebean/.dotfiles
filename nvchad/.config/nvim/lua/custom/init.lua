vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mousemodel = "extend" -- no popup
-- vim.opt.wrap = false
vim.opt.colorcolumn = 80
vim.cmd("let g:sneak#label = 1")

vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
