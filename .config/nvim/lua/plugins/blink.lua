vim.pack.add {
    {
        src = 'https://github.com/Saghen/blink.cmp',
        version = vim.version.range '^1',
        confirm = false,
    },
}

local plugin = require 'blink.cmp'

plugin.setup {
    build = 'cargo build --release',
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    signature = { enabled = true },
    keymap = {
        preset = 'default',
    },
}
