-- Some settings ref:
-- https://github-wiki-see.page/m/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--
return {
  "mfussenegger/nvim-dap",

  optional = true,
  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
          ["<leader>da"] = { name = "+adapters" },
        },
      },
    },

    -- -- install vscode-js-debug without mason
    --
    -- -- install the debugger with lazy from source
    -- {
    --   "microsoft/vscode-js-debug",
    --   version = "1.x",
    --   build = "npm i && npm run compile vsDebugServerBundle &&  mv dist out",
    -- },

    -- -- install the adapter
    -- {
    --   "mxsdev/nvim-dap-vscode-js",
    --   opts = {
    --
    --     debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    --     adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extenisonHost" },
    --   },
    -- },

    -- mason-nvim-dap.nvim, bridge between mason.nvim and nvim-dap
    -- {
    --   "jay-babu/mason-nvim-dap.nvim",
    --   dependencies = "mason.nvim",
    --   cmd = { "DapInstall", "DapUninstall" },
    --   opts = {
    --     -- Makes a best effort to setup the various debuggers with
    --     -- reasonable debug configurations
    --     automatic_installation = true,
    --
    --     -- You can provide additional configuration to the handlers,
    --     -- see mason-nvim-dap README for more information
    --     handlers = {},
    --
    --     -- You'll need to check that you have the required things installed
    --     -- online, please don't ask me how to install them :)
    --     ensure_installed = {
    --       -- Update this to ensure that you have the debuggers for the langs you want
    --     },
    --   },
    -- },

    -- PYTHON: nvim-dap-python
    {
      "mfussenegger/nvim-dap-python",
      opts = {},
    },
  },

  -- JS/TS & libs/frameworks: js-debug-adapter, chrome-debug-adapter
  opts = function()
    local dap = require("dap")
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        print("${port}"),
        executable = {
          command = "node",
          --path to point to installation
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            -- vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js", -- path when debugger is installed with lazy
            "${port}",
          },
        },
      }
    end

    for _, language in ipairs({ "typescript", "javasrcipt" }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end

    -- dap.adapters.chrome = {
    if not dap.adapters["chrome"] then
      require("dap").adapters["chrome"] = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
      }
    end
    for _, language in ipairs({ "typescriptreact", "javasrciptreact" }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            name = "Chrome (9222)",
            type = "chrome",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
        }
      end
    end
  end,

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "< eader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}

-- ALT. wip config with mason-nvim-dap.nvim and deno - from Astro's  mehalter, needs more tweeking
--
-- goeas inside -- dependencies = {
--
--     -- mason.nvim integration
--     {
--       "jay-babu/mason-nvim-dap.nvim",
--       dependencies = "mason.nvim",
--       cmd = { "DapInstall", "DapUninstall" },
--       opts = {
--         ensure_installed = {
--           "bash",
--           "delve", -- debugger for Go (https://github.com/sebdah/vim-delve >> https://github.com/go-delve/delve)
--           "js",
--           "python",
--         },
--         -- Makes a best effort to setup the various debuggers with
--         -- reasonable debug configurations
--         -- automatic_installation = true,
--
--         -- You can provide additional configuration to the handlers,
--         -- see mason-nvim-dap README for more information
--         handlers = {
--           js = function()
--             local dap = require("dap")
--             dap.adapters["pwa-node"] = {
--               type = "server",
--               port = "${port}",
--              -- executable = { command = vim.fn.exepath("js-debug-adapter"), args = { "${port}" } },
--             }
--
--             local pwa_node_attach = {
--               type = "pwa-node",
--               request = "launch",
--               name = "js-debug: Attach to Process (pwa-node)",
--               proccessId = require("dap.utils").pick_process,
--               cwd = "${workspaceFolder}",
--             }
--             local function deno(cmd)
--               cmd = cmd or "run"
--               return {
--                 request = "launch",
--                 name = ("js-debug: Launch Current File (deno %s)"):format(cmd),
--                 type = "pwa-node",
--                 program = "${file}",
--                 cwd = "${workspaceFolder}",
--                 runtimeExecutable = vim.fn.exepath("deno"),
--                 runtimeArgs = { cmd, "--inspect-brk" },
--                 attachSimplePort = 9229,
--               }
--             end
--             local function typescript(args)
--               return {
--                 type = "pwa-node",
--                 request = "launch",
--                 name = ("js-debug: Launch Current File (ts-node%s)"):format(
--                   args and (" " .. table.concat(args, " ")) or ""
--                 ),
--                 program = "${file}",
--                 cwd = "${workspaceFolder}",
--                 runtimeExecutable = "ts-node",
--                 runtimeArgs = args,
--                 sourceMaps = true,
--                 protocol = "inspector",
--                 console = "integratedTerminal",
--                 resolveSourceMapLocations = {
--                   "${workspaceFolder}/dist/**/*.js",
--                   "${workspaceFolder}/**",
--                   "!**/node_modules/**",
--                 },
--               }
--             end
--             for _, language in ipairs({ "javascript", "javascriptreact" }) do
--               dap.configurations[language] = {
--                 {
--                   type = "pwa-node",
--                   request = "launch",
--                   name = "js-debug: Launch File (pwa-node)",
--                   program = "${file}",
--                   cwd = "${workspaceFolder /src}",
--                 },
--                 deno("run"),
--                 deno("test"),
--                 pwa_node_attach,
--               }
--             end
--             for _, language in ipairs({ "typescript", "typescriptreact" }) do
--               dap.configurations[language] = {
--                 typescript(),
--                 typescript({ "--esm" }),
--                 deno("run"),
--                 deno("test"),
--                 pwa_node_attach,
--               }
--             end
--           end,
--         },
--
--         -- You'll need to check that you have the required things installed
--         -- online, please don't ask me how to install them :)
--       },
--     },
---- },
