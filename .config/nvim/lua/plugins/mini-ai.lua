local mini = require 'mini.deps'

mini.add { source = 'echasnovski/mini.ai' }
mini.later(function()
    local plugin = require 'mini.ai'
    plugin.setup {
        n_lines = 500,
        custom_textobjects = {
            o = plugin.gen_spec.treesitter({
                a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                i = { '@block.inner', '@conditional.inner', '@loop.inner' },
            }, {}),
            f = plugin.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
            c = plugin.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
            t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
        silent = true,
    }
end)
