return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  dependencies = {
    {
      'akinsho/bufferline.nvim',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("bufferline").setup {
          options = {
            offsets = {{filetype = "neo-tree", text = " ", highlight = "Directory"}},
            separator_style = "slant",
          },
          highlights = require("catppuccin.groups.integrations.bufferline").get {
            styles = { "italic", "bold" },
          },
        }
      end
    },
  },
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = true,
      term_colors = true,
      dim_inactive = {
        enabled = false,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
      },
    })


    vim.cmd.colorscheme "catppuccin"
  end,
}
