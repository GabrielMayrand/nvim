return {
  {
    "sindrets/diffview.nvim",

    config = function()
      vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>')
      vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewClose<CR>')
    end,
  }
}
