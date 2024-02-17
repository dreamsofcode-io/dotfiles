return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
