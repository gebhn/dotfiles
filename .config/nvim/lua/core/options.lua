vim.g.mapleader = '\\'

vim.o.filetype = 'on'
vim.o.syntax = 'on'
vim.o.winborder = 'single'

vim.opt.scrolloff = 3
vim.opt.title = true
vim.opt.titlestring = '%f'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.mouse = ''

vim.opt.updatetime = 300
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10

vim.opt.ruler = false
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'number'
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.textwidth = 80

vim.opt.switchbuf = 'newtab'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hidden = true
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

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.whichwrap:append '<>[]hl'

vim.opt.shortmess:append 'sflmTWAIq'

vim.loader.enable()
