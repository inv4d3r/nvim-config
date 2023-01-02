---- clang-format ----
vim.g.clang_format_py_path = vim.fn.system("find /usr/share/clang -name clang-format.py | head -n1 | tr -d '\n'")
local clang_format_file = function ()
  vim.cmd("py3f " .. vim.g.clang_format_py_path)
end
vim.keymap.set("n", "<leader>kf", clang_format_file, { silent = true})
-- auto formatting toggle
vim.g.clang_auto_format = true
local clang_format_toggle = function()
  vim.g.clang_auto_format = not vim.g.clang_auto_format
  if vim.g.clang_auto_format == true then
    vim.api.nvim_command('echomsg "clang auto format enabled"')
  else
    vim.api.nvim_command('echomsg "clang auto format disabled"')
  end
end
vim.keymap.set("n", "<leader>kt", clang_format_toggle, { silent = true})

---- auto format ----
local clang_format_augroup = vim.api.nvim_create_augroup("ClangFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = clang_format_augroup,
  callback = function ()
      local ft = vim.bo.filetype
      if (ft == "c" or ft == "cpp" or ft == "objc" or ft == "proto" or ft == "arduino")
      and vim.g.clang_auto_format then
        clang_format_file()
      end
  end
})

---- recognize .clangd file as yaml ----
local clangd_augroup = vim.api.nvim_create_augroup("Clangd", { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = ".clangd",
  group = clangd_augroup,
  callback = function()
    vim.opt_local.syntax = "yaml"
  end
})
