return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      vim.keymap.set('n', '<leader>ft', '<cmd>Telescope builtin<CR>')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

      -- GIT
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git status' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })
      vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope git stash' })

      -- LSP
      vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope lsp references' })
      vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope lsp definitions' })
      vim.keymap.set('n', '<leader>lD', builtin.lsp_type_definitions, { desc = 'Telescope lsp type definitions' })
      vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope lsp implementations' })

      -- NEOVIM CONFIG SEARCH
      vim.keymap.set('n', '<leader>nr', builtin.registers, { desc = 'Telescope registers' })
      vim.keymap.set('n', '<leader>nh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>nf', function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = 'Telescope find neovim files' })
    end
  }
}
