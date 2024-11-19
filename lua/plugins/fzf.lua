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
      vim.keymap.set("n", "<leader>za", fzf.args)
      vim.keymap.set("n", "<leader>zb", fzf.buffers)
      vim.keymap.set("n", "<leader>zB", fzf.oldfiles)
      vim.keymap.set("n", "<leader>ze", fzf.commands)
      vim.keymap.set("n", "<leader>zf", fzf.files)
      vim.keymap.set("n", "<leader>zh", fzf.command_history)
      vim.keymap.set("n", "<leader>zH", fzf.search_history)
      vim.keymap.set("n", "<leader>zl", fzf.loclist)
      vim.keymap.set("n", "<leader>zm", fzf.marks)
      vim.keymap.set("n", "<leader>zq", fzf.quickfix)
      vim.keymap.set("n", "<leader>zt", fzf.tabs)
      -- git mappings
      vim.keymap.set("n", "<leader>zgc", fzf.git_commits)
      vim.keymap.set("n", "<leader>zgb", fzf.git_bcommits)
      vim.keymap.set("n", "<leader>zgf", fzf.git_files)
      -- grep mappings
      vim.keymap.set("n", "<leader>rl", fzf.live_grep)
      vim.keymap.set("n", "<leader>rg", fzf.grep)
      vim.keymap.set("n", "<leader>rw", fzf.grep_cword)
      vim.keymap.set("n", "<leader>rW", fzf.grep_cWORD)
      vim.keymap.set("v", "<leader>rg", fzf.grep_visual)
      -- lsp mappings
      vim.keymap.set("n", "<leader>zd", fzf.lsp_document_symbols)
      vim.keymap.set("n", "<leader>zw", fzf.lsp_workspace_symbols)
      vim.keymap.set("n", "<leader>zs", fzf.lsp_live_workspace_symbols)
    end,
  }
}
