local opt = vim.opt

opt.guicursor = ""

opt.relativenumber = true
opt.number = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.backup = false
opt.swapfile = false

opt.incsearch = true

opt.scrolloff = 8
opt.updatetime = 50
opt.colorcolumn = "80"

vim.g.editorconfig = true

vim.g.fixeol = true
vim.opt.clipboard = "unnamedplus"
