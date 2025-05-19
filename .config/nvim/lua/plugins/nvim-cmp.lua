local mini = require 'mini.deps'

mini.add {
    source = 'hrsh7th/nvim-cmp',
    depends = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'onsails/lspkind.nvim',
    },
}
mini.now(function()
    local plugin = require 'cmp'
    local lspkind = require 'lspkind'
    local snip = require 'luasnip'

    plugin.setup {
        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },
        window = {
            documentation = plugin.config.window.bordered { border = 'single' },
            completion = plugin.config.window.bordered {
                border = 'single',
                side_padding = 0,
            },
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
                local strings = vim.split(kind.kind, '%s', { trimempty = true })
                kind.kind = ' ' .. (strings[1] or '') .. ' '
                kind.menu = '    [' .. (strings[2] or '') .. ']'
                return kind
            end,
        },
        mapping = {
            ['<Tab>'] = plugin.mapping.select_next_item(),
            ['<S-Tab>'] = plugin.mapping.select_prev_item(),
            ['<CR>'] = plugin.mapping {
                i = function(fallback)
                    if plugin.visible() then
                        plugin.confirm { behavior = plugin.ConfirmBehavior.Replace, select = true }
                    else
                        fallback()
                    end
                end,
                s = plugin.mapping.confirm { select = true },
                c = plugin.mapping.confirm { behavior = plugin.ConfirmBehavior.Replace, select = true },
            },
        },
        sources = plugin.config.sources {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        },
        sorting = {
            comparators = {
                plugin.config.compare.offset,
                plugin.config.compare.exact,
                plugin.config.compare.score,
                function(a, b)
                    local _, a_under = a.completion_item.label:find '^_+'
                    local _, b_under = b.completion_item.label:find '^_+'
                    a_under = a_under or 0
                    b_under = b_under or 0
                    if a_under > b_under then
                        return false
                    elseif a_under < b_under then
                        return true
                    end
                end,
                plugin.config.compare.kind,
                plugin.config.compare.sort_text,
                plugin.config.compare.length,
                plugin.config.compare.order,
            },
        },
        experimental = {
            ghost_text = false,
        },
    }
end)
