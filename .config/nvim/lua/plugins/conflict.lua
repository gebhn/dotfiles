local plugin = require 'conflict-marker'
plugin.setup {
    highlights = true,
    on_attach = function(conflict)
        local mark = '^=======$'
        local map = function(key, fn)
            vim.keymap.set('n', key, fn, { buffer = conflict.bufnr })
        end

        map('fnc', function()
            if vim.fn.search(mark, 'n') > 0 then
                vim.cmd('?' .. mark)
            end
        end)
        map('fpc', function()
            if vim.fn.search(mark, 'n') > 0 then
                vim.cmd('/' .. mark)
            end
        end)
        map('co', function()
            conflict:choose_ours()
        end)
        map('ct', function()
            conflict:choose_theirs()
        end)
        map('cb', function()
            conflict:choose_both()
        end)
        map('cn', function()
            conflict:choose_none()
        end)
    end,
}
