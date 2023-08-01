return {
  "jose-elias-alvarez/null-ls.nvim",
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
}
