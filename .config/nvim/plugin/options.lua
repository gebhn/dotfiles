local d = vim.fn.globpath(vim.fn.stdpath 'config' .. '/lsp', '*.lua', true, true)

local servers = vim.iter(d):map(function(p)
	return vim.fn.fnamemodify(p, ':t:r')
end)

-- lsp
vim.lsp.enable(servers:totable())

-- core
vim.o.updatetime = 300
vim.o.timeoutlen = 300

-- buffers
vim.o.hidden = true
vim.o.swapfile = false
vim.o.undofile = true

-- completion
vim.o.pumheight = 10
vim.opt.completeopt:append { 'menuone', 'noselect', 'fuzzy', }

-- status/cmd
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.statusline = ' '
vim.o.wildmode = 'noselect,full'

-- help/splits
vim.o.helpheight = 10
vim.o.splitbelow = true

-- whitespace
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- ui
vim.o.background = 'light'
vim.o.winborder = 'single'
vim.o.pumborder = 'single'
vim.o.signcolumn = 'number'
vim.o.number = true
vim.o.cursorline = true
vim.opt.shortmess:append 'sflmTWAIq'
vim.opt.fillchars:append { eob = ' ' }
