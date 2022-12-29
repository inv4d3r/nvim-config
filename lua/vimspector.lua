---- vimspector ----
vim.fn["minpac#add"]("puremourning/vimspector")

-- gadgets
vim.g.vimspector_install_gadgets = { "debugpy", "vscode-cpptools", "CodeLLDB" }

-- default mappings
vim.g.vimspector_enable_mappings = "HUMAN"
--[[ HUMAN mappings
F3         | <Plug>VimspectorStop                        | Stop debugging.
F4         | <Plug>VimspectorRestart                     | Restart debugging with the same configuration.
F5         | <Plug>VimspectorContinue                    | When debugging, continue. Otherwise start debugging.
F6         | <Plug>VimspectorPause                       | Pause debuggee.
F8         | <Plug>VimspectorAddFunctionBreakpoint       | Add a function breakpoint for the expression under cursor
<leader>F8 | <Plug>VimspectorRunToCursor                 | Run to Cursor
F9         | <Plug>VimspectorToggleBreakpoint            | Toggle line breakpoint on the current line.
<leader>F9 | <Plug>VimspectorToggleConditionalBreakpoint | Toggle conditional line breakpoint or logpoint on the current line.
F10        | <Plug>VimspectorStepOver                    | Step Over
F11        | <Plug>VimspectorStepInto                    | Step Into
F12        | <Plug>VimspectorStepOut                     | Step out of current function scope
]]--

-- extra mappings
vim.keymap.set({"n", "x"}, "<leader>di", "<Plug>VimspectorBalloonEval")
vim.keymap.set({"n"}, "<leader>de", ":VimspectorEval ")
vim.keymap.set({"n"}, "<leader>dw", ":VimspectorWatch ")
vim.keymap.set({"n"}, "<leader>dr", "<cmd>VimspectorReset<cr> ")
vim.keymap.set({"n"}, "<leader>dc", "<cmd>call vimspector#ClearBreakpoints()<cr>")
vim.keymap.set({"n"}, "<leader>dg", "<cmd>call vimspector#GoToCurrentLine()<cr>")
