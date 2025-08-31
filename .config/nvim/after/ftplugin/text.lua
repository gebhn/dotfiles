vim.opt_local.formatoptions:append 'tq'
vim.opt_local.wrap = true
vim.opt_local.spell = true

vim.keymap.set('n', 'fne', ']s')
vim.keymap.set('n', 'fpe', '[s')
vim.keymap.set({ 'n', 'v' }, 'gra', 'z=')
