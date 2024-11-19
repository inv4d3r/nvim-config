return {

  ---- gitgutter - show git diff signs ----
  { "airblade/vim-gitgutter" },

  ---- gitv - gitk for vim ----
  { "gregsexton/gitv" },

  ---- git-messenger - reveal commit message ----
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.keymap.set("n", "<leader>gm", "<cmd>GitMessenger<CR>")
    end,
  },

  ---- fugitive - abstract git commands ----
  { "tpope/vim-fugitive" },

  ---- blamer.nvim ----
  {
    "APZelos/blamer.nvim",
    init = function()
      vim.g.blamer_enabled = 1
    end,
  }
}
