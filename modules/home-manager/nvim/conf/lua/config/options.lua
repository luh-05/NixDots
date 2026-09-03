-- general
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true -- indent brackets correctly
vim.o.cino = "N-s" -- disable namespace indents
vim.o.wrap = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes" -- leave room for lsp warnings on the left
vim.o.winborder = "rounded"

-- diagnostics
vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_text = true,
	sings = true,
	underline = true,
})

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- jumps
vim.o.jumpoptions = "stack"
-- vim.o.globaljumplist = false
