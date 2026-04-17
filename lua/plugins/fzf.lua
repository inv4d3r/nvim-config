return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- basic mappings
      local fzf = require("fzf-lua")
      fzf.setup({
        grep = {
          rg_glob        = true,
          glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
          glob_separator = "%s%-%-" -- query separator pattern (lua): ' --'
        }
      })
      fzf.register_ui_select()
      vim.keymap.set("n", "<leader>za", fzf.args, { desc = "FZF: Args" })
      vim.keymap.set("n", "<leader>zb", fzf.buffers, { desc = "FZF: Buffers" })
      vim.keymap.set("n", "<leader>zB", fzf.oldfiles, { desc = "FZF: Old files" })
      vim.keymap.set("n", "<leader>ze", fzf.commands, { desc = "FZF: Commands" })
      vim.keymap.set("n", "<leader>zf", fzf.files, { desc = "FZF: Files" })
      vim.keymap.set("n", "<leader>zh", fzf.command_history, { desc = "FZF: Command history" })
      vim.keymap.set("n", "<leader>zH", fzf.search_history, { desc = "FZF: Search history" })
      vim.keymap.set("n", "<leader>zl", fzf.loclist, { desc = "FZF: Loclist" })
      vim.keymap.set("n", "<leader>zm", fzf.marks, { desc = "FZF: Marks" })
      vim.keymap.set("n", "<leader>zq", fzf.quickfix, { desc = "FZF: Quickfix" })
      vim.keymap.set("n", "<leader>zt", fzf.tabs, { desc = "FZF: Tabs" })
      -- git mappings
      vim.keymap.set("n", "<leader>zgc", fzf.git_commits, { desc = "FZF: Git commits" })
      vim.keymap.set("n", "<leader>zgb", fzf.git_bcommits, { desc = "FZF: Git buffer commits" })
      vim.keymap.set("n", "<leader>zgf", fzf.git_files, { desc = "FZF: Git files" })
      -- grep mappings
      vim.keymap.set("n", "<leader>rl", fzf.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>rg", fzf.grep, { desc = "Grep" })
      vim.keymap.set("n", "<leader>rw", fzf.grep_cword, { desc = "Grep word under cursor" })
      vim.keymap.set("n", "<leader>rW", fzf.grep_cWORD, { desc = "Grep WORD under cursor" })
      vim.keymap.set("v", "<leader>rg", fzf.grep_visual, { desc = "Grep visual selection" })
      -- lsp mappings
      vim.keymap.set("n", "<leader>zd", fzf.lsp_document_symbols, { desc = "FZF: LSP document symbols" })
      vim.keymap.set("n", "<leader>zw", function()
        local opts = { lsp_query = vim.fn.input("LSP Symbol: ") }
        fzf.lsp_workspace_symbols(opts)
      end, { desc = "FZF: LSP workspace symbols" })
      vim.keymap.set("n", "<leader>zs", fzf.lsp_live_workspace_symbols, { desc = "FZF: LSP live workspace symbols" })
    end,
  }
}
