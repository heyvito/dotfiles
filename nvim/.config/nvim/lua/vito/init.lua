local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key.
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Disable Netrw ]]
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('vito.core.options')
require('vito.core.autos')
require('lazy').setup('vito.plugins')
require('vito.core.commands')
require('vito.core.keymaps')
