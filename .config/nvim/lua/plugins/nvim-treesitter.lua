local mini = require 'mini.deps'

mini.add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    monitor = 'main',
    hooks = {
        post_checkout = function()
            vim.cmd 'TSUpdate'
        end,
    },
}

mini.later(function()
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
            'zig',
        },
        highlight = { enable = true },
        modules = {},
    }
end)
