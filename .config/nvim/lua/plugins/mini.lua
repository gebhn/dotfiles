vim.pack.add {
    { src = 'https://github.com/echasnovski/mini.comment', confirm = false },
    { src = 'https://github.com/echasnovski/mini.extra', confirm = false },
    { src = 'https://github.com/echasnovski/mini.pairs', confirm = false },
    { src = 'https://github.com/echasnovski/mini.surround', confirm = false },
    { src = 'https://github.com/echasnovski/mini.pick', confirm = false },
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
        choose = '<C-y>',
        move_down = '<C-n>',
        move_up = '<C-p>',
        refine = '<C-space>',
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

vim.keymap.set('n', 'fe', extra.pickers.diagnostic, { noremap = true })
vim.keymap.set('n', 'ff', pick.builtin.files, { noremap = true })
vim.keymap.set('n', 'fg', pick.builtin.grep_live, { noremap = true })
