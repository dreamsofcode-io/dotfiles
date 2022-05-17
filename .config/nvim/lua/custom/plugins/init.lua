return {
  ["christoomey/vim-tmux-navigator"] = {},
  ["mboughaba/i3config.vim"] = {},
  ["kyazdani42/nvim-tree.lua"] = {
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },
}
