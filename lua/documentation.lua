---- DOcumentation GEnerator ----
vim.fn["minpac#add"]('kkoomen/vim-doge', { ['do'] = 'packloadall! | call doge#install()' })
vim.g.doge_enable_mappings = 0
vim.keymap.set("n", "<leader>doc", "<Plug>(doge-generate)")

---- Markdown ----
vim.g.markdown_folding = 1
vim.fn["minpac#add"]('iamcco/markdown-preview.nvim', { ['do'] = 'packloadall! | call mkdp#util#install()' })
-- open in browser
vim.g.mkdp_browser = 'firefox'
vim.keymap.set("n", "<leader>mb", "<cmd>MarkdownPreview<CR>", { silent = true })
-- open with glow
-- vim.fn["minpac#add"]('skanehira/preview-markdown.vim')
vim.g.preview_markdown_parser = 'glow'
vim.g.preview_markdown_auto_update = 1
vim.keymap.set("n", "<leader>mp", "<cmd>PreviewMarkdown<CR>", { silent = true })
-- do not hide anything
vim.g.markdown_syntax_conceal = 0
-- glow
vim.fn["minpac#add"]('ellisonleao/glow.nvim')
require("glow").setup()
vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })

---- UML ----
-- syntax
vim.fn["minpac#add"]('aklt/plantuml-syntax')
vim.g.plantuml_executable_script = "plantuml -tsvg"
-- inline sequence diagrams generator
vim.fn["minpac#add"]('scrooloose/vim-slumlord')
-- preview in browser
vim.fn["minpac#add"]('tyru/open-browser.vim')
vim.fn["minpac#add"]('weirongxu/plantuml-previewer.vim')
vim.keymap.set("n", "<leader>pp", "<cmd>PlantumlOpen<cr>")
