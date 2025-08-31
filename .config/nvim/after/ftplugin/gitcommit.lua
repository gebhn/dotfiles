vim.o.textwidth = 50
vim.opt.formatoptions:append 'tq'
vim.o.wrap = true
vim.o.spell = true

vim.keymap.set('n', 'fne', ']s')
vim.keymap.set('n', 'fpe', '[s')
vim.keymap.set({ 'n', 'v' }, 'gra', 'z=')
