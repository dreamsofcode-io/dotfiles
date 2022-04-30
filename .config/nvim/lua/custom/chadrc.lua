local userPlugins = require "custom/plugins"
local map = require('core/utils').map

local M = {}

M.plugins = {
  install = userPlugins,
  options = {
    lspconfig = {
      setup_lspconf = "custom/plugins/lspconfig",
    },
  },
}

return M
