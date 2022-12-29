---- fswitch - switch to header/source plugin ----
vim.fn["minpac#add"]('derekwyatt/vim-fswitch')

-- options
vim.g.fsnonewfiles = "on"

-- mappings
vim.keymap.set("n", "<leader>e.", "<cmd>FSHere<CR>")
vim.keymap.set("n", "<leader>et", "<cmd>FSTab<CR>")
vim.keymap.set("n", "<leader>ek", "<cmd>FSAbove<CR>")
vim.keymap.set("n", "<leader>ej", "<cmd>FSBelow<CR>")
vim.keymap.set("n", "<leader>eh", "<cmd>FSLeft<CR>")
vim.keymap.set("n", "<leader>el", "<cmd>FSRight<CR>")
vim.keymap.set("n", "<leader>ewk", "<cmd>FSSplitAbove<CR>")
vim.keymap.set("n", "<leader>ewj", "<cmd>FSSplitBelow<CR>")
vim.keymap.set("n", "<leader>ewh", "<cmd>FSSplitLeft<CR>")
vim.keymap.set("n", "<leader>ewl", "<cmd>FSSplitRight<CR>")

