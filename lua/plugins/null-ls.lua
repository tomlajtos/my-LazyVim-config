return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function(_, opts)
    local nls = require("null-ls")
    table.insert(opts.sources, nls.builtins.formatting.prettierd)
    table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    opts.sources = vim.list_extend(opts.sources, {
      -- nls.builtins.diagnostics.flake8,
    })
  end,
}
