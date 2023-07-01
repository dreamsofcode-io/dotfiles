vim.g.dap_virtual_text = true
vim.opt.colorcolumn = "80"

-- Disable persistent undo for files in /private directory
vim.api.nvim_create_autocmd("BufReadPre", { pattern = "/private/*", command = "set noundofile" })

-- Enable persistent undo for other files
vim.opt.undofile = true
