return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lsp_status = require('lsp-status')

      local lsp_current_function = function()
        lsp_status.update_current_function()
        return vim.b.lsp_current_function
      end

      local lsp_status_progress = function()
        if #vim.lsp.get_clients() > 0 then
          return lsp_status.status_progress()
        end
        return ''
      end

      local copilot_status = function()
        return vim.api.nvim_exec2('Copilot status', { output = true })
      end

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = { 'filename', lsp_current_function },
          lualine_x = { copilot_status, lsp_status_progress, 'diagnostics', 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  }
}
