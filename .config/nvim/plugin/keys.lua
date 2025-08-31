vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('c', '<C-f>', _G.Refine)
vim.keymap.set('c', '<C-y>', '<CR>')

vim.keymap.set('n', 'ff', ':find ')
vim.keymap.set('n', 'fg', ':Grep ')
vim.keymap.set('n', 'fae', ':Fix<CR>')
vim.keymap.set('n', '<leader>nf', ':e %:h/')

vim.api.nvim_create_user_command('W', 'w', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = '*' })
vim.api.nvim_create_user_command('Wq', 'wq!', { bang = true, nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q', { nargs = '*' })
vim.api.nvim_create_user_command('Q', 'q!', { bang = true, nargs = '*' })
