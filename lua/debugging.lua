vim.fn['minpac#add']('mfussenegger/nvim-dap')
vim.fn['minpac#add']('rcarriga/nvim-dap-ui')

local dap = require('dap')
local continue = function()
  if vim.fn.filereadable('.vscode/launch.json') then
    require('dap.ext.vscode').load_launchjs(nil, {
      cppdbg = { "c", "cpp", "rust" },
      lldb = { "c", "cpp", "rust" },
    })
  end
  require('dap').continue()
end

local condition_breakpoint = function()
  local condition = vim.fn.input("Condition: ")
  local hit_condition = vim.fn.input("Hit Condition: ")
  local log_message = vim.fn.input("Log Message: ")
  dap.toggle_breakpoint(condition, hit_condition, log_message)
end

vim.keymap.set("n", "<F3>", dap.disconnect)
vim.keymap.set("n", "<F4>", dap.restart)
vim.keymap.set("n", "<F5>", continue)
vim.keymap.set("n", "<F6>", dap.pause)
-- function breakpoint not yet supported
--vim.keymap.set("n", "<F8>", dap.?)
vim.keymap.set("n", "<leader><F8>", dap.run_to_cursor)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader><F9>", condition_breakpoint)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

vim.keymap.set("n", "<leader>db", dap.list_breakpoints)
vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>dd", dap.down)
vim.keymap.set("n", "<leader>du", dap.up)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dl", dap.run_last)

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.env.HOME .. '/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "[lldb] LaunchAny",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  },
  {
    name = "[cppdbg] LaunchAny",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dapui").setup()
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

-- evaluate expression under cursor or visually selected
vim.keymap.set({ "n", "v" }, "<leader>e", dapui.eval)
