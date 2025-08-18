local function next_diagnostic()
    vim.diagnostic.jump { count = 1, float = true }
end

local function prev_diagnostic()
    vim.diagnostic.jump { count = -1, float = true }
end

local function hover()
    vim.lsp.buf.hover { border = 'single', max_height = 30, max_widith = 120 }
end

vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>p', '"0p')
vim.keymap.set('n', 'q:', ':q')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true })
vim.keymap.set('n', 'K', hover, { noremap = true })
vim.keymap.set('n', 'qf', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true })
vim.keymap.set('n', 'fne', next_diagnostic, { noremap = true })
vim.keymap.set('n', 'fpe', prev_diagnostic, { noremap = true })

vim.api.nvim_create_user_command('W', 'write', { nargs = '?', bang = true })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = '?', bang = true })
vim.api.nvim_create_user_command('Q', 'quit', { nargs = '?', bang = true })
