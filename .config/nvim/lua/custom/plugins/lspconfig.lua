local M = {}
function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
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

  lspconfig.rust_analyzer.setup({
    filetypes = {"rust"},
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = function ()
      vim.lsp.buf.formatting()
    end
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = function ()
      org_imports(3000)
    end
  })
end

return M
