-- core
vim.o.updatetime = 300
vim.o.timeoutlen = 300

-- buffers
vim.o.hidden = true
vim.o.swapfile = false
vim.o.undofile = true

-- completion
vim.o.pumheight = 10
vim.opt.completeopt:append { 'menuone', 'noselect', 'noinsert', 'fuzzy', }

-- status/cmd
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.statusline = ' '

-- help/splits
vim.o.helpheight = 10
vim.o.splitbelow = true

-- whitespace
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- find
vim.o.wildmode = 'noselect,full'

-- ui
vim.o.background = 'light'
vim.o.winborder = 'single'
vim.o.pumborder = 'single'
vim.o.signcolumn = 'number'
vim.o.number = true
vim.o.cursorline = true
vim.opt.shortmess:append 'sflmTWAIq'
vim.opt.fillchars:append { eob = ' ' }
