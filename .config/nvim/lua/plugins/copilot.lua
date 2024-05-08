return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    opts = function()
      return require("plugins.configs.copilot")
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}
