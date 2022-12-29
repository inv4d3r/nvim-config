---- tags configuration ----
-- generation
vim.opt.tags = "tags"
--vim.g.gutentags_modules = { "ctags" }
--vim.g.gutentags_ctags_extra_args = {"--extra=+q", "/usr/include/c++"}
--vim.g.gutentags_trace = 1
-- navigation
-- open tag in vertical split
vim.keymap.set("n", "<A-]>", ':vsp <CR>:exec("tag ".expand("<cword>"))<CR>')
vim.keymap.set("n", "<A-]>", ':vsp <CR>:exec("tjump ".expand("<cword>"))<CR>')
-- already defined bindings:
-- CTRL-W CTRL-] - open tag in horizontal split
-- CTRL-W } - open tag in preview window
-- CTRL-W z - close preview window
-- CTRL-t - tag stack jump
-- from vim-unimpaired:
-- ]CTRL-T - preview window next tag
-- [CTRL-T - preview window previous tag
