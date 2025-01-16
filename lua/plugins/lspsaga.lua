return {
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          sign = false
        }
      })
      vim.keymap.set('n', '<leader>la', "<cmd>Lspsaga code_action<cr>", { desc = 'Code actions' })
      vim.keymap.set('n', '<leader>r', "<cmd>Lspsaga rename<cr>", { desc = 'Rename' })
      vim.keymap.set('n', '<leader>lh', "<cmd>Lspsaga hover_doc<cr>", { desc = 'Lsp hover' })
      vim.keymap.set('n', '<leader>lo', "<cmd>Lspsaga outline<cr>", { desc = 'Lsp outline' })
      vim.keymap.set('n', '<leader>lf', "<cmd>Lspsaga finder<cr>", { desc = 'Lsp finder' })
      vim.keymap.set('n', '<leader>lp', "<cmd>Lspsaga peek_definition<cr>", { desc = 'Lsp peek definition' })
      vim.keymap.set('n', '<leader>lP', "<cmd>Lspsaga peek_type_definition<cr>", { desc = 'Lsp peek definition' })
      vim.keymap.set('n', '<leader>lss', "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = 'Line diagnostics' })
      vim.keymap.set('n', '<leader>lsn', "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = 'Next diagnostic' })
      vim.keymap.set('n', '<leader>lsp', "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = 'Previous diagnostic' })
      vim.keymap.set('n', '<leader>lsw', "<cmd>Lspsaga show_workspace_diagnostics<cr>",
        { desc = 'Workspace diagnostics' })
      vim.keymap.set('n', '<leader>lsb', "<cmd>Lspsaga show_buf_diagnostics<cr>",
        { desc = 'Buffer diagnostics' })
      vim.keymap.set('n', '<leader>lsc', "<cmd>Lspsaga show_cursor_diagnostics<cr>",
        { desc = 'Cursor diagnostics' })
    end
  }
}
