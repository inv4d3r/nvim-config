---- lightline colorscheme plugins ---
vim.fn["minpac#add"]('itchyny/lightline.vim')
vim.fn["minpac#add"]('cocopon/lightline-hybrid.vim')
vim.fn["minpac#add"]('shinchu/lightline-gruvbox.vim')
vim.fn["minpac#add"]('844196/lightline-badwolf.vim')

---- lightline name ----
local env_theme = vim.env.THEME
local lightline_name = ""
if env_theme == "" or env_theme == "default" then
    lightline_name = "ayu_dark"
elseif env_theme == "badwolf" then
    lightline_name = "badwolf"
elseif env_theme == "dracula" then
    lightline_name = "darcula"
elseif env_theme == "grayscale" then
    lightline_name = "hybrid"
elseif env_theme == "gruvbox" then
    lightline_name = "gruvbox_material"
elseif env_theme == "nord" then
    lightline_name = "nord"
elseif env_theme == "jellybeans" then
    lightline_name = "jellybeans"
else
    lightline_name = "one"
end

---- lightline functions ----
vim.g.NearestMethodOrFunction = function()
  return vim.fn.getbufvar("", "vista_nearest_method_or_function", "")
end

vim.g.LspStatus = function()
    if #vim.lsp.get_active_clients() > 0 then
        return require("lsp-status").status_progress()
    end
    return ""
end

---- lightline configution ----
-- hybrid - (cocopon) hybrid, deus, one, solarized
-- dracula - darcula
-- grayscale - hybrid (plain style), seoul256, OldHope
-- jellybeans
-- nord
-- gruvbox - (shinchu) gruvbox
-- badwolf - (844196) badwolf, molokai
vim.g.lightline = {
      colorscheme = lightline_name,
      active = {
        left = { { "mode", "paste" },
                  { "lspstatus", "vistamethod", "gitbranch", "readonly", "filename", "modified" } }
      },
      component_function = {
        gitbranch = "FugitiveHead",
        lspstatus = "g:LspStatus",
        vistamethod = "g:NearestMethodOrFunction",
        sleuth = "SleuthIndicator"
      }
}
