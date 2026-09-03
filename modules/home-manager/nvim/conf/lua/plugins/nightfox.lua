return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	opts = {
		options = {
			styles = {
				variables = "italic",
			},
		},
	},
	config = function()
		vim.cmd("colorscheme nightfox")
	end,
}
