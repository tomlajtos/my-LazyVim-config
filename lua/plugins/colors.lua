return {
--  {
--    "folke/tokyonight.nvim",
--    lazy = false,
--    opts = {
--      style = "night",
--      termguicolors = true,
--      styles = {
--        sidebars = "transparent",
--        floats = "transparent",
--      },
--    },
--  },

  { "lunarvim/darkplus.nvim" },

  { "EdenEast/nightfox.nvim" },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      term_colors = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    opts = {
      style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = true,
      disable_background = false, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = "<F12>", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
      lualine = { transparent = true },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
