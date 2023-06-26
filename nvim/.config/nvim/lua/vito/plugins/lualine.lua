local function heart()
  return [[ ]]
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = {
    theme = 'rose-pine',
    options = {
      icons_enabled = true,
      component_separators = '',
      section_separators = { left = '', right = '' },
      ignore_focus = {},
      always_divide_middle = false,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_z = { 'location', heart }
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filetype',
          colored = false,
          -- color = color,
          icon_only = true,
          padding = { left = 1, right = 0 }
        },
        {
          'filename',
          symbols = {
            modified = '󰧟'
          }
        }
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filetype',
          colored = false,
          -- color = color,
          icon_only = true,
          padding = { left = 1, right = 0 }
        },
        'filename'
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
  }
}
