vim.g.mapleader = '\\'
vim.g.health = { style = 'float' }

vim.opt.filetype = 'on'
vim.opt.syntax = 'on'
vim.opt.winborder = 'single'
vim.opt.cmdheight = 0
vim.opt.pumheight = 10
vim.opt.pumwidth = 10
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.laststatus = 2
vim.opt.hidden = true
vim.opt.shortmess:append 'sflmTWAIq'
vim.loader.enable()

vim.opt.scrolloff = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.whichwrap:append '<>[]hl'

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'number'
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.fillchars = {
    vert = ' ',
    eob = ' ',
    diff = ' ',
    msgsep = ' ',
}
vim.opt.listchars = {
    tab = '» ',
    extends = '›',
    precedes = '‹',
    nbsp = '·',
    trail = '·',
}

vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.showmatch = true
vim.opt.smartcase = true
