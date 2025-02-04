return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
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
        capabilities = capabilities
      }

      require("lspconfig").nixd.setup {
        capabilities = capabilities
      }

      require("lspconfig").omnisharp.setup {
        capabilities = capabilities,
        cmd = {
          vim.fn.exepath("OmniSharp"),
          "--languageserver",
          "--hostPID",
          tostring(pid),
        },
        Sdk = {
          IncludePrereleases = true,
        },
      }

      require('lspconfig').volar.setup {
        capabilities = capabilities,
        filetypes = {
          'typescript',
          'javascript',
          'vue',
        },
        init_options = {
          vue = {
            -- disable hybrid mode
            hybridMode = false,
          },
        },
      }

      require 'lspconfig'.jsonls.setup {
        capabilities = capabilities,
      }

      -- require 'lspconfig'.rust_analyzer.setup {
      --   capabilities = capabilities,
      --   filetypes = { "rust" },
      --   cmd = { "rust-analyzer" }
      -- }

      -- FORMATTING
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --     if client.supports_method('textDocument/formatting') then
      --       -- Format current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })
    end,
  }

}
