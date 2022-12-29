-- options

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.autoread = true

vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 4
vim.opt.foldopen = "all"
vim.opt.foldclose = "all"

vim.opt.ignorecase = true
vim.opt.smartcase = true

local env_home = vim.env.HOME;
vim.opt.undofile = true
vim.opt.undodir = env_home .. "/undodir"

vim.opt.path:append("**")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.background = "dark"
vim.opt.hlsearch = true
vim.opt.sessionoptions:append({"buffers", "curdir", "tabpages", "winpos", "winsize"})

vim.opt.list = true
vim.opt.listchars={tab = "→ ", nbsp = "¬"}

vim.opt.clipboard:append({"unnamed", "unnamedplus"})

vim.opt.colorcolumn = {"121"}

---- latex configuration ----
vim.g.tex_flavor = "latex"
