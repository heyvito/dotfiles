return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
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
  }
}
