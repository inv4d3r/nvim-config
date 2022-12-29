-- colorscheme plugins
vim.fn["minpac#add"]('dracula/vim', { name = 'dracula'})
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.fn["minpac#add"]('arcticicestudio/nord-vim')
vim.fn["minpac#add"]('sainnhe/gruvbox-material')
vim.fn["minpac#add"]('nanotech/jellybeans.vim')
vim.fn["minpac#add"]('sjl/badwolf')
vim.fn["minpac#add"]('tyrannicaltoucan/vim-deep-space')
vim.fn["minpac#add"]('w0ng/vim-hybrid')
vim.fn["minpac#add"]('kristijanhusak/vim-hybrid-material')
vim.fn["minpac#add"]('whatyouhide/vim-gotham')

-- colorscheme
local env_theme = vim.env.THEME
local scheme_name = ""
if env_theme == "" or env_theme == "default" then
    scheme_name = "deep-space"
elseif env_theme == "badwolf" then
    scheme_name = "badwolf"
elseif env_theme == "dracula" then
    scheme_name = "dracula"
elseif env_theme == "grayscale" then
    vim.g.enable_bold_font = 1
    vim.g.enable_italic_font = 1
    --scheme_name = "hybrid"
    --scheme_name = "hybrid_material"
    scheme_name = "hybrid_reverse"
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
