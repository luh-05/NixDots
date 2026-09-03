local severity = vim.diagnostic.severity

vim.diagnostic.config({
	update_in_insert = true,
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})

vim.lsp.enable("clangd")
vim.lsp.inlay_hint.enable(true)
