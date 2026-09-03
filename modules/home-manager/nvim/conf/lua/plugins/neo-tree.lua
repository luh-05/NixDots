return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {  
      filesystem = {  
        cwd_target = {  
          sidebar = "global", -- Use global working directory instead of per-tab  
          current = "window"  
        }  
      },
      default_component_configs = {
        last_modified = {
          format = "relative",
        },
      },
    },
    keys = {
      { "<leader>e", "<cmd>Neotree filesystem reveal left toggle=true<cr>", desc = "Show side bar file tree" },
      -- {
      --   "<leader>e",
      --   function()  
      --     local current_tab = vim.api.nvim_get_current_tabpage()  
      --     for _, tab in ipairs(vim.api.nvim_list_tabpages()) do  
      --       vim.api.nvim_set_current_tabpage(tab)  
      --       vim.cmd("Neotree filesystem toggle left")  
      --     end  
      --     vim.api.nvim_set_current_tabpage(current_tab)  
      --   end,
      --   desc = "Show side bar file tree"
      -- },
      { "<leader>E", "<cmd>Neotree filesystem reveal float toggle=true<cr>", desc = "Show floating file tree" },
    }, 
  }
}
