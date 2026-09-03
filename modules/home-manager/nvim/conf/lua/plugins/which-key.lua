return {
  "folke/which-key.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  event = "VeryLazy",
  opts = {
    win = {  
      col = -1,  -- Right align  
      row = -1,  -- Bottom align  
      width = { min = 30, max = 60 },  -- Optional: constrain width  
      height = { min = 4, max = 0.75 }, -- Optional: constrain height  
      border = "rounded",  -- Optional: add border  
    },
    icons = {  
      breadcrumb = "»",  
      separator = "➜",   
      group = "+",  
      mappings = true,  -- Enable all mapping icons  
      colors = true,    -- Use mini.icons colors when available  
      rules = {  
        -- Custom icon rules with colors  
        { pattern = "git", icon = "", color = "red" },  
        { pattern = "file", icon = "", color = "blue" },  
        { pattern = "find", icon = "", color = "green" },  
      },  
      -- Custom key icons  
      keys = {  
        Up = " ",  
        Down = " ",  
        Left = " ",  
        Right = " ",  
        Space = "󱁐 ",  
      }  
    },
    defer = function(ctx)  
      -- Always defer in visual modes - wait for additional key press  
      return ctx.mode == "v" or ctx.mode == "V" or ctx.mode == "<C-V>"  
    end, 
  },
  config = function(_, opts)  
    require("which-key").setup(opts)  
    -- Custom highlight groups  
    vim.api.nvim_set_hl(0, "WhichKey", { link = "Function" })  
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "FloatBorder" })  
    vim.api.nvim_set_hl(0, "WhichKeyDesc", { link = "Identifier" })  
    vim.api.nvim_set_hl(0, "WhichKeyGroup", { link = "Keyword" })  
    vim.api.nvim_set_hl(0, "WhichKeySeparator", { link = "Comment" })  
    vim.api.nvim_set_hl(0, "WhichKeyIcon", { link = "@markup.link" })  
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
