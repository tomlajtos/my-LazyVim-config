return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim", { "b0o/SchemaStore.nvim", version = false } },
  opts = {
    format_notify = true,
    format = {
      formatting_options = nil,
      timeout_ms = 2000,
    },

    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    },

    -- LSP Server Settings
    -- make sure mason installs the server
    ---@type lspconfig.options
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
        },
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },

      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          format = { enable = false },
          workingDirectory = { mode = "auto" },
        },
      },

      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },

      tailwindcss = { filetypes_exclude = { "markdown" } },

      bashls = {},

      pyright = {},

      ruff_lsp = {},

      sqlls = {},

      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        ---@type LazyKeys[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },

    setup = {
      tsserver = function(_, opts)
        require("typescript").setup({ server = opts })
        return true
      end,

      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(event)
            if not require("lazyvim.util").format.enabled() then
              -- exit early if autoformat is not enabled
              return
            end

            local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
            if client then
              local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end,
        })
      end,

      tailwindcss = function(_, opts)
        local tw = require("lspconfig.server_configurations.tailwindcss")
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, tw.default_config.filetypes)
      end,

      ruff_lsp = function()
        require("lazyvim.util").lsp.on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
}
