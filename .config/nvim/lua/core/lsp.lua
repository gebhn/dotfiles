vim.lsp.enable { 'gopls', 'lua_ls', 'ts_ls' }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        vim.diagnostic.config {
            update_in_insert = true,
        }

        vim.api.nvim_create_autocmd('CursorHold', {
            pattern = { '<buffer>' },
            callback = function()
                vim.diagnostic.open_float { focusable = false, focus = false }
            end,
        })

        local map = function(k, f)
            vim.keymap.set('n', k, f, { buffer = args.buf, silent = true, noremap = true })
        end

        map('gd', vim.lsp.buf.definition)
        map('gD', vim.lsp.buf.declaration)
        map('gr', vim.lsp.buf.references)
        map('gi', vim.lsp.buf.implementation)
        map('K', vim.lsp.buf.hover)
        map('qf', vim.lsp.buf.code_action)
        map('<leader>rn', vim.lsp.buf.rename)
        map('fne', function()
            vim.diagnostic.jump { count = 1, float = true }
        end)
        map('fpe', function()
            vim.diagnostic.jump { count = -1, float = true }
        end)

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, args.buf) then
            local augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = args.buf,
                group = augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = args.buf,
                group = augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-lowlight', { clear = true }),
                callback = function(ev)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = augroup, buffer = ev.buf }
                end,
            })
        end
    end,
})
