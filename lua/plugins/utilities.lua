return {
  ---- Github Copilot ---
  {
    "github/copilot.vim",
    enabled = false,
    init = function()
      vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<M-j>', '<Plug>(copilot-accept-line)')
      vim.keymap.set('i', '<M-m>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      -- vim.fn.execute("Copilot setup")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false, -- requires neovim > 0.10.0
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  ---- whitespace handling ----
  { "ntpeters/vim-better-whitespace" },
  ---- tmux integration ----
  { "roxma/vim-tmux-clipboard" },
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      vim.keymap.set('n', '<m-h>', '<cmd>TmuxNavigateLeft<cr>')
      vim.keymap.set('n', '<m-j>', '<cmd>TmuxNavigateDown<cr>')
      vim.keymap.set('n', '<m-k>', '<cmd>TmuxNavigateUp<cr>')
      vim.keymap.set('n', '<m-l>', '<cmd>TmuxNavigateRight<cr>')
      vim.keymap.set('n', '<m-p>', '<cmd>TmuxNavigatePrevious<cr>')
    end,
  },
  {
    'sirver/UltiSnips',
    init = function()
      vim.g.UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
      vim.g.UltiSnipsExpandTrigger = "<C-j>"
      vim.g.UltiSnipsEnableSnipMate = 0
    end,
  },
  ---- linux kernel development ----
  {
    "vivien/vim-linux-coding-style",
    init = function()
      vim.g.linuxsty_patterns = { "/usr/src/", "/linux" }
      vim.opt.colorcolumn:prepend("81")
    end,
  },
  -- vista - modern Tagbar replacement
  {
    "liuchengxu/vista.vim",
    init = function()
      vim.g.vista_default_executive = 'nvim_lsp'
    end,
    config = function()
      vim.keymap.set("n", "<leader>vo", "<cmd>Vista<CR>")
      vim.keymap.set("n", "<leader>vc", "<cmd>Vista!<CR>")
      vim.keymap.set("n", "<leader>vt", "<cmd>Vista!!<CR>")
      vim.keymap.set("n", "<leader>vf", "<cmd>Vista finder<CR>")

      --local vista_augroup = vim.api.nvim_create_augroup("Vista", { clear = true })
      --vim.api.nvim_create_autocmd({"VimEnter"}, {
      --pattern = "*",
      --group = vista_augroup,
      --command = "call vista#RunForNearestMethodOrFunction()"
      --})
    end,
  },
  {
    "yggdroot/indentline",
    init = function()
      -- vim.g.vim_json_conceal = 0
      -- vim.g.markdown_syntax_conceal = 0
      vim.g.indentLine_setConceal = 0
    end,
  },
  { "dhruvasagar/vim-zoom" },
  { "milkypostman/vim-togglelist" },
  { "dhruvasagar/vim-table-mode" },
  { "godlygeek/tabular" },
  { "tommcdo/vim-exchange" },
  { "raimondi/delimitmate" },
  { "tpope/vim-endwise" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-vinegar" },

  -- word motion
  {
    "chaoren/vim-wordmotion",
    init = function()
      vim.g.wordmotion_prefix = '<Space>'
    end,
  },
  -- undo tree
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>U", "<cmd>UndotreeToggle<CR>")
    end,
  },
  ---- Substitute configuration ----
  {
    "tpope/vim-abolish",
    config = function()
      vim.keymap.set("n", "<leader>/", ":S/")
    end,
  },
  -- dispatch compiler
  {
    "tpope/vim-dispatch",
    config = function()
      local SaveAndMake = function()
        vim.fn.execute("wa")
        vim.fn.execute("silent Make")
      end
      vim.keymap.set("n", "<leader>mk", SaveAndMake)
    end,
  },
  ---- comment.nvim ----
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  ---- nvim-tree ----
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvim_tree = require("nvim-tree")
      nvim_tree.setup({
        -- hijack_cursor = true,
        -- respect_buf_cwd = true,
        -- sync_root_with_cwd = true,
        -- auto_reload_on_write = true,
        -- reload_on_bufenter = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
      })

      local nvim_tree_api = require("nvim-tree.api")
      vim.keymap.set("n", "<leader>ge", nvim_tree_api.tree.toggle)
      vim.keymap.set("n", "<leader>gf", nvim_tree_api.tree.focus)
      vim.keymap.set("n", "<leader>gF", function() nvim_tree_api.tree.open({ find_file = true }) end)
      vim.keymap.set("n", "<leader>ti", "<cmd>NvimTreeResize +10<CR>")
      vim.keymap.set("n", "<leader>td", "<cmd>NvimTreeResize -10<CR>")
    end,
  },
  ---- vim-gtest ----
  {
    "alepez/vim-gtest",
    config = function()
      vim.g["gtest#hightlight_failing_tests"] = 1
    end,
    init = function()
      vim.keymap.set("n", "]G", "<cmd>GTestNext<CR>")
      vim.keymap.set("n", "[G", "<cmd>GTestPrev<CR>")
      vim.keymap.set("n", "<leader>Gt", "<cmd>GTestRun<CR>")
      vim.keymap.set("n", "<leader>Gu", "<cmd>GTestRunUnderCursor<CR>")
      vim.keymap.set("n", "<leader>zT", "<cmd>FZFGTest<CR>")
    end,
  },
  ---- highlight plugins ----
  -- show colors
  {
    "RRethy/vim-hexokinase",
    build = "make hexokinase"
  },
  -- show marks
  { "kshenoy/vim-signature" },
  ---- Robot framework ----
  {
    "mfukar/robotframework-vim",
    config = function()
      local robot_augroup = vim.api.nvim_create_augroup("Robot", { clear = true })
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.robot",
        group = robot_augroup,
        callback = function()
          vim.opt_local.filetype = "robot"
        end
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rust_augroup = vim.api.nvim_create_augroup("Rust", { clear = true })
      vim.api.nvim_create_autocmd("filetype", {
        pattern = "rust",
        group = rust_augroup,
        callback = function()
          vim.opt_local.makeprg = "cargo build"
        end
      })
    end,
  }
}
