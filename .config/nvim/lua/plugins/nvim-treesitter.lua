vim.pack.add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
}

local plugin = require 'nvim-treesitter.configs'

plugin.setup {
    auto_install = true,
    sync_install = true,
    ignore_install = {},
    ensure_installed = {
        'c',
        'bash',
        'go',
        'lua',
        'javascript',
        'typescript',
        'vimdoc',
        'markdown',
    },
    highlight = { enable = true, language_tree = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['a='] = '@assignment.outer',
                ['i='] = '@assignment.inner',
                ['l='] = '@assignment.lhs',
                ['r='] = '@assignment.rhs',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['ac'] = '@comment.outer',
                ['ic'] = '@comment.inner',
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
            },
        },
    },
}

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        if args.data.spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
            vim.cmd 'TSUpdate'
        end
    end,
})
