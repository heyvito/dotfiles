vim.g.mapleader = " "

local keymap = vim.keymap
local maps = {
  i = {
    ["jk"] = "<ESC>",
  },
  n = {
    ["s"] = "<cmd>w<CR>",
    ["<ESC>"] = "<cmd>nohl<CR>",

    -- avoid the worst place in the universe
    ["Q"] = "<NOP>",

    -- do not copy on 'x'
    ["x"] = '"_x',

    -- [[ Splits ]]
    ["<leader>sv"] = "<cmd>vnew<CR>",
    ["<leader>sh"] = "<cmd>new<CR>",
    ["<leader>se"] = "<C-w>=",
    ["<leader>sx"] = "<cmd>close<CR>",
    ["<C-h>"] = "<C-w>h",
    ["<C-l>"] = "<C-w>l",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",

    -- [[ Tabs, Neotree ]]
    ["<leader>tn"] = "<cmd>tabnew<CR>",
    ["<leader>tx"] = "<cmd>tabc<CR>",
    ["<leader>kb"] = "<cmd>VShowHideTree<CR>",
    ["<leader>e"]  = "<cmd>VToggleTree<CR>",
    ["<leader>l"]  = "<cmd>b#<CR>",

    -- [[ Telescope ]]
    ["<leader>ff"] = "<cmd> Telescope find_files hidden=true <CR>",
    -- fd is ff, but without the previewer
    ["<leader>fd"] = "<cmd> Telescope find_files hidden=true theme=dropdown previewer=false <CR>",
    ["<leader>fa"] = "<cmd> Telescope find_files follow=true no_ignore=true hidden=true theme=dropdown <CR>",
    ["<leader>fw"] = "<cmd> Telescope live_grep <CR>",
    ["<leader>fb"] = "<cmd> Telescope buffers sort_mru=true ignore_current_buffer=true <CR>",
    ["<leader>fh"] = "<cmd> Telescope help_tags <CR>",
    ["<leader>fo"] = "<cmd> Telescope oldfiles <CR>",
    ["<leader>fg"] = "<cmd> Telescope git_files <CR>",
    ["<leader>fz"] = "<cmd> Telescope current_buffer_fuzzy_find <CR>",
    ["<leader>cm"] = "<cmd> Telescope git_commits <CR>",
    ["<leader>gt"] = "<cmd> Telescope git_status <CR>",
  },
}

for mode, inner in pairs(maps) do
  for map, cmd in pairs(inner) do
    keymap.set(mode, map, cmd, { noremap = false })
  end
end

-- [[ Stop x + clipboard madness ]]
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true }) -- x = delete (no copy)
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true }) -- d = delete (no copy)
vim.api.nvim_set_keymap('n', 'D', '"_D', { noremap = true }) -- D = delete (no copy)
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true }) -- d = delete (no copy) (visual mode)

vim.api.nvim_set_keymap('n', '<leader>d', '"+d', { noremap = true }) -- leader d = CUT
vim.api.nvim_set_keymap('n', '<leader>D', '"+D', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"+d', { noremap = true })

