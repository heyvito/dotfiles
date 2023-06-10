---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

M.abc = {
  i = {
    ["<C-o>"] = {"<ESC>o", "Break line, avoid autocomplete", opts = { nowait = true } },
  }
}

return M
