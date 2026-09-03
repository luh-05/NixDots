return {
	"nanozuki/tabby.nvim",
	lazy = false,
	-- event = 'VimEnter', -- if you want lazy load, see below
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.o.showtabline = 2
		vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
		-- local theme = {
		-- 	-- this is carbonfox theme
		-- 	fill = "TabLineFill",
		-- 	head = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
		-- 	current_tab = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
		-- 	tab = { fg = "#c5cdd9", bg = "#1c1e26", style = "italic" },
		-- 	win = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
		-- 	tail = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
		-- }
		-- local function get_hl(group, default_fg, default_bg)
		-- 	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		-- 	return {
		-- 		fg = hl.fg and string.format("#%06x", hl.fg) or default_fg,
		-- 		bg = hl.bg and string.format("#%06x", hl.bg) or default_bg,
		-- 	}
		-- end
		-- local theme = {
		-- 	-- Active tab uses the selected TabLine highlight or primary accent
		-- 	current_tab = get_hl("TabLineSel", "#ffffff", "#005f87"),
		--
		-- 	-- Inactive tabs use standard TabLine colors
		-- 	tab = get_hl("TabLine", "#808080", "#1c1c1c"),
		--
		-- 	-- Empty background space in the tabline
		-- 	fill = get_hl("TabLineFill", "NONE", "#121212"),
		-- }

		require("tabby.tabline").set(function(line)
			-- Pass the dynamic theme into your Tabby renderer layout
			return {
				-- Your tabby layout components here using `theme`
			}
		end)
		local theme = {
			fill = "TabLineFill",
			-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
			head = "TabLine",
			current_tab = "TabLineSel",
			tab = "TabLine",
			win = "TabLine",
			tail = "TabLine",
		}
		require("tabby.tabline").set(function(line)
			return {
				{
					-- { "  ", hl = theme.head },
					-- line.sep("", theme.head, theme.fill),
					-- line.sep("│", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab

					-- remove count of wins in tab with [n+] included in tab.name()
					local name = tab.name()
					local index = string.find(name, "%[%d")
					local tab_name = index and string.sub(name, 1, index - 1) or name

					-- indicate if any of buffers in tab have unsaved changes
					local modified = false
					local readonly = false
					local win_ids = require("tabby.module.api").get_tab_wins(tab.id)
					for _, win_id in ipairs(win_ids) do
						if pcall(vim.api.nvim_win_get_buf, win_id) then
							local bufid = vim.api.nvim_win_get_buf(win_id)
							if vim.api.nvim_get_option_value("modified", { buf = bufid }) then
								modified = true
								break
							end
							if vim.api.nvim_get_option_value("readonly", { buf = bufid }) then
								readonly = true
								break
							end
						end
					end

					return {

						line.sep("│", hl, theme.fill),
						-- line.sep("", hl, theme.fill),
						tab.in_jump_mode() and tab.jump_key() or tab.number(),
						tab_name,
						modified
								and (tab.is_current() and (readonly and "󰷫" or "") or (readonly and "󰷮" or "󰲶"))
							or readonly and "",
						line.sep("│", hl, theme.fill),
						-- line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				{
					-- line.sep("", theme.tail, theme.fill),
					-- { "  ", hl = theme.tail },
				},
				hl = theme.fill,
			}
		end)
		-- require('tabby').setup({
		--   line = function(line)
		--     return {
		--       {
		--         { '  ', hl = theme.head },
		--         line.sep('', theme.head, theme.fill),
		--       },
		--       line.tabs().foreach(function(tab)
		--         local hl = tab.is_current() and theme.current_tab or theme.tab
		--         return {
		--           line.sep('', hl, theme.fill),
		--           tab.is_current() and '' or '󰆣',
		--           tab.number(),
		--           tab.name(),
		--           tab.close_btn(''),
		--           line.sep('', hl, theme.fill),
		--           hl = hl,
		--           margin = ' ',
		--         }
		--       end),
		--       line.spacer(),
		--       line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
		--         return {
		--           line.sep('', theme.win, theme.fill),
		--           win.is_current() and '' or '',
		--           win.buf_name(),
		--           line.sep('', theme.win, theme.fill),
		--           hl = theme.win,
		--           margin = ' ',
		--         }
		--       end),
		--       {
		--         line.sep('', theme.tail, theme.fill),
		--         { '  ', hl = theme.tail },
		--       },
		--       hl = theme.fill,
		--     }
		--   end,
		--   -- option = {}, -- setup modules' option,
		-- })
	end,
	keys = {
		{ "ta", "<cmd>$tabnew<cr>", desc = "Open new tab" },
		{ "tq", "<cmd>tabclose<cr>", desc = "Close tab" },
		{ "<Tab>", "<cmd>tabn<cr>", desc = "Move to next tab" },
		{ "<s-Tab>", "<cmd>tabp<cr>", desc = "Move to previous tab" },
		{ "t+", "<cmd>+tabmove<cr>", desc = "Move tab left" },
		{ "t-", "<cmd>-tabmove<cr>", desc = "Move tab right" },
		{ "tj", "<cmd>Tabby jump_to_tab<cr>", desc = "Jump to tab interactively" },
	},
}
