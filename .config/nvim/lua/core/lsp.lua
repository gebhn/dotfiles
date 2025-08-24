vim.lsp.enable { 'bashls', 'gopls', 'lua_ls', 'clangd', 'ts_ls' }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        vim.diagnostic.config {
            update_in_insert = true,
        }

        vim.api.nvim_create_autocmd('CursorHold', {
            pattern = { '<buffer>' },
            callback = function() vim.diagnostic.open_float { focusable = false, focus = false } end,
        })

        local map = function(key, fn)
            vim.keymap.set('n', key, fn, {
                buffer = args.buf,
                silent = true,
                noremap = true,
            })
        end

        map('gd', vim.lsp.buf.definition)
        map('gD', vim.lsp.buf.declaration)
        map('gr', vim.lsp.buf.references)
        map('gi', vim.lsp.buf.implementation)
        map('K', vim.lsp.buf.hover)
        map('qf', vim.lsp.buf.code_action)
        map('<leader>rn', vim.lsp.buf.rename)
        map('fne', function() vim.diagnostic.jump { count = 1, float = true } end)
        map('fpe', function() vim.diagnostic.jump { count = -1, float = true } end)

        -- TODO: This is still shit
        -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, args.buf) then
        --     local chars = {}
        --     for i = 32, 126 do
        --         table.insert(chars, string.char(i))
        --     end
        --     client.server_capabilities.completionProvider.triggerCharacters = chars
        --     vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
        --     vim.lsp.completion.enable(true, client.id, args.buf, {
        --         autotrigger = true,
        --         convert = function() return { abbr = '', menu = '' } end,
        --     })
        -- end
    end,
})
