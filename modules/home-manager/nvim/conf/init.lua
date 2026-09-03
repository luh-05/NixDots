vim.g.mapleader = ' '
vim.g.maplocalleader = '\\' -- important for lazy
vim.api.nvim_set_keymap('n', '<Leader>w', ':W<CR>', {
	noremap = true,
	silent = true
})
require("config.lazy")

require("config.mappings")

require("config.options")

require("config.lsp")
