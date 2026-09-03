return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		lazy = false,
		-- main = "nvim-treesitter.config",
		branch = "main",
		config = function()
			local TS = require("nvim-treesitter")
			TS.install({
				"rust",
				"javascript",
				"zig",
				"c",
				"cpp",
				"java",
				"typst",
				"bash",
				-- "zsh",
				"fish",
				"svelte",
				"lua",
				"luadoc",
				"matlab",
				"python",
				"c_sharp",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					if vim.bo.buftype ~= "" then
						return -- skip non-file buffers
					end

					local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
					if not lang then
						return -- no parser for this filetype
					end

					local ok, parser = pcall(vim.treesitter.get_parser, 0, lang)
					if not ok or not parser then
						return -- parser failed to load
					end

					vim.treesitter.start()
				end,
			})
		end,
	},
}
