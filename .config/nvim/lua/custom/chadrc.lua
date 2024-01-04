---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'catppuccin',
  lsp_semantic_tokens = true,
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
