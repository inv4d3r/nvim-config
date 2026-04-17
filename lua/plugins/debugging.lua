return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')
      -- set log level (for troubleshooting)
      -- dap.set_log_level("TRACE")
      local continue = function()
        -- [[ FOR DEBUGGING PURPOSES
        -- if vim.fn.filereadable('.vscode/launch.json') then
        --   require('dap.ext.vscode').load_launchjs(nil, {
        --     cppdbg = { "c", "cpp", "rust" },
        --     lldb = { "c", "cpp", "rust" },
        --     codelldb = { "c", "cpp", "rust" },
        --   })
        -- end
        -- ]]
        require('dap').continue()
      end

      local condition_breakpoint = function()
        local condition = vim.fn.input("Condition: ")
        local hit_condition = vim.fn.input("Hit Condition: ")
        local log_message = vim.fn.input("Log Message: ")
        dap.toggle_breakpoint(condition, hit_condition, log_message)
      end

      vim.keymap.set("n", "<F3>", dap.disconnect, { desc = "DAP: Disconnect" })
      vim.keymap.set("n", "<F4>", dap.restart, { desc = "DAP: Restart" })
      vim.keymap.set("n", "<F5>", continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F6>", dap.pause, { desc = "DAP: Pause" })
      vim.keymap.set("n", "<F7>", dap.terminate, { desc = "DAP: Terminate" })
      -- function breakpoint not yet supported
      --vim.keymap.set("n", "<F8>", dap.?)
      vim.keymap.set("n", "<leader><F8>", dap.run_to_cursor, { desc = "DAP: Run to cursor" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
      vim.keymap.set("n", "<leader><F9>", condition_breakpoint, { desc = "DAP: Conditional breakpoint" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })

      vim.keymap.set("n", "<leader>dbl", dap.list_breakpoints, { desc = "DAP: List breakpoints" })
      vim.keymap.set("n", "<leader>dbc", dap.clear_breakpoints, { desc = "DAP: Clear breakpoints" })
      vim.keymap.set("n", "<leader>dd", dap.down, { desc = "DAP: Down frame" })
      vim.keymap.set("n", "<leader>du", dap.up, { desc = "DAP: Up frame" })
      vim.keymap.set("n", "<leader>do", dap.repl.open, { desc = "DAP: Open REPL" })
      vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "DAP: Run last" })

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

      local extension_path = vim.env.HOME .. '/codelldb/extension'
      local codelldb_path = extension_path .. '/adapter/codelldb'
      local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = codelldb_path,
          args = { "--liblldb", liblldb_path, "--port", "${port}" },

          -- On windows you may have to uncomment this:
          -- detached = false,
        }
      }

      local pickProgram = function()
        local path = vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file'
        })
        return (path and path ~= "") and path or dap.ABORT
      end

      dap.configurations.cpp = {
        {
          name = "[lldb] LaunchAny",
          type = "lldb",
          request = "launch",
          program = pickProgram,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "[cppdbg] LaunchAny",
          type = "cppdbg",
          request = "launch",
          program = pickProgram,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
        {
          name = "[codelldb] LaunchAny",
          type = "codelldb",
          request = "launch",
          program = pickProgram,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = "[lldb] AttachAny",
          type = "lldb",
          request = "attach",
          program = pickProgram,
          pid = "${command:pickProcess}",
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
        {
          name = "[cppdbg] AttachAny",
          type = "cppdbg",
          request = "attach",
          program = pickProgram,
          processId = "${command:pickProcess}",
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
        },
        {
          name = "[codelldb] AttachAny",
          type = "codelldb",
          request = "attach",
          program = pickProgram,
          pid = "${command:pickProcess}",
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local get_python_path = function()
        local venv_env_path = os.getenv('VIRTUAL_ENV')
        local conda_env_path = os.getenv("CONDA_PREFIX")
        for _, folder in ipairs({ venv_env_path, conda_env_path }) do
          local python_path = folder .. "/bin/python3"
          if vim.fn.filereadable(python_path) then
            return python_path
          end
        end

        for _, folder in ipairs({ "venv", ".venv", "env", ".env" }) do
          local python_path = vim.fn.getcwd() .. "/" .. folder .. "/bin/python3"
          if vim.fn.filereadable(python_path) then
            return python_path
          end
        end

        return "python3"
      end
      local python_path = get_python_path()
      local dap = require("dap")
      local dap_python = require("dap-python")

      local test_runners = dap_python.test_runners
      -- `test_runners` is a table. The keys are the runner names like `unittest` or `pytest`.
      -- The value is a function that takes two arguments:
      -- The classnames and a methodname
      -- The function must return a module name and the arguments passed to the module as list.

      ---@param classnames string[]
      ---@param methodname string?
      test_runners.pytest_no_cov = function(classnames, methodname)
        local module, args = test_runners.pytest(classnames, methodname)
        table.insert(args, "--no-cov")
        return module, args
      end

      dap_python.setup()
      table.insert(dap.configurations.python, {
        name = "pytest: current file",
        type = "python",
        request = "launch",
        module = "pytest",
        args = {
          "${file}",
          "--no-cov"
        },
        console = "integratedTerminal",
      })
      -- vim.keymap.set("n", "<leader>dm", dap_python.test_method)
      vim.keymap.set("n", "<leader>dm", function() dap_python.test_method({ test_runner = "pytest_no_cov" }) end,
        { desc = "DAP Python: Test method" })
      vim.keymap.set("n", "<leader>dc", function() dap_python.test_class({ test_runner = "pytest_no_cov" }) end,
        { desc = "DAP Python: Test class" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require('dap')
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- toggle (in case not closed automatically using event)
      vim.keymap.set({ "n" }, "<leader>dt", dapui.toggle, { desc = "DAP UI: Toggle" })

      -- evaluate expression under cursor or visually selected
      vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP UI: Evaluate" })
    end,
  }
}
