vim.api.nvim_command 'colorscheme zenbones'
vim.o.background = 'light'

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'Statusline', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SpellBad', { link = 'Error', underline = true })
vim.api.nvim_set_hl(0, 'Pmenu', { link = 'Normal' })
