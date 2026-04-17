return {
  ---- treesitter ----
  -- nvim-treesitter plugin for parser installation
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local treesitter = require("nvim-treesitter")
      local languages = {
        "bash", "c", "cpp", "cmake", "diff", "dockerfile", "doxygen", "html", "java", "javascript", "json", "latex",
        "lua", "markdown", "python", "rust", "robot", "sql", "toml", "xml", "yaml", "vimdoc"
      }
      treesitter.setup()
      treesitter.install { languages }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = languages,
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      vim.keymap.set("n", "<leader>C", "<cmd>TSContext toggle<CR>", { desc = "Toggle treesitter context" })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    branch = "main",
    config = function()
      local nvim_treesitter_textobjects = require("nvim-treesitter-textobjects")
      nvim_treesitter_textobjects.setup({
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- include_surrounding_whitespace: `true` or `false`, when `true` textobjects
        -- are extended to include preceding or succeeding whitespace, defaults is `false`.
        include_surrounding_whitespace = true,
      })
    end,
    keys = {
      -- move: goto_next_start
      { "]b", function() require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer") end,
        mode = { "n", "x", "o" }, desc = "Next block start" },
      { "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer") end,
        mode = { "n", "x", "o" }, desc = "Next function start" },
      { "]]", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer") end,
        mode = { "n", "x", "o" }, desc = "Next class start" },
      { "]o", function() require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer") end,
        mode = { "n", "x", "o" }, desc = "Next loop start" },
      { "]g", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope",
          "locals")
      end, mode = { "n", "x", "o" }, desc = "Next scope" },
      -- move: goto_next_end
      { "]B", function() require("nvim-treesitter-textobjects.move").goto_next_end("@block.outer") end,
        mode = { "n", "x", "o" }, desc = "Next block end" },
      { "]M", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer") end,
        mode = { "n", "x", "o" }, desc = "Next function end" },
      { "][", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer") end,
        mode = { "n", "x", "o" }, desc = "Next class end" },
      { "]i", function() require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer") end,
        mode = { "n", "x", "o" }, desc = "Next conditional" },
      -- move: goto_previous_start
      { "[b", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev block start" },
      { "[m", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev function start" },
      { "[[", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev class start" },
      -- move: goto_previous_end
      { "[B", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@block.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev block end" },
      { "[M", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev function end" },
      { "[]", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev class end" },
      { "[i", function() require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer") end,
        mode = { "n", "x", "o" }, desc = "Prev conditional" },
      -- select
      { "io", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner")
      end, mode = { "x", "o", } },
      { "ao", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer")
      end, mode = { "x", "o" } },
      { "id", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner")
      end, mode = { "x", "o" } },
      { "ad", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer")
      end, mode = { "x", "o" } },
      { "ib", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@block.inner")
      end, mode = { "x", "o" } },
      { "ab", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@block.outer")
      end, mode = { "x", "o" } },
      { "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
      end, mode = { "x", "o" } },
      { "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner")
      end, mode = { "x", "o" } },
      { "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer")
      end, mode = { "x", "o" } },
      { "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner")
      end, mode = { "x", "o" } },
      { "as", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
      end, mode = { "x", "o" } },
      -- swap
      { "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
      end
      },
      { "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_next "@parameter.outer"
      end
      },
    },
  }
}
