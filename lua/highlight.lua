---- Highlighting ----

-- debug breakpoints
vim.cmd.highlight({"debugPC", "ctermbg=gray guibg=gray"})
vim.cmd.highlight({"debugBreakpoint", "ctermbg=gray", "guibg=gray"})

local debug_augroup = vim.api.nvim_create_augroup('Debug', { clear = true })
vim.api.nvim_create_autocmd( {'ColorScheme' }, {
  pattern = '*',
  group = debug_augroup,
  callback = function ()
    vim.cmd.highlight({"debugPC", "ctermbg=gray guibg=gray"})
    vim.cmd.highlight({"debugBreakpoint", "ctermbg=gray", "guibg=gray"})
  end
})

local column_augroup = vim.api.nvim_create_augroup('ColorColumn', { clear = true })
vim.api.nvim_create_autocmd( {'ColorScheme' }, {
  pattern = '*',
  group = column_augroup,
  command = 'highlight ColorColumn ctermbg=167 guibg=darkred',
})

-- whitespaces
vim.cmd.highlight({"ExtraWhitespace", "ctermfg=red", "guifg=red", "ctermbg=red", "guibg=red"})
local whitespace_augroup = vim.api.nvim_create_augroup('ExtraWhitespace', { clear = true })
local whitespace_patterns = { "*.c", "*.cpp", "*.h", "*.hpp", "*.rs", "*.py", "*.js", "*.ts"}
vim.api.nvim_create_autocmd( {'ColorScheme' }, {
  pattern = whitespace_patterns,
  group = whitespace_augroup,
  command = 'highlight ExtraWhitespace ctermbg=red guibg=red',
})
vim.api.nvim_create_autocmd( {'BufWinEnter' }, {
  pattern = whitespace_patterns,
  group = whitespace_augroup,
  command = "match ExtraWhitespace /\\s\\+$/",
})
vim.api.nvim_create_autocmd( {'BufWinLeave' }, {
  pattern = whitespace_patterns,
  group = whitespace_augroup,
  command = 'call clearmatches()',
})
vim.api.nvim_create_autocmd( {'BufWritePre' }, {
  pattern = whitespace_patterns,
  group = whitespace_augroup,
  callback = function ()
      local ft = vim.bo.filetype
      if ft ~= "text" and ft ~= "markdown" and ft ~= "rst" then
        vim.cmd(":%s/\\s\\+$//e")
      end
  end
})

-- disable syntax for large files
local disable_syntax_augroup = vim.api.nvim_create_augroup('DisableSyntax', { clear = true })
vim.api.nvim_create_autocmd( {'BufWinEnter' }, {
  pattern = '*',
  group = disable_syntax_augroup,
  callback = function ()
      if vim.fn.line2byte(vim.fn.line("$") + 1) > 2000000 then
        vim.cmd.syntax("clear")
      end
  end
})

-- clear search highlighting
vim.keymap.set('n', '<c-l>', '<cmd>nohl<cr>')

---- highlight plugins ----
-- show colors
vim.fn["minpac#add"]("RRethy/vim-hexokinase", { ['do'] = "make hexokinase" })
-- show marks
vim.fn["minpac#add"]('kshenoy/vim-signature')

