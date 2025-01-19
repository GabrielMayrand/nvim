local js_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  {
    'mfussenegger/nvim-dap',

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "firefox-devtools/vscode-firefox-debug",
      {
        "firefox-devtools/vscode-firefox-debug",
        build = "npm i && npm run build",
      },
    },

    config = function()
      local dap = require('dap')

      -- DOTNET
      dap.adapters.netcoredbg = {
        type = 'executable',
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
        options = { detached = false },
      }

      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "launch - netcoredbg",
              request = "launch",
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/Onyx./bin/Debug/net9.0/Onyx.", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug",
          -- args = { vim.fn.exepath("js-debug"), "${port}" },
          args = { "${port}", "localhost" },
        }
      }
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "launch - typescript",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = false,
        },
      }

      dap.configurations.vue = {
        {
          type = "pwa-node",
          request = "launch",
          name = "launch - typescript",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = false,
        },
      }

      dap.adapters.firefox = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/.local/share/nvim/lazy/vscode-firefox-debug/dist/adapter.bundle.js' },
      }

      dap.configurations.typescript = {
        {
          name = 'Debug with Firefox',
          type = 'firefox',
          request = 'launch',
          reAttach = true,
          url = 'http://localhost:44355',
          webRoot = '${workspaceFolder}',
          firefoxExecutable = vim.fn.exepath("firefox")
        }
      }

      dap.configurations.vue = {
        {
          name = 'Debug with Firefox',
          type = 'firefox',
          request = 'launch',
          reAttach = true,
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          firefoxExecutable = vim.fn.exepath("firefox")
        }
      }

      -- KEYMAPS
      vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP continue' })
      vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end, { desc = 'DAP continue' })
      vim.keymap.set('n', '<Leader>dr', function() require('dap').run_to_cursor() end, { desc = 'DAP run to cursor' })
      vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP step over' })
      vim.keymap.set('n', '<Leader>do', function() require('dap').step_over() end, { desc = 'DAP step over' })
      vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP step into' })
      vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end, { desc = 'DAP step into' })
      vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'DAP step out' })
      vim.keymap.set('n', '<Leader>dO', function() require('dap').step_out() end, { desc = 'DAP step out' })
      vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end,
        { desc = 'DAP toggle breakpoint' })
      vim.keymap.set('n', '<Leader>dp',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = 'DAP log message breakpoint' })
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'DAP repl open' })
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 'DAP run last' })
    end
  }
}
