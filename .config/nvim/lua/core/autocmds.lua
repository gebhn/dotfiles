vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, 'auto-cursorline')
        end
    end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
            vim.wo.cursorline = false
        end
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.textwidth = 50
        vim.opt_local.formatoptions:append 'tq'
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'text' },
    callback = function()
        vim.opt_local.formatoptions:append 'tq'
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'text', 'gitcommit' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.keymap.set('n', 'fne', ']s', { buffer = true })
        vim.keymap.set('n', 'fpe', '[s', { buffer = true })
        vim.keymap.set('n', '<leader>qf', 'z=', { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'c', 'cpp', 'lua', 'go' },
    callback = function()
        vim.opt_local.formatoptions:append 'cq'
    end,
})
