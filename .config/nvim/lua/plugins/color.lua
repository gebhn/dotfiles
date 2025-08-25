vim.pack.add {
    { src = 'https://github.com/rktjmp/lush.nvim', confirm = false },
    { src = 'https://github.com/zenbones-theme/zenbones.nvim', confirm = false },
}

vim.api.nvim_command 'colorscheme zenbones'
vim.o.background = 'light'

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'Statusline', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SpellBad', { link = 'Error', underline = true })
vim.api.nvim_set_hl(0, 'Pmenu', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'Visual' })
