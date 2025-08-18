vim.pack.add {
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
}

local function on_attach(_, _)
    vim.diagnostic.config {
        update_in_insert = true,
        -- float = { border = 'single' },
    }
    vim.api.nvim_create_autocmd('CursorHold', {
        pattern = { '<buffer>' },
        callback = function()
            vim.diagnostic.open_float { focusable = false, focus = false }
        end,
    })
end

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

lspconfig.ts_ls.setup {
    on_attach = on_attach,
}

lspconfig.zls.setup {
    on_attach = on_attach,
}

local path = vim.split(package.path, ';')
table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

lspconfig.lua_ls.setup {
    on_attach = on_attach,
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
