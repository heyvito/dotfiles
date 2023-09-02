return {
  'jesseleite/nvim-noirbuddy',
  as = 'noirbuddy',
  priority = 1000,
  lazy = false,
  dependencies = {
    {"tjdevries/colorbuddy.nvim", branch = "dev"},
  },
  config = function()
    require("noirbuddy").setup()
  end
}
