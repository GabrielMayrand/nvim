return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
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
      vim.keymap.set('n', '<leader>tf', "<cmd>Neotest run file<cr>", { desc = 'Neotest test file' })
      vim.keymap.set('n', '<leader>ts', "<cmd>require('neotest').run.stop()<cr>", { desc = 'Neotest test stop' })
    end
  }
}
