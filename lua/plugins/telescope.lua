return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },

    {
      "debugloop/telescope-undo.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("undo")
      end,
    },
  },

  opts = {
    extensions = {
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        side_by_side = false,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.7,
        },
        keys = {
          {
            "<M-a>",
            function()
              require("telescope-undo.actions").yank_additions()
            end,
            mode = "i",
            { desc = "Telescope-Undo: yank additions" },
          },
          {
            "<S-u>",
            function()
              require("telescope-undo.actions").yank_deletions()
            end,
            mode = "i",
            { desc = "Telescope-Undo: yank deletions" },
          },
          {
            "<M-u>",
            function()
              require("telescope-undo.actions").restore()
            end,
            mode = "i",
            { desc = "Telescope-Undo: undo actions" },
          },
        },
      },
    },
  },

  keys = {
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "<F9>",
      function()
        require("telescope").extensions.undo.undo()
      end,
      desc = "Telescope undo",
    },
  },
}
