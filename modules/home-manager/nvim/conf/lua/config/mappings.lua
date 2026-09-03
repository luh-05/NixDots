-- config dev
vim.keymap.set("n", "<leader>so", ":update<cr> :source<cr>", { desc = "Source config" })

-- general
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y<cr>', { desc = "Yank into system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d<cr>', { desc = "Cut into system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p<cr>', { desc = "Paste from system clipboard" })

-- keep visual selection after indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- diagnostics
vim.keymap.set("n", "<Leader>sd", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- movement
vim.keymap.set("n", "<Leader>l", "g_", { desc = "Move to end of line" })
vim.keymap.set("n", "<Leader>h", "^", { desc = "Move to beginning of line" })

-- autocmds
-- Format on save for LSP-supported filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false }) -- sync to ensure file saves formatted
	end,
})

-- vim.keymap.set({ "s", "v" }, "<S-P>", '"_dP<cr>', { noremap = true, silent = true })
