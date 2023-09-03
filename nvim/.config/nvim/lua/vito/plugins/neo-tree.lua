return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = {
    popup_border_style = "rounded",
    filesystem = {
      follow_current_file = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        show_hidden_count = true,
        hide_gitignored = false,
        never_show = {
          '.git',
          '.DS_Store',
        },
      },
    },
    window = {
      mappings = {
        ["p"] = { "toggle_preview", config = { use_float = true } },
        ["<C-h>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
        ["<C-t>"] = "open_tabnew",
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added     = "+",
          modified  = "e",
          untracked = "?",
          ignored   = "i",
          unstaged  = "",
          staged    = "",
          conflict  = "!",
        }
      },
    },
  }
}
