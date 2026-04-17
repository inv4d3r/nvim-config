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
      "onsails/lspkind.nvim", -- VS Code–style pictograms for Neovim completion items
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
    dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim", "nvim-lua/lsp-status.nvim" },
    init = function()
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●', -- Could be '■', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          format = function(diagnostic)
            if diagnostic.source then
              return string.format("%s [%s]", diagnostic.message, diagnostic.source)
            end
            return diagnostic.message
          end,
        },
      })

      vim.g.lsp_auto_format = true
      local lsp_auto_format_toggle = function()
        vim.g.lsp_auto_format = not vim.g.lsp_auto_format
        if vim.g.lsp_auto_format then
          vim.api.nvim_command('echomsg "lsp auto format enabled"')
        else
          vim.api.nvim_command('echomsg "lsp auto format disabled"')
        end
      end
      vim.keymap.set("n", "<leader>ft", lsp_auto_format_toggle, { silent = true, desc = "Toggle LSP auto-format" })
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
      local lsp_status = require('lsp-status')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local default_on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        -- goto declaration
        map('n', '<leader>gD.', vim.lsp.buf.declaration, "Go to declaration")
        map('n', '<leader>gDs', '<cmd>belowright split | lua vim.lsp.buf.declaration()<cr>', "Go to declaration (split)")
        map('n', '<leader>gDv', '<cmd>vsplit | lua vim.lsp.buf.declaration()<cr>', "Go to declaration (vsplit)")
        map('n', '<leader>gDt', '<cmd>tab split | lua vim.lsp.buf.declaration()<cr>', "Go to declaration (tab)")
        -- goto definition
        map('n', '<leader>gd.', vim.lsp.buf.definition, "Go to definition")
        map('n', '<leader>gds', '<cmd>belowright split | lua vim.lsp.buf.definition()<cr>', "Go to definition (split)")
        map('n', '<leader>gdv', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', "Go to definition (vsplit)")
        map('n', '<leader>gdt', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', "Go to definition (tab)")
        -- goto implementation
        map('n', '<leader>gi.', vim.lsp.buf.implementation, "Go to implementation")
        map('n', '<leader>gis', '<cmd>belowright split | lua vim.lsp.buf.implementation()<cr>',
          "Go to implementation (split)")
        map('n', '<leader>giv', '<cmd>vsplit | lua vim.lsp.buf.implementation()<cr>', "Go to implementation (vsplit)")
        map('n', '<leader>git', '<cmd>tab split | lua vim.lsp.buf.implementation()<cr>', "Go to implementation (tab)")
        -- goto type definition
        map('n', '<leader>gt.', vim.lsp.buf.type_definition, "Go to type definition")
        map('n', '<leader>gts', '<cmd>belowright split | lua vim.lsp.buf.type_definition()<cr>',
          "Go to type definition (split)")
        map('n', '<leader>gtv', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<cr>', "Go to type definition (vsplit)")
        map('n', '<leader>gtt', '<cmd>tab split | lua vim.lsp.buf.type_definition()<cr>', "Go to type definition (tab)")
        -- goto incoming calls
        map('n', '<leader>gc.', vim.lsp.buf.incoming_calls, "Incoming calls")
        map('n', '<leader>gcs', '<cmd>belowright split | lua vim.lsp.buf.incoming_calls()<cr>', "Incoming calls (split)")
        map('n', '<leader>gcv', '<cmd>vsplit split | lua vim.lsp.buf.incoming_calls()<cr>', "Incoming calls (vsplit)")
        map('n', '<leader>gct', '<cmd>tab split | lua vim.lsp.buf.incoming_calls()<cr>', "Incoming calls (tab)")
        -- goto outgoing calls
        map('n', '<leader>go.', vim.lsp.buf.outgoing_calls, "Outgoing calls")
        map('n', '<leader>gos', '<cmd>belowright split | lua vim.lsp.buf.outgoing_calls()<cr>', "Outgoing calls (split)")
        map('n', '<leader>gov', '<cmd>vsplit split | lua vim.lsp.buf.outgoing_calls()<cr>', "Outgoing calls (vsplit)")
        map('n', '<leader>got', '<cmd>tab split | lua vim.lsp.buf.outgoing_calls()<cr>', "Outgoing calls (tab)")
        -- info
        map('n', 'K', vim.lsp.buf.hover, "Hover documentation")
        map('n', '<C-k>', vim.lsp.buf.signature_help, "Signature help")
        -- workspace
        map('n', '<leader>waf', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map('n', '<leader>wrf', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map('n', '<leader>wlf', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")
        -- refactor
        map('n', '<leader>gn', vim.lsp.buf.rename, "Rename symbol")
        map({ 'n', 'v' }, '<leader>ga', vim.lsp.buf.code_action, "Code action")
        -- references
        map('n', '<leader>gr', vim.lsp.buf.references, "References")
        -- formatting
        map('n', '<leader>fb', function() vim.lsp.buf.format { async = true } end, "Format buffer")

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

      -- servers with default config
      -- local servers = { 'bashls', 'cmake', 'marksman', 'ts_ls', 'jdtls' }
      local servers = { 'bashls', 'cmake', 'marksman', 'ts_ls' }
      -- servers.insert('pyright')
      -- servers.insert('ruff')
      for _, lsp in ipairs(servers) do
        vim.lsp.config[lsp] = {
          on_attach = default_on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
        }
        vim.lsp.enable(lsp)
      end

      vim.lsp.config.clangd = {
        on_attach = function(client, bufnr)
          default_on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>gs.", "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Clangd: switch source/header" })
          vim.keymap.set("n", "<leader>gss", "<cmd>belowright split | ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Clangd: switch source/header (split)" })
          vim.keymap.set("n", "<leader>gsv", "<cmd>vsplit | ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Clangd: switch source/header (vsplit)" })
          vim.keymap.set("n", "<leader>gst", "<cmd>tab split | ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Clangd: switch source/header (tab)" })
          vim.keymap.set("n", "<leader>gk", "<cmd>ClangdShowSymbolInfo<cr>",
            { buffer = bufnr, desc = "Clangd: symbol info" })
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
      }
      vim.lsp.enable("clangd")

      --- python language server ---
      vim.lsp.config.pylsp = {
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
              flake8 = {
                enabled = true,
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
      }
      vim.lsp.enable('pylsp')
      ---- robotframework_ls ----
      vim.lsp.config.robotframework_ls = {
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
          robot = { lint = { robocop = { enabled = true } } },
        }
      }
      vim.lsp.enable("robotframework_ls")

      ---- lua_ls ----
      vim.lsp.config.lua_ls = {
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
      }
      vim.lsp.enable('lua_ls')
      ---- yaml ----
      vim.lsp.config.yamlls = {
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
      vim.lsp.enable('yamlls')
      ---- groovy ----
      vim.lsp.config.groovyls = {
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { "java", "-jar", vim.env.HOME .. "/repos/groovy-language-server/build/libs/groovy-language-server-all.jar" },
      }
      vim.lsp.enable('groovyls')
      -- java language server
      vim.lsp.config.java_language_server = {
        on_attach = default_on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { "java", "-jar", vim.env.HOME .. "/repos/java-language-server/dist/classpath/java-language-server.jar" },
      }
      vim.lsp.enable('java_language_server')
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
  }
}
