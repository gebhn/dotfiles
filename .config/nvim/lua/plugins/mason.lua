vim.pack.add {
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

local plugin = require 'mason'
plugin.setup {}

local has_go = function()
    return vim.fn.executable 'go' == 1
end

local has_rust = function()
    return vim.fn.executable 'cargo' == 1
end

local installer = require 'mason-tool-installer'
installer.setup {
    ensure_installed = {
        { 'lua-language-server' },
        { 'stylua' },
        { 'shellcheck' },
        { 'clang-format' },
        { 'gopls', condition = has_go },
        { 'gofumpt', condition = has_go },
        { 'goimports', condition = has_go },
        { 'staticcheck', condition = has_go },
        { 'rust-analyzer', condition = has_rust },
    },
}
