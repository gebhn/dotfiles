local choose_all = function(pick)
    return {
        char = '<C-q>',
        func = function()
            local mappings = pick.get_picker_opts().mappings
            vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
        end,
    }
end

local window_config = function()
    return {
        anchor = 'NW',
        row = vim.o.lines - math.floor(vim.o.lines * 0.3),
        col = 0,
        height = math.floor(vim.o.lines * 0.3),
        width = vim.o.columns,
    }
end

local active_statusline = function(statusline)
    return function()
        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
        return statusline.combine_groups {
            {
                hl = mode_hl,
                strings = {
                    mode:lower(),
                },
            },
            {
                hl = 'MiniStatuslineFileinfo',
                strings = {
                    statusline.section_filename { trunc_width = 140 },
                },
            },
            '%=',
            {
                hl = 'MiniStatuslineFilename',
                strings = {
                    statusline.section_fileinfo { trunc_width = 120 },
                },
            },
        }
    end
end

local statusline = require 'mini.statusline'
statusline.setup {
    content = {
        active = active_statusline(statusline),
    },
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
        choose_all = choose_all(pick),
    },
    window = {
        config = window_config,
    },
}

vim.keymap.set('n', 'fae', extra.pickers.diagnostic, { noremap = true })
vim.keymap.set('n', 'ff', pick.builtin.files, { noremap = true })
vim.keymap.set('n', 'fg', pick.builtin.grep_live, { noremap = true })
