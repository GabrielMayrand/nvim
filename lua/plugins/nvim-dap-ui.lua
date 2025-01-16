return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require('dapui').setup()
      vim.keymap.set('n', '<leader>du', "<cmd>lua require('dapui').toggle()<cr>", { desc = 'Toggle DAP UI' })
    end
  }
}
