local mini = require 'mini.deps'

local window_setup = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
    }
end

mini.add { source = 'echasnovski/mini.pick' }
mini.later(function()
    local plugin = require 'mini.pick'
    plugin.setup {
        mappings = {
            move_down = '<C-j>',
            move_up = '<C-k>',
        },
        window = { config = window_setup },
    }

    local git = function()
        require('mini.pick').builtin.files { tool = 'git' }
    end

    local rg = function()
        require('mini.pick').builtin.grep_live { tool = 'rg' }
    end

    local dg = function()
        require('mini.extra').pickers.diagnostic()
    end

    vim.keymap.set('n', '<C-p>', git, { noremap = true })
    vim.keymap.set('n', '<C-g>', rg, { noremap = true })
    vim.keymap.set('n', 'fae', dg, { noremap = true })
end)
