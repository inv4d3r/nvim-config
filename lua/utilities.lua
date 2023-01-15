-- execute command from current line
vim.keymap.set('n', '<leader><CR>', '<cmd>execute getline(".")<cr>')
-- go to current file's path
vim.keymap.set('n', '<leader>pc', '<cmd>cd %:p:h<cr>')
-- edit (with netrw) current file's path
vim.keymap.set('n', '<leader>pe', '<cmd>e %:p:h<cr>')
-- copy current file path to clipboard register
vim.keymap.set({ 'n', 'v' }, '<leader>py', '<cmd>let @+ = expand("%")<cr>', { silent = true })
-- absolute path
vim.keymap.set({ 'n', 'v' }, '<leader>pY', '<cmd>let @+ = expand("%:p")<cr>', { silent = true })
-- go to file - vertical
vim.keymap.set('n', 'gv', '<cmd>vertical wincmd f', { silent = true })

-- tab navigation
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>')
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>')
vim.keymap.set('n', '[T', '<cmd>tabfirst<cr>')
vim.keymap.set('n', ']T', '<cmd>tablast<cr>')

-- buffer navigation
vim.keymap.set('n', '<leader>b.', ':b <c-d>')
vim.keymap.set('n', '<leader>bl', ':ls<cr>:b ')
vim.keymap.set('n', '<leader>bs', ':sb <c-d>')
vim.keymap.set('n', '<leader>bsl', ':ls<cr>:sb ')
vim.keymap.set('n', '<leader>bv', ':vert sb <c-d>')
vim.keymap.set('n', '<leader>bvl', ':ls<cr>:vert sb ')

-- trailing whitespace mappings
-- current buffer
vim.keymap.set('n', "<leader>wrb", "<cmd>%s/\\s\\+$//ge<cr>")
vim.keymap.set('n', "<leader>wsb", "/\\s\\+$<cr>")
-- arglist
vim.keymap.set('n', "<leader>wra", "<cmd>argdo %s/\\s\\+$//ge<CR>")
vim.keymap.set('n', "<leader>wsa", "<cmd>vim /\\s\\+$/ ##<CR>")
-- quickfix list
vim.keymap.set('n', "<leader>wrq", "<cmd>cdo s/\\s\\+$//e<CR>")

-- search current word in arglist
vim.keymap.set('n', "<leader>wsv", "<cmd>vim <cword> ##<CR>")

-- search for copy register contents
vim.keymap.set('n', "<leader>wsc", "<C-r>\"<cr>")

-- remove windows line endings in current buffer
vim.keymap.set('n', "<leader>wlr", "<cmd>%s/\r//g<CR>")

-- search for visually selected text
vim.keymap.set("v", "*", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>")

-- show vertical lines for indentation level
vim.fn["minpac#add"]('yggdroot/indentline')
vim.g.vim_json_conceal = 0

-- utility plugins
vim.fn["minpac#add"]('dhruvasagar/vim-zoom')
vim.fn["minpac#add"]('milkypostman/vim-togglelist')
vim.fn["minpac#add"]('dhruvasagar/vim-table-mode')
vim.fn["minpac#add"]('godlygeek/tabular')
vim.fn["minpac#add"]('tommcdo/vim-exchange')
vim.fn["minpac#add"]('raimondi/delimitmate')
vim.fn["minpac#add"]('tpope/vim-endwise')
vim.fn["minpac#add"]('tpope/vim-repeat')
vim.fn["minpac#add"]('tpope/vim-surround')
vim.fn["minpac#add"]('tpope/vim-unimpaired')
vim.fn["minpac#add"]('tpope/vim-sleuth')
vim.fn["minpac#add"]('tpope/vim-vinegar')

-- word motion
vim.g.wordmotion_prefix = '<Space>'
vim.fn["minpac#add"]('chaoren/vim-wordmotion')

-- undo tree
vim.fn["minpac#add"]('mbbill/undotree')
vim.keymap.set("n", "<leader>U", "<cmd>UndotreeToggle<CR>")

---- Substitute configuration ----
vim.fn["minpac#add"]('tpope/vim-abolish')
vim.keymap.set("n", "<leader>/", ":S/")

-- dispatch compiler
vim.fn["minpac#add"]('tpope/vim-dispatch')
local SaveAndMake = function()
  vim.fn.execute("wa")
  vim.fn.execute("silent Make")
end
vim.keymap.set("n", "<leader>mk", SaveAndMake)

---- NERDCommenter ----
vim.fn["minpac#add"]('scrooloose/nerdcommenter')
-- configuration
vim.g.NERDCompactSexyComs = 1
vim.g.NERDTrimTrailingWhitespace = 1

---- nvim-tree ----
vim.fn["minpac#add"]('nvim-tree/nvim-tree.lua')
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>ge", require("nvim-tree").toggle)
vim.keymap.set("n", "<leader>gf", require("nvim-tree").focus)

---- vim-gtest ----
vim.fn["minpac#add"]('alepez/vim-gtest')
vim.g["gtest#hightlight_failing_tests"] = 1
vim.keymap.set("n", "]G", "<cmd>GTestNext<CR>")
vim.keymap.set("n", "[G", "<cmd>GTestPrev<CR>")
vim.keymap.set("n", "<leader>Gt", "<cmd>GTestRun<CR>")
vim.keymap.set("n", "<leader>Gu", "<cmd>GTestRunUnderCursor<CR>")
vim.keymap.set("n", "<leader>zT", "<cmd>FZFGTest<CR>")
