return {
	{
		"nvim-mini/mini.indentscope",
		-- verison = false,
		lazy = false,
		config = function()
			require("mini.indentscope").setup({
				symbol = "│",
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "│" }, -- Dim static vertical lines
			scope = { enabled = false }, -- Disable its internal scope so mini.indentscope handles it
		},
	},
	{
		"nvim-mini/mini.pick",
		lazy = false,
		keys = {
			{
				"<leader>h",
				function()
					require("mini.pick").builtin.help()
				end,
				desc = "Open mini.pick help tag searcher",
			},
		},
	},
}
