-- execute command from current line
vim.keymap.set('n', '<leader><CR>', '<cmd>execute getline(".")<cr>', { desc = "Execute command on line" })
-- go to current file's path
vim.keymap.set('n', '<leader>pc', '<cmd>cd %:p:h<cr>', { desc = "CD to file's directory" })
-- edit (with netrw) current file's path
vim.keymap.set('n', '<leader>pe', '<cmd>e %:p:h<cr>', { desc = "Edit file's directory" })
-- copy current file path to clipboard register
vim.keymap.set({ 'n', 'v' }, '<leader>py', '<cmd>let @+ = expand("%")<cr>',
  { silent = true, desc = "Copy relative path" })
-- absolute path
vim.keymap.set({ 'n', 'v' }, '<leader>pY', '<cmd>let @+ = expand("%:p")<cr>',
  { silent = true, desc = "Copy absolute path" })
-- copy current file path with line number to clipboard register
vim.keymap.set({ 'n', 'v' }, '<leader>pl', '<cmd>let @+ = expand("%").":".line(".")<cr>',
  { silent = true, desc = "Copy relative path:line" })
-- absolute path
vim.keymap.set({ 'n', 'v' }, '<leader>pL', '<cmd>let @+ = expand("%:p").":".line(".")<cr>',
  { silent = true, desc = "Copy absolute path:line" })
-- go to file - vertical
vim.keymap.set('n', 'gv', '<cmd>vertical wincmd f', { silent = true, desc = "Go to file (vsplit)" })

-- tab navigation
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = "Previous tab" })
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', { desc = "Next tab" })
vim.keymap.set('n', '[T', '<cmd>tabfirst<cr>', { desc = "First tab" })
vim.keymap.set('n', ']T', '<cmd>tablast<cr>', { desc = "Last tab" })

-- buffer navigation
vim.keymap.set('n', '<leader>b.', ':b <c-d>', { desc = "Open buffer" })
vim.keymap.set('n', '<leader>bl', ':ls<cr>:b ', { desc = "List and open buffer" })
vim.keymap.set('n', '<leader>bso', ':sb <c-d>', { desc = "Open buffer (split)" })
vim.keymap.set('n', '<leader>bsl', ':ls<cr>:sb ', { desc = "List and open buffer (split)" })
vim.keymap.set('n', '<leader>bvo', ':vert sb <c-d>', { desc = "Open buffer (vsplit)" })
vim.keymap.set('n', '<leader>bvl', ':ls<cr>:vert sb ', { desc = "List and open buffer (vsplit)" })

-- search current word in arglist
vim.keymap.set('n', "<leader>sv", "<cmd>vim <cword> ##<CR>", { desc = "Search current word in arglist" })

-- search for copy register contents
vim.keymap.set('n', "<leader>sc", "<C-r>\"<cr>", { desc = "Search clipboard register" })

-- remove windows line endings in current buffer
vim.keymap.set('n', "<leader>sw", "<cmd>%s/\r//g<CR>", { desc = "Remove Windows line endings" })

-- search for visually selected text
vim.keymap.set("v", "*", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>", { desc = "Search visually selected text" })

---- terminal ----
-- go to normal mode
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = "Terminal: go to normal mode" })
-- send Esc to terminal process
vim.keymap.set('t', '<c-v><esc>', '<esc>', { desc = "Terminal: send Esc" })
-- spawn terminal
vim.keymap.set('n', '<leader>te.', '<cmd>terminal<cr>', { desc = "Open terminal" })
vim.keymap.set('n', '<leader>tes', '<cmd>spl term://bash<cr>', { desc = "Terminal (split)" })
vim.keymap.set('n', '<leader>tev', '<cmd>vsp term://bash<cr>', { desc = "Terminal (vsplit)" })
vim.keymap.set('n', '<leader>tet', '<cmd>tabe term://bash<cr>', { desc = "Terminal (tab)" })

-- diagnostic mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { noremap = true, silent = true, desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist,
  { noremap = true, silent = true, desc = "Diagnostics to quickfix list" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist,
  { noremap = true, silent = true, desc = "Diagnostics to loclist" })
