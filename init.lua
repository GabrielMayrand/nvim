-- VIM OPTIONS ------------------------------------------------------------

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
-- UI
-- font
vim.g.have_nerd_font = true
-- lines
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wrap = false
-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
-- look
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- scroll
vim.opt.scrolloff = 5

-- VIM API
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- PLUGINS ----------------------------------------------------------------
require("config.lazy")
