local mini = require 'mini.deps'

mini.add { source = 'williamboman/mason.nvim' }
mini.now(function()
    local plugin = require 'mason'
    plugin.setup {}
end)
