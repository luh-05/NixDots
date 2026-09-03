return {
	"Wansmer/symbol-usage.nvim",
	event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
	opts = {
		definition = {
			enable = true,
		},
	},
	config = function()
		require("symbol-usage").setup()
	end,
}
