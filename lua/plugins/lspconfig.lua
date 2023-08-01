return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim", { "b0o/SchemaStore.nvim", version = false } },
  opts = {
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
        },
        settings = {
          typescript = {
            format = { enable = false },
            -- format = {
            --   indentSize = vim.o.shiftwidth,
            --   convertTabsToSpaces = vim.o.expandtab,
            --   tabSize = vim.o.tabstop,
            -- },
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              --includeInlayFunctionParameterTypeHints = false,
              includeInlayParameterNameHints = "all",
              --includeInlayParameterNameHints = "literal",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              --includeInlayPropertyDeclarationTypeHints = false,
              includeInlayVariableTypeHints = true,
              --includeInlayVariableTypeHints = false,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            },
          },
          javascript = {
            format = { enable = false },
            -- format = {
            --   indentSize = vim.o.shiftwidth,
            --   convertTabsToSpaces = vim.o.expandtab,
            --   tabSize = vim.o.tabstop,
            -- },
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
    },

    setup = {
      tsserver = function(_, opts)
        -- require("lazyvim.util").on_attach(function(client, buffer)
        --   if client.name == "tsserver" then
        --     -- stylua: ignore
        --     vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
        --     -- stylua: ignore
        --     vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        --   end
        -- end)
        require("typescript").setup({ server = opts })
        return true
      end,

      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(event)
            -- if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
            --   vim.cmd("EslintFixAll")
            -- end
            if not require("lazyvim.plugins.lsp.format").enabled() then
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
        require("lazyvim.util").on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
}
