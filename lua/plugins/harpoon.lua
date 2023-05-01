return {
  "theprimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc="Harpoon: open menu"},
    {
      "<leader>a",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon: add file",
    },
    {
      "<leader>1",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon: go to file no. 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon: go to file no. 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harpoon: go to file no. 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harpoon: go to file no. 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = "Harpoon: go to file no. 5",
    },
    {
      "<leader>6",
      function()
        require("harpoon.ui").nav_file(6)
      end,
      desc = "Harpoon: go to file no. 6",
    },
  },
}
