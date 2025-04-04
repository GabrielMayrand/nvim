vim.keymap.set(
  "n",
  '<leader>lr',
  function() require("omnisharp_extended").telescope_lsp_references(require("telescope.themes").get_ivy({ excludeDefinition = true })) end,
  { noremap = true }
)
vim.keymap.set(
  "n",
  '<leader>ld',
  require("omnisharp_extended").telescope_lsp_definition, { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>lD",
  function() require("omnisharp_extended").telescope_lsp_type_definition() end,
  { noremap = true }
)
vim.keymap.set(
  "n",
  "<leader>li",
  require("omnisharp_extended").telescope_lsp_implementation,
  { noremap = true }
)
