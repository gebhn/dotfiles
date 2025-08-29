function _G.RgGrep(cmdarg, _)
    if #cmdarg == 0 then
        return {}
    end
    local results =
        vim.fn.systemlist('rg --vimgrep --color=never --hidden --glob="!.git" ' .. vim.fn.shellescape(cmdarg))

    for i, line in ipairs(results) do
        results[i] = line:gsub(':(%d+):%d+:', ':%1:')
    end

    return results
end

vim.o.completefunc = 'v:lua.RgGrep'

vim.api.nvim_create_user_command('Grep', function(opts)
    local item = opts.args
    local filename, lnum = item:match '([^:]+):(%d+):'
    if filename and lnum then
        vim.cmd('edit ' .. filename)
        vim.fn.cursor(lnum, 1)
    end
end, {
    nargs = '*',
    complete = 'customlist,v:lua.RgGrep',
})
