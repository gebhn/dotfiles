require('mini.completion').setup {}
require('mini.surround').setup {}

local statusline = require 'mini.statusline'

statusline.setup {
    content = {
        active = function()
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
        end,
    },
}
