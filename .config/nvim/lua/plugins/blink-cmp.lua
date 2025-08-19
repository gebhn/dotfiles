vim.pack.add { 'https://github.com/Saghen/blink.cmp' }

local plugin = require 'blink.cmp'

plugin.setup {
    build = 'cargo build --release',
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
}
