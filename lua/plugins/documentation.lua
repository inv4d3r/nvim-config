return {
  ---- DOcumentation GEnerator ----
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    init = function()
      vim.g.doge_enable_mappings = 0
    end,
    config = function()
      vim.keymap.set("n", "<leader>doc", "<Plug>(doge-generate)")
    end
  },
  ---- Markdown previewer ----
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ':call mkdp#util#install()',
    init = function()
      -- open with glow
      vim.g.preview_markdown_parser = 'glow'
      vim.g.preview_markdown_auto_update = 1
      -- do not hide anything
      vim.g.markdown_syntax_conceal = 0
    end,
    config = function()
      vim.keymap.set("n", "<leader>mb", "<Plug>MarkdownPreviewToggle", { silent = true })
    end
  },
  -- render-markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- opts = { enabled = false },
    config = function()
      local rm = require('render-markdown')
      rm.setup({ enabled = false })
      vim.keymap.set("n", "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", { silent = true })
    end
  },
  -- glow
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
      vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })
    end
  },
  ---- UML ----
  -- syntax
  {
    "aklt/plantuml-syntax",
    init = function()
      vim.g.plantuml_executable_script = "plantuml -tsvg"
    end,
  },
  -- inline sequence diagrams generator
  { "scrooloose/vim-slumlord" },
  -- preview in browser
  { "tyru/open-browser.vim" },
  {
    "weirongxu/plantuml-previewer.vim",
    config = function()
      vim.keymap.set("n", "<leader>pp", "<cmd>PlantumlOpen<cr>")
    end
  },
}
