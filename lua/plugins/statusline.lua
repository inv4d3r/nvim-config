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
          lualine_x = { 'diagnostics', lsp_status_progress, 'encoding', 'fileformat', 'filetype' },
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
