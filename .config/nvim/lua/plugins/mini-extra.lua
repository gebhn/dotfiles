local mini = require 'mini.deps'

mini.add { source = 'echasnovski/mini.extra' }
mini.later(function()
    local plugin = require 'mini.extra'
    plugin.setup {}
end)
