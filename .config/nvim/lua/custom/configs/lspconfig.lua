local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.pylsp.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  cmd_env = {
    GOFLAGS = "-tags=test,e2e_test,integration_test,acceptance_test",
  },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}


--vim.api.nvim_create_autocmd("BufWritePre", {
  --pattern = { "*.go" },
  --callback = function ()
    --vim.lsp.buf.format()
  --end
--})
