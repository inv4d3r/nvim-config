---- Highlighting ----

-- debug breakpoints
vim.cmd.highlight({ "debugPC", "ctermbg=gray guibg=gray" })
vim.cmd.highlight({ "debugBreakpoint", "ctermbg=gray", "guibg=gray" })

local debug_augroup = vim.api.nvim_create_augroup('Debug', { clear = true })
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  pattern = '*',
  group = debug_augroup,
  callback = function()
    vim.cmd.highlight({ "debugPC", "ctermbg=gray guibg=gray" })
    vim.cmd.highlight({ "debugBreakpoint", "ctermbg=gray", "guibg=gray" })
  end
})

-- disable syntax for large files
local disable_syntax_augroup = vim.api.nvim_create_augroup('DisableSyntax', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*',
  group = disable_syntax_augroup,
  callback = function()
    if vim.fn.line2byte(vim.fn.line("$") + 1) > 2000000 then
      vim.cmd.syntax("clear")
    end
  end
})
