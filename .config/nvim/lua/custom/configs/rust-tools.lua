local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"/Users/elliott/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer"},
  }
}

return options
