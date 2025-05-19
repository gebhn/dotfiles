local mini = require 'mini.deps'

mini.add { source = 'echasnovski/mini.comment' }
mini.later(function()
    local plugin = require 'mini.comment'
    plugin.setup {
        mappings = {
            comment = 'gc',
            comment_line = 'gcc',
        },
    }
end)
