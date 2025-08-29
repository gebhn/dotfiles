local cmd = vim.api.nvim_create_user_command
local set = vim.keymap.set

set('i', 'jk', '<Esc>', { desc = 'enter normal mode' })
set('n', '<leader>nf', ':e %:h/', { desc = 'create a new adjacent file' })
set('n', 'ff', ':find<space>', { desc = 'search for files' })
set('n', 'fg', ':Grep<space>', { desc = 'search in files' })
set('n', 'fae', ':Diagnostics<CR>', { desc = 'lsp diagnostics to qflist' })

cmd('W', 'w', { nargs = '*' })
cmd('Wq', 'wq', { nargs = '*' })
cmd('Wq', 'wq!', { bang = true, nargs = '*' })
cmd('Q', 'q', { nargs = '*' })
cmd('Q', 'q!', { bang = true, nargs = '*' })
