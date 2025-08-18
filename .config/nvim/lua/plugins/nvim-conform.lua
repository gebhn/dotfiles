vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

local plugin = require 'conform'
plugin.setup {
    notify_on_error = false,
    format_on_save = { lsp_fallback = true, timeout_ms = 500 },
    formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
        lua = { 'stylua' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        ['_'] = { 'trim_whitespace' },
    },
}
