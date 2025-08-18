vim.pack.add {
    'https://github.com/echasnovski/mini.comment',
    'https://github.com/echasnovski/mini.extra',
    'https://github.com/echasnovski/mini.pairs',
    'https://github.com/echasnovski/mini.surround',
    'https://github.com/echasnovski/mini.pick',
}

local surround = require 'mini.surround'
surround.setup {}

local pairs = require 'mini.pairs'
pairs.setup {}

local extra = require 'mini.extra'
extra.setup {}

local comment = require 'mini.comment'
comment.setup {
    mappings = {
        comment = 'gc',
        comment_line = 'gcc',
    },
}

local pick = require 'mini.pick'
pick.setup {
    mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>',
    },
}

local git = function()
    pick.builtin.files { tool = 'git' }
end

local rg = function()
    pick.builtin.grep_live { tool = 'rg' }
end

local dg = function()
    extra.pickers.diagnostic()
end

vim.keymap.set('n', '<C-p>', git, { noremap = true })
vim.keymap.set('n', '<C-g>', rg, { noremap = true })
vim.keymap.set('n', 'fae', dg, { noremap = true })
