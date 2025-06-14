local mini = require 'mini.deps'

mini.add { source = 'stevearc/conform.nvim' }
mini.later(function()
    local plugin = require 'conform'
    plugin.setup {
        notify_on_error = false,
        format_on_save = { lsp_fallback = true, timeout_ms = 500 },
        formatters_by_ft = {
            go = { 'goimports', 'staticcheck', 'gofumpt' },
            lua = { 'stylua' },
            zig = { 'zigfmt' },
            javascript = { 'prettierd', 'eslintd' },
            typescript = { 'prettierd', 'eslintd' },
            ['_'] = { 'trim_whitespace' },
        },
    }
end)
