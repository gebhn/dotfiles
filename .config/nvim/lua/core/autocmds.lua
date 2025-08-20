local augroup = vim.api.nvim_create_augroup('config-autocmds', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = augroup,
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, 'auto-cursorline')
        end
    end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = augroup,
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
            vim.wo.cursorline = false
        end
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.textwidth = 50
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'text', 'gitcommit' },
    callback = function(args)
        vim.opt_local.formatoptions:append 'tq'
        vim.opt_local.wrap = true
        vim.opt_local.spell = true

        vim.keymap.set('n', 'fne', ']s', { buffer = args.buf })
        vim.keymap.set('n', 'fpe', '[s', { buffer = args.buf })
        vim.keymap.set('n', '<leader>qf', 'z=', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'c', 'cpp', 'lua', 'go', 'typescript', 'javascript' },
    callback = function()
        vim.opt_local.formatoptions:append 'cq'
    end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = augroup,
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, 'auto-cursorline')
        end
    end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = augroup,
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
            vim.wo.cursorline = false
        end
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.textwidth = 50
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'text', 'gitcommit' },
    callback = function(args)
        vim.opt_local.formatoptions:append 'tq'
        vim.opt_local.wrap = true
        vim.opt_local.spell = true

        vim.keymap.set('n', 'fne', ']s', { buffer = args.buf })
        vim.keymap.set('n', 'fpe', '[s', { buffer = args.buf })
        vim.keymap.set('n', '<leader>qf', 'z=', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = { 'c', 'cpp', 'lua', 'go', 'typescript', 'javascript' },
    callback = function()
        vim.opt_local.formatoptions:append 'cq'
    end,
})
