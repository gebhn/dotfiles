local mini = require 'mini.deps'

mini.add { source = 'echasnovski/mini.pairs' }
mini.later(function()
    local plugin = require 'mini.pairs'
    plugin.setup {}
end)
