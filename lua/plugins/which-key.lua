return {
  { 'nvim-mini/mini.nvim', version = false },
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-mini/mini.nvim" },
    event = "VeryLazy",
    opts = {
      delay = 500, -- ms before popup appears
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Group labels: give human-readable names to leader prefix groups.
      -- Only prefixes that are NOT themselves mapped to an action get a group label.
      wk.add({
        -- swap
        { "<leader>a",  group = "swap" },

        -- buffers
        { "<leader>b",  group = "buffers" },

        -- copilot / chat
        { "<leader>c",  group = "copilot" },

        -- debug
        { "<leader>d",  group = "debug / diagnostics" },

        -- e: free range

        -- formatting
        { "<leader>f",  group = "format" },

        -- goto / git / file-tree
        { "<leader>g",  group = "goto / git / tree" },
        { "<leader>gD", group = "declaration" },
        { "<leader>gd", group = "definition" },
        { "<leader>gi", group = "implementation" },
        { "<leader>gc", group = "incoming calls" },
        { "<leader>go", group = "outgoing calls / open" },
        { "<leader>gt", group = "type definition" },
        { "<leader>gs", group = "switch source/header (clangd)" },

        -- GTest
        { "<leader>G",  group = "gtest" },

        -- gitgutter hunks
        { "<leader>h",  group = "gitgutter hunks" },

        -- indent
        -- { "<leader>it",  group = "indent line toggle" },

        -- j,k: free range

        -- { "<leader>l",  group = "toggle loclist" },

        -- markdown
        { "<leader>m",  group = "docs / markdown / plantuml" },

        -- make / build
        -- <leader>mk is a direct mapping, no group needed)

        -- o: free range

        -- path / file info
        { "<leader>p",  group = "path / file info" },

        -- { "<leader>q",  group = "toggle quickfix list" },

        -- grep
        { "<leader>r",  group = "grep" },

        -- whitespace / search / substitute
        { "<leader>s",  group = "whitespace / search / substitute" },

        -- terminal / tree
        { "<leader>te", group = "terminal" },

        -- terminal / tree
        { "<leader>tr", group = "tree" },

        -- vista
        { "<leader>v",  group = "vista" },

        -- whitespace / workspace
        { "<leader>w",  group = "whitespace / workspace" },
        { "<leader>wr", group = "remove whitespace" },
        { "<leader>ws", group = "search whitespace" },

        -- trouble diagnostics
        { "<leader>x",  group = "trouble diagnostics" },

        -- fuzzy find
        { "<leader>z",  group = "fuzzy find" },
        { "<leader>zg", group = "git" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
