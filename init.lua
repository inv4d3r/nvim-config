---- rust ----
local rust_augroup = vim.api.nvim_create_augroup("Rust", { clear = true })
vim.api.nvim_create_autocmd("filetype", {
  pattern = "rust",
  group = rust_augroup,
  callback = function()
    vim.opt_local.makeprg = "cargo build"
  end
})

---- robot framework ----
local robot_augroup = vim.api.nvim_create_augroup("Robot", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.robot",
  group = robot_augroup,
  callback = function()
    vim.opt_local.filetype = "robot"
  end
})

-- minpac - one package manager to rule them all
vim.cmd.packadd("minpac")
vim.fn["minpac#init"]()
vim.fn["minpac#add"]("k-takata/minpac", { type = 'opt' })

--require("clang")
--require("coc")
require("colorscheme")
--require("cscope")
--require("ctags")
require("debugging")
require("documentation") -- markdown, plantuml, doxygen
--require("fswitch")
require("fzf")
require("git")
require("highlight")
require("lightline")
--require("linux")
require("lsp")
require("options")
require("snippets")
require("termdebug")
require("terminal")
require("treesitter")
require("utilities")
--require("vimspector")
require("vista")
