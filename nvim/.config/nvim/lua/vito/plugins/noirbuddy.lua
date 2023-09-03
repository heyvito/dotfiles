return {
  'jesseleite/nvim-noirbuddy',
  as = 'noirbuddy',
  priority = 1000,
  lazy = false,
  dependencies = {
    {"tjdevries/colorbuddy.nvim", branch = "dev"},
  },
  config = function()
    local Color, colors, Group, groups, styles = require('colorbuddy').setup {}
    Group.new('NeoTreeFloatTitle', colors.primary)
    Group.new('NeoTreeTitleBar', colors.primary)
    require("noirbuddy").setup()
  end
}
