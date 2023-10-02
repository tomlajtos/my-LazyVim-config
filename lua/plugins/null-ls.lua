return {
  "nvimtools/none-ls.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },

  -- Remaining old opts:
  --
  -- opts = function(_, opts)
  --   opts.sources = vim.list_extend(opts.sources, {
  --     -- nls.builtins.diagnostics.flake8,
  --   })
  -- end,

  opts = function(_, opts)
    local nls = require("null-ls")
    table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    table.insert(opts.sources, nls.builtins.formatting.prettier)
  end,
  -- opts = function()
  --   local nls = require("null-ls")
  --   return {
  --     root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --     sources = {
  --       nls.builtins.formatting.fish_indent,
  --       nls.builtins.diagnostics.fish,
  --       nls.builtins.formatting.stylua,
  --       nls.builtins.formatting.shfmt,
  --       -- nls.builtins.diagnostics.flake8,
  --     },
  --   }
  -- end,
}
