return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'Hoffs/omnisharp-extended-lsp.nvim',
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
      local cwd = vim.fn.getcwd()

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
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = false,
        sdk_include_prereleases = true,
        enable_editorconfig_support = true,
        analyze_open_documents_only = false,
      }

      require 'lspconfig'.ts_ls.setup({
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = cwd .. "/node_modules/@vue/language-server",
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })


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
