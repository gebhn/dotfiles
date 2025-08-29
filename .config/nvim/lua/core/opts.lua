-- core
vim.lsp.enable { 'bashls', 'clangd', 'gopls', 'lua_ls' }
vim.o.updatetime = 500

-- ui
vim.o.winborder = 'single'
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = 'number'
vim.opt.shortmess:append 'sflmTWAIq'
vim.opt.fillchars:append { eob = ' ' }

-- buffers
vim.o.hidden = true
vim.o.swapfile = false
vim.o.undofile = true

-- completion
vim.o.pumheight = 10
vim.o.completeopt = 'menu,menuone,noselect,fuzzy,popup'

-- status/cmd
vim.o.cmdheight = 0
vim.o.laststatus = 3

-- help/splits
vim.o.helpheight = 10
vim.o.splitbelow = true

-- whitespace
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
