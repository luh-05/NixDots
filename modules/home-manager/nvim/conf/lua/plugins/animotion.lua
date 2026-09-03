return {
	"luiscassih/AniMotion.nvim",
	lazy = false,
	-- event = "VeryLazy",
	config = function()
		local hl = vim.api.nvim_get_hl(0, { name = "TabLineSel", link = false })
		require("AniMotion").setup({
			mode = "helix",
			clear_keys = { ";" },
			-- color = "blue",
			color = { fg = hl.fg, bg = hl.bg },
			edit_keys = { "c", "d", "s", "r", "y", "p" },
		})
	end,
}
