local mini = require 'mini.deps'

local diagnostic_settings = {
    underline = {
        severity = vim.diagnostic.severity.WARN,
    },
    virtual_text = false,
    signs = {
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
    },
    update_in_insert = true,
    float = { border = 'single' },
}

local function on_attach(_, _)
    vim.diagnostic.config(diagnostic_settings)

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        pattern = { '<buffer>' },
        callback = function()
            vim.diagnostic.open_float { focusable = false, focus = false }
        end,
    })
end

local path = vim.split(package.path, ';')
table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

mini.add {
    source = 'neovim/nvim-lspconfig',
    depends = { 'williamboman/mason.nvim' },
}

mini.now(function()
    local lspconfig = require 'lspconfig'

    lspconfig.gopls.setup {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.o.list = false
        end,
        settings = {
            gopls = {
                analyses = {
                    unreachable = true,
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }

    lspconfig.zls.setup {
        on_attach = on_attach,
    }

    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern '.git/',
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = path,
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    checkThirdParty = false,
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.stdpath 'data' .. '/site/pack/deps/opt'] = true,
                    },
                },
            },
        },
    }
end)
