return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require('dapui')

      dapui.setup()

      vim.keymap.set('n', '<leader>du', "<cmd>lua require('dapui').toggle()<cr>", { desc = 'Toggle DAP UI' })
      vim.keymap.set('n', '<leader>dw', "<cmd>lua require('dapui').elements.watches.add()<cr>", { desc = 'DAP watch' })
      vim.keymap.set('n', '<leader>dW', "<cmd>lua require('dapui').elements.watches.remove()<cr>",
        { desc = 'DAP unwatch' })
    end
  }
}
