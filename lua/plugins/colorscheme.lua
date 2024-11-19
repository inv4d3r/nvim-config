local system_theme = vim.env.THEME

return {
  {
    "arcticicestudio/nord-vim",
    lazy = system_theme == "nord"
  },
  {
    "dracula/vim",
    lazy = system_theme == "dracula",
    priority = 1000
  },
  {
    -- Changed in diffs are not higlighted correctly: https://github.com/Mofiqul/dracula.nvim/issues/75
    "Mofiqul/dracula.nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = {
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = true, -- default false
      -- use transparent background
      transparent_bg = true, -- default false
      -- set custom lualine background color
      -- lualine_bg_color = "#44475a",   -- default nil
      -- set italic comment
      italic_comment = true, -- default false
      -- overrides the default highlights with table see `:h synIDattr`
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = system_theme == "gruvbox",
    priority = 1000,
    init = function()
      -- material (default), mix, original
      vim.g.gruvbox_material_palette = "material"
      -- hard, medium (default), soft
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },
  { "nanotech/jellybeans.vim",            lazy = system_theme == "jellybeans",                    priority = 1000 },
  { "sjl/badwolf",                        lazy = system_theme == "badwolf",                       priority = 1000 },
  { "tyrannicaltoucan/vim-deep-space",    lazy = system_theme == "" or system_theme == "default", priority = 1000 },
  { "w0ng/vim-hybrid",                    lazy = true,                                            priority = 1000 },
  { "kristijanhusak/vim-hybrid-material", lazy = system_theme == "grayscale",                     priority = 1000 },
  { "whatyouhide/vim-gotham",             lazy = true,                                            priority = 1000 },
}
