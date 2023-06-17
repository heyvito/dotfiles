return {
  'theprimeagen/harpoon',
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    local km = vim.keymap
    km.set('n', '<leader>ha', mark.add_file)
    km.set('n', '<leader>hh', ui.toggle_quick_menu)
    km.set('n', '<C-h>', function() ui.nav_file(1) end)
    km.set('n', '<C-t>', function() ui.nav_file(2) end)
    km.set('n', '<C-n>', function() ui.nav_file(3) end)
    km.set('n', '<C-s>', function() ui.nav_file(4) end)
  end
}
