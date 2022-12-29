---- Termdebug ----
vim.cmd.packadd("termdebug")
vim.g.termdebug_wide = 163

-- Shift + <F5-F12>
vim.keymap.set("n", "<F17>", "<cmd>Continue<CR>", { silent = true })
vim.keymap.set("n", "<F18>", "<cmd>Finish<CR>", { silent = true })
vim.keymap.set("n", "<F19>", "<cmd>Stop<CR>", { silent = true })
vim.keymap.set("n", "<F20>", "<cmd>Clear<CR>", { silent = true })
vim.keymap.set("n", "<F21>", "<cmd>Break<CR>", { silent = true })
vim.keymap.set("n", "<F22>", "<cmd>Over<CR>", { silent = true })
vim.keymap.set("n", "<F23>", "<cmd>Step<CR>", { silent = true })
vim.keymap.set("n", "<F24>", "<cmd>Run<CR>", { silent = true })
