return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim", { "b0o/SchemaStore.nvim", version = false } },
  opts = {
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          typescript = {
            format = { enable = false },
            -- format = {
            --   indentSize = vim.o.shiftwidth,
            --   convertTabsToSpaces = vim.o.expandtab,
            --   tabSize = vim.o.tabstop,
            -- },
            -- inlayHints = {
            --   includeInlayParameterNameHints = "literal",
            --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            --   includeInlayFunctionParameterTypeHints = false,
            --   includeInlayVariableTypeHints = false,
            --   includeInlayPropertyDeclarationTypeHints = false,
            --   includeInlayFunctionLikeReturnTypeHints = true,
            --   includeInlayEnumMemberValueHints = true,
            -- },
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

      sqlls = {},
    },

    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          if client.name == "tsserver" then
            -- stylua: ignore
            vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
          end
        end)
        require("typescript").setup({ server = opts })
        return true
      end,

      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(event)
            if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
              vim.cmd("EslintFixAll")
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
    },
  },
}
