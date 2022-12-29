-- file & fuzzy navigation

---- fzf plugins ----
vim.fn["minpac#add"]('junegunn/fzf', { ['do'] = 'call fzf#install()' })
vim.fn["minpac#add"]('junegunn/fzf.vim')

---- fzf config ----
vim.g.fzf_command_prefix = "Fzf"
vim.keymap.set("n", "<leader>za", "<cmd>FzfAg<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>FzfBuffers<CR>")
vim.keymap.set("n", "<leader>zB", "<cmd>FzfHistory<CR>")
vim.keymap.set("n", "<leader>zc", "<cmd>FzfCommits<CR>")
vim.keymap.set("n", "<leader>zd", "<cmd>FzfBCommits<CR>")
vim.keymap.set("n", "<leader>ze", "<cmd>FzfCommands<CR>")
vim.keymap.set("n", "<leader>zf", "<cmd>FzfFiles<CR>")
vim.keymap.set("n", "<leader>zh", "<cmd>FzfHistory:<CR>")
vim.keymap.set("n", "<leader>zH", "<cmd>FzfHistory/<CR>")
vim.keymap.set("n", "<leader>zg", "<cmd>FzfGFiles<CR>")
vim.keymap.set("n", "<leader>zG", "<cmd>FzfGFiles?<CR>")
vim.keymap.set("n", "<leader>zm", "<cmd>FzfMarks<CR>")
vim.keymap.set("n", "<leader>zs", "<cmd>FzfSnippets<CR>")
vim.keymap.set("n", "<leader>zt", "<cmd>FzfTags<CR>")
vim.keymap.set("n", "<leader>zu", "<cmd>FzfBTags<CR>")

-- fzf ag shortcuts
--vim.keymap.set("n", "<leader>ag", "<cmd>FzfAg <C-R><C-W><CR>")
--vim.keymap.set("n", "<leader>af", "<cmd>FzfAg <C-R><C-W>\\(<CR>")
--vim.keymap.set("n", "<leader>as", "<cmd>FzfAg struct <C-R><C-W> {<CR>")

-- fzf rg shortcuts
vim.keymap.set("n", "<leader>rg", "<cmd>FzfRg <C-R><C-W><CR>")
vim.keymap.set("n", "<leader>rf", "<cmd>FzfRg <C-R><C-W>\\(<CR>")
vim.keymap.set("n", "<leader>rs", "<cmd>FzfRg struct <C-R><C-W> {<CR>")
vim.keymap.set("n", "<leader>r<space>", ":FzfRg ")
vim.keymap.set("n", "<leader>rg", "<cmd>FzfRg <C-R>=escape(@\",'/')<CR><CR>")
