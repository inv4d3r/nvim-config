return {
  ---- Github Copilot ---
  {
    "github/copilot.vim",
    enabled = true,
    init = function()
      vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)', { desc = "Copilot: accept word" })
      vim.keymap.set('i', '<M-j>', '<Plug>(copilot-accept-line)', { desc = "Copilot: accept line" })
      vim.keymap.set('i', '<M-m>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Copilot: accept suggestion",
      })
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.fn.execute("Copilot setup")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    init = function()
      vim.keymap.set("n", "<leader>ca", "<cmd>CopilotChatToggle<CR>", { desc = "CopilotChat: Toggle" })
      vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatModels<CR>", { desc = "CopilotChat: Models" })
      vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatCommit<CR>", { desc = "CopilotChat: Commit" })
      vim.keymap.set({ "n", "v" }, "<leader>cd", "<cmd>CopilotChatDocs<CR>", { desc = "CopilotChat: Docs" })
      vim.keymap.set({ "n", "v" }, "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "CopilotChat: Explain" })
      vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "CopilotChat: Fix" })
      vim.keymap.set({ "n", "v" }, "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "CopilotChat: Optimize" })
      vim.keymap.set({ "n", "v" }, "<leader>cp", "<cmd>CopilotChatPrompts<CR>", { desc = "CopilotChat: Prompts" })
      vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>CopilotChatReview<CR>", { desc = "CopilotChat: Review" })
      vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "CopilotChat: Tests" })
    end,
    opts = {
      -- See Configuration section for options
      providers = {
        github_models = {
          disabled = true,
        },
      }
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  ---- indent lines ----
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      enabled = false,
      indent = { char = "│" },
    },
    keys = {
      {
        "<leader>it",
        "<cmd>IBLToggle<cr>",
        desc = "Toggle Indent Lines",
      },
    },
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
}
