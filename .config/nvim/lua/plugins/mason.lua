local plugin = require 'mason'
plugin.setup {}

local has = function(cmd)
    return vim.fn.executable(cmd) == 1
end

local has_go = function()
    return has 'go'
end

local has_npm = function()
    return has 'npm'
end

local has_glibc = function()
    if has 'ldd' then
        local ldd_output = vim.fn.system 'ldd --version 2>&1'
        return not ldd_output:find 'musl'
    end
end

local installer = require 'mason-tool-installer'
installer.setup {
    ensure_installed = {
        { 'lua-language-server' },
        { 'stylua' },
        { 'shellcheck' },
        { 'gopls', condition = has_go },
        { 'gofumpt', condition = has_go },
        { 'goimports', condition = has_go },
        { 'staticcheck', condition = has_go },
        { 'delve', condition = has_go },
        { 'clangd', condition = has_glibc },
        { 'clang-format', condition = has_glibc },
        { 'bash-language-server', condition = has_npm },
    },
}
