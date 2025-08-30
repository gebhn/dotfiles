vim.keymap.set('i', 'jk', '<Esc>', { desc = 'normal mode, normal keymap' })

vim.keymap.set('c', '<C-f>', Refine, { desc = 'refine find results', expr = true })

vim.keymap.set('n', 'ff', ':find ', { desc = 'search for files' })
vim.keymap.set('n', 'fg', ':Grep ', { desc = 'search in files' })
vim.keymap.set('n', 'fae', ':Fix<CR>', { desc = 'lsp diagnostics to qflist' })
vim.keymap.set('n', '<leader>nf', ':e %:h/', { desc = 'create a new adjacent file' })

vim.api.nvim_create_user_command('W', 'w', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq!', { bang = true, nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q', { nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q!', { bang = true, nargs = '*' })
