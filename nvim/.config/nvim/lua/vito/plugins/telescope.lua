return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = {
    {'nvim-lua/plenary.nvim'}
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "^./.git", "^node_modules", "^./.nova" },
        sort_mru = true,
        sorting_strategy = 'ascending',
        layout_config = { prompt_position = 'top' },
        border = true,
        multi_icon = '',
        hl_result_eol = true,
        results_title = '',
        winblend = 0,
        wrap_results = false,
        mappings = { i = { ['<Esc>'] = require('telescope.actions').close } },
      },
    }
  end
}
