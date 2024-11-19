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

---- terminal ----
-- go to normal mode
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
-- send Esc to terminal process
vim.keymap.set('t', '<c-v><esc>', '<esc>')
-- spawn terminal
vim.keymap.set('n', '<leader>t.', '<cmd>terminal<cr>')
vim.keymap.set('n', '<leader>ts', '<cmd>spl term://bash<cr>')
vim.keymap.set('n', '<leader>tv', '<cmd>vsp term://bash<cr>')
vim.keymap.set('n', '<leader>te', '<cmd>tabe term://bash<cr>')

-- diagnostic mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>gof', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>gq', vim.diagnostic.setloclist, opts)
