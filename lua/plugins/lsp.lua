return {
  {
    "hrsh7th/nvim-cmp",
    dependencies =
    {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "windwp/nvim-autopairs",
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim"
    },
    lazy = true,
    config = function()
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
          ['<C-b>'] = cmp.mapping.scroll_docs( -4),
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
          { name = 'path' },
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
    end,
  },
  {
    "nvim-lua/lsp-status.nvim",
    lazy = true,
    config = function()
      local lsp_status = require('lsp-status')
      lsp_status.config({ show_filename = false })
      lsp_status.register_progress()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/nvim-cmp", "simrat39/rust-tools.nvim", "nvim-lua/plenary.nvim", "nvim-lua/lsp-status.nvim" },
    init = function()
      vim.g.lsp_auto_format = true
      local lsp_auto_format_toggle = function()
        vim.g.lsp_auto_format = not vim.g.lsp_auto_format
        if vim.g.lsp_auto_format then
          vim.api.nvim_command('echomsg "lsp auto format enabled"')
        else
          vim.api.nvim_command('echomsg "lsp auto format disabled"')
        end
      end
      vim.keymap.set("n", "<leader>kt", lsp_auto_format_toggle, { silent = true })
      local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        group = lsp_format_augroup,
        callback = function()
          if vim.g.lsp_auto_format then
            vim.lsp.buf.format()
          end
        end
      })
    end,
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_status = require('lsp-status')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local default_on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', '<leader>gD.', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', '<leader>gDs', '<cmd>belowright split | lua vim.lsp.buf.declaration()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gDv', '<cmd>vsplit | lua vim.lsp.buf.declaration()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gDt', '<cmd>tab split | lua vim.lsp.buf.declaration()<cr>', bufopts)

        vim.keymap.set('n', '<leader>gd.', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<leader>gds', '<cmd>belowright split | lua vim.lsp.buf.definition()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gdv', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gdt', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', bufopts)

        vim.keymap.set('n', '<leader>gi.', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>gis', '<cmd>belowright split | lua vim.lsp.buf.implementation()<cr>', bufopts)
        vim.keymap.set('n', '<leader>giv', '<cmd>vsplit | lua vim.lsp.buf.implementation()<cr>', bufopts)
        vim.keymap.set('n', '<leader>git', '<cmd>tab split | lua vim.lsp.buf.implementation()<cr>', bufopts)

        vim.keymap.set('n', '<leader>gt.', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>gts', '<cmd>belowright split | lua vim.lsp.buf.type_definition()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gtv', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gtt', '<cmd>tab split | lua vim.lsp.buf.type_definition()<cr>', bufopts)

        vim.keymap.set('n', '<leader>gc.', vim.lsp.buf.incoming_calls, bufopts)
        vim.keymap.set('n', '<leader>gcs', '<cmd>belowright split | lua vim.lsp.buf.incoming_calls()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gcv', '<cmd>vsplit split | lua vim.lsp.buf.incoming_calls()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gct', '<cmd>tab split | lua vim.lsp.buf.incoming_calls()<cr>', bufopts)

        vim.keymap.set('n', '<leader>go.', vim.lsp.buf.outgoing_calls, bufopts)
        vim.keymap.set('n', '<leader>gos', '<cmd>belowright split | lua vim.lsp.buf.outgoing_calls()<cr>', bufopts)
        vim.keymap.set('n', '<leader>gov', '<cmd>vsplit split | lua vim.lsp.buf.outgoing_calls()<cr>', bufopts)
        vim.keymap.set('n', '<leader>got', '<cmd>tab split | lua vim.lsp.buf.outgoing_calls()<cr>', bufopts)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

        lsp_status.on_attach(client)
      end

      -- flags
      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      -- capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

      -- servers
      local servers = { 'bashls', 'cmake', 'marksman', 'ts_ls', 'jdtls' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = default_on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
        }
      end

      lspconfig['clangd'].setup({
        on_attach = function(client, bufnr)
          default_on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>gs.", "<cmd>ClangdSwitchSourceHeader<cr>")
          vim.keymap.set("n", "<leader>gss", "<cmd>belowright split | ClangdSwitchSourceHeader<cr>")
          vim.keymap.set("n", "<leader>gsv", "<cmd>vsplit | ClangdSwitchSourceHeader<cr>")
          vim.keymap.set("n", "<leader>gst", "<cmd>tab split | ClangdSwitchSourceHeader<cr>")
          vim.keymap.set("n", "<leader>gk", "<cmd>ClangdShowSymbolInfo<cr>")
        end,
        flags = lsp_flags,
        capabilities = capabilities,
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
          clangdFileStatus = true,
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--completion-style=detailed",
          "--header-insertion-decorators",
          "--header-insertion=iwyu",
          "--pch-storage=memory",
        }
      })

      --- python language server ---
      lspconfig['pylsp'].setup({
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              jedi_completion = {
                include_params = true,
              },
              pycodestyle = {
                maxLineLength = 120,
              },
              ruff = {
                enabled = true, -- Enable the plugin
                formatEnabled = true, -- Enable formatting using ruffs formatter
                unsafeFixes = true, -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

                -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
                lineLength = 120, -- Line length to pass to ruff checking and formatting
                exclude = { "__about__.py" }, -- Files to be excluded by ruff checking
                select = { "ALL" }, -- Rules to be enabled by ruff
                ignore = {}, -- Rules to be ignored by ruff
                perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
                preview = true, -- Whether to enable the preview style linting and formatting.
                fixable = { "ALL" },
              },
            },
          },
        },
      })
      ---- rust-analyzer + rust-tools.nvim ----
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(client, bufnr)
            -- Defaults
            default_on_attach(client, bufnr)

            -- Hover actions
            vim.keymap.set("n", "<leader><space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
          flags = lsp_flags,
          capabilities = capabilities,
        },
      })
      ---- robotframework_ls ----
      lspconfig['robotframework_ls'].setup({
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
          robot = { lint = { robocop = { enabled = true } } },
        }
      })
      ---- lua_ls ----
      lspconfig['lua_ls'].setup({
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        on_init = function(client)
          -- if client.workspace_folders then
          --   local path = client.workspace_folders[1].name
          --   if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          --     return
          --   end
          -- end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              -- library = {
              -- vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
              -- }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
      ---- yaml ----
      lspconfig['yamlls'].setup {
        on_attach = default_on_attach,
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
    end,
  },
}
