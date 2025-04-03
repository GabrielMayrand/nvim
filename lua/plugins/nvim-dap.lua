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
      "nvim-lua/plenary.nvim",
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
      local dap               = require('dap')

      -- UNITY
      local vstuc_path        =
      '/nix/store/m9jilz3zkwawjwbllwnggzcdwis0869r-vscode-extension-VisualStudioToolsForUnity-vstuc-1.1.1/share/vscode/extensions/VisualStudioToolsForUnity.vstuc/bin'
      dap.adapters.vstuc      = {
        type = 'executable',
        command = 'dotnet',
        args = { vstuc_path .. 'UnityDebugAdapter.dll' },
        name = 'Attach to Unity',
      }
      dap.configurations.cs   = {
        {
          type = 'vstuc',
          request = 'attach',
          name = 'Attach to Unity',
          logFile = vim.fs.joinpath(vim.fn.stdpath('data')) .. '/vstuc.log',
          projectPath = function()
            local path = vim.fn.expand('%:p')
            while true do
              local new_path = vim.fn.fnamemodify(path, ':h')
              if new_path == path then
                return ''
              end
              path = new_path
              local assets = vim.fn.glob(path .. '/Assets')
              if assets ~= '' then
                return path
              end
            end
          end,
          endPoint = function()
            local system_obj = vim.system({ 'dotnet', vstuc_path .. 'UnityAttachProbe.dll' }, { text = true })
            local probe_result = system_obj:wait(2000).stdout
            if probe_result == nil or #probe_result == 0 then
              print('No endpoint found (is unity running?)')
              return ''
            end
            for json in vim.gsplit(probe_result, '\n') do
              if json ~= '' then
                local probe = vim.json.decode(json)
                for _, p in pairs(probe) do
                  if p.isBackground == false then
                    return p.address .. ':' .. p.debuggerPort
                  end
                end
              end
            end
            return ''
          end
        },
      }

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
