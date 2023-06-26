return {
  'rose-pine/neovim',
  as = 'rose-pine',
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme rose-pine')
  end
}
