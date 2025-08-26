vim.lsp.enable { 'bashls', 'gopls', 'lua_ls', 'clangd', 'ts_ls' }

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
        map('fne', function()
            vim.diagnostic.jump { count = 1, float = true }
        end)
        map('fpe', function()
            vim.diagnostic.jump { count = -1, float = true }
        end)

        -- TODO: This is still shit
        -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, args.buf) then
        --     local chars = {}
        --     for i = 32, 126 do
        --         table.insert(chars, string.char(i))
        --     end
        --     client.server_capabilities.completionProvider.triggerCharacters = chars
        --     vim.o.cot = 'menu,menuone,noinsert,fuzzy,popup'
        --     vim.o.cia = 'kind,abbr,menu'
        --     vim.lsp.completion.enable(true, client.id, args.buf, {
        --         autotrigger = true,
        --         convert = function()
        --             return { abbr = '', menu = '' }
        --         end,
        --     })
        -- end
        --
        -- if client:supports_method(vim.lsp.protocol.Methods.completionItem_resolve) then
        --     vim.api.nvim_create_autocmd('CompleteChanged', {
        --         buffer = args.buf,
        --         callback = function()
        --             local info = vim.fn.complete_info { 'selected' }
        --             local completionItem =
        --                 vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
        --             if not completionItem then
        --                 return
        --             end
        --
        --             local resolvedItem = vim.lsp.buf_request_sync(
        --                 args.buf,
        --                 vim.lsp.protocol.Methods.completionItem_resolve,
        --                 completionItem,
        --                 500
        --             )
        --             if not resolvedItem then
        --                 return
        --             end
        --
        --             local docs = vim.tbl_get(resolvedItem[args.data.client_id], 'result', 'documentation', 'value')
        --             if not docs then
        --                 return
        --             end
        --
        --             local winData = vim.api.nvim__complete_set(info['selected'], { info = docs })
        --             if not winData.winid or not vim.api.nvim_win_is_valid(winData.winid) then
        --                 return
        --             end
        --
        --             vim.api.nvim_win_set_config(winData.winid, {})
        --             vim.treesitter.start(winData.bufnr, 'markdown')
        --             vim.wo[winData.winid].conceallevel = 3
        --         end,
        --     })
        -- end
    end,
})
