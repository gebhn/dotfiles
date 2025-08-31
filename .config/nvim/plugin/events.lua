local group = vim.api.nvim_create_augroup('config-autocmds', { clear = true })

-- general lsp
vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local next = function()
			vim.diagnostic.jump { count = 1, float = true }
		end

		local prev = function()
			vim.diagnostic.jump { count = -1, float = true }
		end

		vim.api.nvim_create_autocmd('CursorHold', {
			pattern = { '<buffer>' },
			callback = function()
				vim.diagnostic.open_float {
					focusable = false,
					focus = false,
				}
			end,
		})

		vim.diagnostic.config { update_in_insert = true }

		vim.keymap.set('n', 'grd', vim.lsp.buf.definition)
		vim.keymap.set('n', 'fne', next)
		vim.keymap.set('n', 'fpe', prev)
	end,
})

-- lsp completion
vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method 'textDocument/completion' then
			return
		end

		local chars = client.server_capabilities.completionProvider.triggerCharacters
		if chars then
			for i = string.byte('a'), string.byte('z') do
				if not vim.list_contains(chars, string.char(i)) then
					table.insert(chars, string.char(i))
				end
			end

			for i = string.byte('A'), string.byte('Z') do
				if not vim.list_contains(chars, string.char(i)) then
					table.insert(chars, string.char(i))
				end
			end
		end

		vim.lsp.completion.enable(true, client.id, args.buf, {
			autotrigger = true,
			convert = function(item)
				local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'u'
				return {
					kind = kind:sub(1, 1):lower(),
					menu = '',
				}
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ 'CmdlineChanged', 'CmdlineLeave' }, {
	group = group,
	pattern = { '*' },
	callback = function(args)
		local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), ' ')[1]

		if
			args.event == 'CmdlineChanged' and cmdline_cmd == 'find'
			or cmdline_cmd == 'help'
			or cmdline_cmd == 'Grep'
			or cmdline_cmd == 'h'
		then
			vim.o.wildmode = 'noselect:lastused,full'
			vim.fn.wildtrigger()
		end

		if args.event == 'CmdlineLeave' then
			vim.o.wildmode = 'full'
			_G.Current = _G.All
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
