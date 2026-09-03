return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.1",
	-- lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
		"sharkdp/fd",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<Leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
		{ "<Leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope find buffers" },
		{ "<Leader>ft", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
	},
}
