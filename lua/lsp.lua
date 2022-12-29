---- lsp ----

-- nvim-lspconfig for LSP configurations
vim.fn["minpac#add"]("neovim/nvim-lspconfig")

-- mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<leader>gD.', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>gDs', '<cmd>belowright split | lua vim.lsp.buf.declaration()<cr>', bufopts)
  vim.keymap.set('n', '<leader>gDv', '<cmd>vsplit | lua vim.lsp.buf.declaration()<cr>', bufopts)

  vim.keymap.set('n', '<leader>gd.', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>gds', '<cmd>belowright split | lua vim.lsp.buf.definition()<cr>', bufopts)
  vim.keymap.set('n', '<leader>gdv', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', bufopts)

  vim.keymap.set('n', '<leader>gi.', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>gis', '<cmd>belowright split | lua vim.lsp.buf.implementation()<cr>', bufopts)
  vim.keymap.set('n', '<leader>giv', '<cmd>vsplit | lua vim.lsp.buf.implementation()<cr>', bufopts)

  vim.keymap.set('n', '<leader>gt.', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>gts', '<cmd>belowright split | lua vim.lsp.buf.type_definition()<cr>', bufopts)
  vim.keymap.set('n', '<leader>gtv', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<cr>', bufopts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  if client.name == "clangd" then
    vim.keymap.set("n", "<leader>gs", "<cmd>ClangdSwitchSourceHeader<cr>")
  end
end

-- flags
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- no omnifunc
vim.opt.completeopt = {"menu", "menuone", "noselect"}

---- autocompletion via cmp-nvim ----
vim.fn['minpac#add']('hrsh7th/cmp-nvim-lsp')
vim.fn['minpac#add']('hrsh7th/cmp-nvim-lsp-signature-help')
vim.fn['minpac#add']('hrsh7th/cmp-buffer')
vim.fn['minpac#add']('hrsh7th/cmp-path')
vim.fn['minpac#add']('hrsh7th/cmp-cmdline')
vim.fn['minpac#add']('hrsh7th/nvim-cmp')
vim.fn['minpac#add']('quangnguyen30192/cmp-nvim-ultisnips')
vim.fn['minpac#add']('windwp/nvim-autopairs')

require("nvim-autopairs").setup {}

-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
     --{ name = 'vsnip' }, -- For vsnip users.
     { name = 'nvim_lsp_signature_help' },
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

vim.fn['minpac#add']('nvim-tree/nvim-web-devicons')
vim.fn['minpac#add']('onsails/lspkind.nvim')
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return lspkind.cmp_format({ with_text = false })(entry, vim_item)
    end
  }
}

-- servers
local servers = { 'bashls', 'clangd', 'cmake', 'marksman', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }
end
vim.fn["minpac#add"]("folke/neodev.nvim")
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})
-- setup sumneko and enable call snippets
require('lspconfig')['sumneko_lua'].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
-- configuration from lspconfig, does not work for neovim lua API
--local runtime_path = vim.split(package.path, ";")
--table.insert(runtime_path, "lua/?.lua")
--table.insert(runtime_path, "lua/?/init.lua")
--require('lspconfig')['sumneko_lua'].setup{
  --on_attach = on_attach,
  --flags = lsp_flags,
  --capabilities = capabilities,
  --settings = {
    --Lua = {
      --completion = {
        --callSnippet = "Replace"
      --},
      --runtime = {
        ---- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        --version = 'LuaJIT',
        --path = runtime_path
      --},
      --diagnostics = {
        ---- Get the language server to recognize the `vim` global
        --globals = {'vim'},
      --},
      --workspace = {
        ---- Make the server aware of Neovim runtime files
        --library = vim.api.nvim_get_runtime_file("", true),
      --},
      ---- Do not send telemetry data containing a randomized but unique identifier
      --telemetry = {
        --enable = false,
      --},
    --},
  --},
--}
require('lspconfig')['yamlls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  }
}
