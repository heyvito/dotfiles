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
    -- splits
    ["<leader>sv"] = "<C-w>v",
    ["<leader>sh"] = "<C-w>s",
    ["<leader>se"] = "<C-w>=",
    ["<leader>sx"] = "<cmd>close<CR>",
    ["<C-h>"] = "<C-w>h",
    ["<C-l>"] = "<C-w>l",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    -- tabs
    ["<leader>tx"] = "<cmd>VBufClose<CR>",
    ["<leader>t]"] = "<cmd>BufferLineCycleNext<CR>",
    ["<leader>t["] = "<cmd>BufferLineCyclePrev<CR>",
    ["<leader>kb"] = "<cmd>VShowHideTree<CR>",
    ["<leader>e"]  = "<cmd>VToggleTree<CR>",
    -- telescope
    ["<leader>ff"] = "<cmd> Telescope find_files <CR>",
    ["<leader>fa"] = "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
    ["<leader>fw"] = "<cmd> Telescope live_grep <CR>",
    ["<leader>fb"] = "<cmd> Telescope buffers <CR>",
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

vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('n', 'D', '"_D', { noremap = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>d', '"+d', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>D', '"+D', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"+d', { noremap = true })

