return {
  "m4xshen/autoclose.nvim",
  event = "VeryLazy",
  config = function ()
    require("autoclose").setup({
      -- keys = {
      --   ["|"] = { escape = true, close = true, pair = "||", disabled_filetypes = {} },
      -- }, 
    })
  end
}
