local mini = require 'mini.deps'

mini.add { source = 'echasnovski/mini.surround' }
mini.later(function()
    local plugin = require 'mini.surround'
    plugin.setup {}
end)
