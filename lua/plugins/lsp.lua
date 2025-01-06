return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- 'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- COMPLETION
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local pid = vim.fn.getpid()

      -- LSP
      require("lspconfig").lua_ls.setup {
        capabilites = capabilities
      }

      require("lspconfig").omnisharp.setup {
        capabilities = capabilities,
        cmd = {
          "/nix/store/adpqa8140zcsnv3ngbvazqlxyn83c12c-omnisharp-roslyn-1.39.12/bin/OmniSharp",
          "--languageserver",
          "--hostPID",
          tostring(pid),
        },
        Sdk = {
          IncludePrereleases = true,
        },
      }

      -- FORMATTING
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.supports_method('textDocument/formatting') then
            -- Format current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }

}
