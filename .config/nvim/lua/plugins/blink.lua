local plugin = require 'blink.cmp'

plugin.setup {
    fuzzy = { implementation = 'lua' },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    signature = { enabled = true },
    keymap = {
        preset = 'default',
    },
}
