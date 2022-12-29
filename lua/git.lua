---- gitgutter - show git diff signs ----
vim.fn["minpac#add"]('airblade/vim-gitgutter')

---- gitv - gitk for vim ----
vim.fn["minpac#add"]('gregsexton/gitv')

---- git-messenger - reveal commit message ----
vim.fn["minpac#add"]('rhysd/git-messenger.vim')
vim.keymap.set("n", "<leader>gm", "<cmd>GitMessenger<CR>")

---- fugitive - abstract git commands ----
vim.fn["minpac#add"]('tpope/vim-fugitive')
