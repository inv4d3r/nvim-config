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

---- tmux integration ----
vim.fn["minpac#add"]('christoomey/vim-tmux-navigator')
vim.fn["minpac#add"]('roxma/vim-tmux-clipboard')
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<m-h>', '<cmd>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<m-j>', '<cmd>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<m-k>', '<cmd>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<m-l>', '<cmd>TmuxNavigateRight<cr>')
vim.keymap.set('n', '<m-p>', '<cmd>TmuxNavigatePrevious<cr>')

