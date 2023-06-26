return {
  'nanozuki/tabby.nvim',
  config = function()
    local theme = {
      fill = 'TabLineFill',
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }

    local tabby_api = require('tabby.module.api')

    local function tab_modified(tab)
      local wins = tabby_api.get_tab_wins(tab)
      for i, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
          return '󰧟'
        end
      end

      return ' '
    end

    require('tabby.tabline').set(function(line)
      return {
        {
          { '   ', hl = theme.head },
          line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep('', hl, theme.fill),
            tab.is_current() and '' or '',
            tab.number(),
            tab.name(),
            tab_modified(tab.id),
            line.sep('', hl, theme.fill),
            hl = hl,
            margin = ' ',
          }
        end),
        line.spacer(),
        {
          line.sep('', theme.tail, theme.fill),
          { '  ', hl = theme.tail },
        },
        hl = theme.fill,
      }
    end)
  end
}
