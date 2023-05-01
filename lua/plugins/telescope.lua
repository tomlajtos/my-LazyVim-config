return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    "debugloop/telescope-undo.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")
    end,
  },
  config = {
    opts = {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
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
              "",
              function()
                require("telescope-undo.actions").yank_additions()
              end,
              mode = "i",
              { desc = "test" },
            },
            {
              "",
              function()
                require("telescope-undo.actions").yank_deletions()
              end,
              mode = "i",
              { desc = "" },
            },
            {
              "<C-cr>",
              function()
                require("telescope-undo.actions").restore()
              end,
              mode = "i",
              { desc = "" },
            },
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
