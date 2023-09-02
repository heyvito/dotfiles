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
    filesystem = {
      follow_current_file = true,
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
