return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	keys = {
		{ "<leader>tt", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle live typst preview" },
	},
}
