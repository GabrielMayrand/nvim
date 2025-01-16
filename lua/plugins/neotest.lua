return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
      "mfussenegger/nvim-dap",
    },
    opts = {
      discovery = {
        enabled = false,
        concurrent = 1,
      },
      running = {
        concurrent = true,
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet"),
          -- require("neotest-plenary"),
          -- require("neotest-vim-test")({
          --   ignore_file_types = { "python", "vim", "lua" },
          -- }),
        },
      })
      vim.keymap.set('n', '<leader>tt', "<cmd>Neotest run<cr>", { desc = 'Neotest nearest test' })
      vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = 'Neotest test stop' })
      vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%')<cr>",
        { desc = 'Neotest test file' })
      vim.keymap.set('n', '<leader>td', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
        { desc = 'Neotest test debug' })
    end
  }
}
