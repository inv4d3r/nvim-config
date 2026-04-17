return {
  ---- DOcumentation GEnerator ----
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    init = function()
      vim.g.doge_enable_mappings = 0
    end,
    config = function()
      vim.keymap.set("n", "<leader>md", "<Plug>(doge-generate)", { desc = "Generate documentation" })
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
      vim.keymap.set("n", "<leader>mb", "<Plug>MarkdownPreviewToggle",
        { silent = true, desc = "Markdown preview toggle" })
    end
  },
  -- render-markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- opts = { enabled = false },
    config = function()
      local rm = require('render-markdown')
      rm.setup({ enabled = false })
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>",
        { silent = true, desc = "Render markdown toggle" })
    end
  },
  -- glow
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
      vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true, desc = "Glow markdown preview" })
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
      vim.keymap.set("n", "<leader>mo", "<cmd>PlantumlOpen<cr>", { desc = "PlantUML open preview" })
    end
  },
}
