vim.api.nvim_command 'colorscheme quiet'

vim.api.nvim_set_hl(0, 'Statusline', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SnippetTabstop', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SnippetTabstopActive', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE', ctermbg = 'NONE' })

vim.api.nvim_set_hl(0, '@diff.plus', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, '@diff.minus', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, '@diff.delta', { link = 'DiffChange' })

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { link = 'Error' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { link = 'Warn' })

vim.api.nvim_set_hl(0, 'MiniPickPrompt', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'MiniPickMatchRanges', { link = 'Comment' })
