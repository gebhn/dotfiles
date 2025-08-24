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
comment.setup {}

local pick = require 'mini.pick'
pick.setup {
    options = { content_from_bottom = true },
    mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>',
        refine = '<C-p>',
        choose_all = {
            char = '<C-q>',
            func = function()
                local mappings = pick.get_picker_opts().mappings
                vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
            end,
        },
    },
    window = {
        config = function()
            return {
                anchor = 'NW',
                row = vim.o.lines - math.floor(vim.o.lines * 0.3),
                col = 0,
                height = math.floor(vim.o.lines * 0.3),
                width = vim.o.columns,
            }
        end,
    },
}

vim.keymap.set('n', 'fae', extra.pickers.diagnostic, { noremap = true })
vim.keymap.set('n', '<C-p>', pick.builtin.files, { noremap = true })
vim.keymap.set('n', '<C-g>', pick.builtin.grep_live, { noremap = true })
