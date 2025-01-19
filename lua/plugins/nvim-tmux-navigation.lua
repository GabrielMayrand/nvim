return {
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

      vim.keymap.set('n', "<M-h>", "<cmd>wincmd < <cr>")
      vim.keymap.set('n', "<M-l>", "<cmd>wincmd > <cr>")
      vim.keymap.set('n', "<M-j>", "<cmd>wincmd - <cr>")
      vim.keymap.set('n', "<M-k>", "<cmd>wincmd + <cr>")

      vim.keymap.set('n', "<M-H>", "<cmd>vertical resize -5<cr>")
      vim.keymap.set('n', "<M-L>", "<cmd>vertical resize +5<cr>")
      vim.keymap.set('n', "<M-J>", "<cmd>horizontal resize -5<cr>")
      vim.keymap.set('n', "<M-K>", "<cmd>horizontal resize +5<cr>")
    end
  } }
