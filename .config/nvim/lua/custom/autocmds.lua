local autocmd = vim.api.nvim_create_autocmd

-- open nvim with a dir while still lazy loading nvimtree
autocmd("BufEnter", {
  callback = function()
    if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
      vim.cmd "lcd %:p:h"
    end
  end,
})

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})
