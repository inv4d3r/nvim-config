-- vista - modern Tagbar replacement
vim.fn["minpac#add"]('liuchengxu/vista.vim')
vim.g.vista_default_executive = 'nvim_lsp'
vim.keymap.set("n", "<leader>vo", "<cmd>Vista<CR>")
vim.keymap.set("n", "<leader>vc", "<cmd>Vista!<CR>")
vim.keymap.set("n", "<leader>vt", "<cmd>Vista!!<CR>")
vim.keymap.set("n", "<leader>vf", "<cmd>Vista finder<CR>")

--local vista_augroup = vim.api.nvim_create_augroup("Vista", { clear = true })
--vim.api.nvim_create_autocmd({"VimEnter"}, {
  --pattern = "*",
  --group = vista_augroup,
  --command = "call vista#RunForNearestMethodOrFunction()"
--})
