local env_theme = vim.env.THEME
local scheme_name = ""
if env_theme == "" or env_theme == "default" then
  scheme_name = "deep-space"
elseif env_theme == "badwolf" then
  scheme_name = "badwolf"
elseif env_theme == "dracula" then
  scheme_name = "dracula"
  -- scheme_name = "dracula-soft"
elseif env_theme == "grayscale" then
  vim.g.enable_bold_font = 1
  vim.g.enable_italic_font = 1
  -- scheme_name = "hybrid"
  -- scheme_name = "hybrid_material"
  -- scheme_name = "hybrid_reverse"
  scheme_name = "gruvbox-material"
elseif env_theme == "gruvbox" then
  -- material (default), mix, original
  vim.g.gruvbox_material_palette = "material"
  -- hard, medium (default), soft
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_enable_italic = 1
  scheme_name = "gruvbox-material"
elseif env_theme == "nord" then
  scheme_name = "nord"
else
  scheme_name = env_theme
end
vim.cmd.colorscheme(scheme_name)
