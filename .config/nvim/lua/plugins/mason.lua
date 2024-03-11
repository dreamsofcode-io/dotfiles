return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require('mason').setup(opts)
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = require "plugins.configs.mason",
    dependencies = { "williamboman/mason.nvim" },
    cmd = {
      "MasonToolsInstall", "MasonToolsInstallSync",
      "MasonToolsUpdate", "MasonToolsUpdateSync",
      "MasonToolsClean",
    }
  }
}
