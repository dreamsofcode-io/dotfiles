local M = {}

function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  local util = require "lspconfig/util"

  local servers = { }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end

  lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    cmd_env = {
      GOFLAGS = "-tags=test,e2e_test,integration_test,acceptance_test",
    },
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }

  vim.cmd [[ 
  augroup GO_LSP 
    autocmd!
    autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
    autocmd BufWritePre *.go :silent! lua org_imports(3000)
  augroup END
  ]]
end

return M
