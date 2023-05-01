local hl_groups = {
  "CursorLine",
  "CursorLineNr",
  "EndOfBuffer",
  "FloatBorder",
  "FloatTitle",
  "LineNr",
  "Menu",
  "MsgArea",
  "MsgSeparator",
  "NonText",
  "Normal",
  "NormalFloat",
  "NormalNC",
  "Pmenu",
  "PmenuExtra",
  "Scrollbar",
  "SignColumn",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "Tooltip",
  "Winbar",
  "WinbarNC",
  "Whitespace",
  "Wildmenu",
  --neotree (https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x/doc/neo-tree.txt)
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeStatusLine",
  "NeoTreeStatusLineNC",
  "NeoTreeWinSeparator",
  "NeoTreeEndOfBuffer",
  --[[ "Todo", ]]
}

-- Reload colorscheme and style
-- M.reload_cs = function(c_tbl, cs)
-- 	vim.g.reload_cs = true
-- 	if string.find(cs, "fox") and string.find(vim.g.colors_name, "fox") then
-- 		cs = "nightfox"
-- 		vim.g.curr_cs_style = vim.g.colors_name
-- 		pcall(c_tbl[cs])
-- 	else
-- 		pcall(c_tbl[cs])
-- 	end
-- end

-- Disable background transparency
local disable_bg = function()
  for _, name in pairs(hl_groups) do
    vim.api.nvim_set_hl(0, name, { bg = "none" })
  end
end

-- Toggle background transparency
local tggl_transparency = function()
  if vim.api.nvim_get_hl(0, { name = "Normal" }).bg then
    vim.g.transp_cs_bg = true
    disable_bg()
  else
    vim.g.transp_cs_bg = false
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end

local function map(mode, lhs, rhs, opts)
  -- local keys = require("lazy.core.handler").handlers.keys
  -- -@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  -- if not keys.active[keys.parse({ lhs, mode = mode }).id] then
  -- opts = opts or {}
  -- opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
  -- end
end
map("n", "<leader>ub", function()
  tggl_transparency()
end, { desc = "Toggle background transparency" })
