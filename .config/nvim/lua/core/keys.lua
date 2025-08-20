vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

vim.api.nvim_create_user_command('W', 'w', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq!', { bang = true, nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q', { nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q!', { bang = true, nargs = '*' })
