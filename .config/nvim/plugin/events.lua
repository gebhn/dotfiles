local group = vim.api.nvim_create_augroup('config-autocmds', { clear = true })

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

vim.api.nvim_create_autocmd('CmdlineEnter', {
	group = group,
	pattern = ':',
	callback = function()
		vim.keymap.set('c', '<C-y>', function()
			local cmd_type = vim.fn.getcmdtype()
			local cmd_line = vim.fn.getcmdline()
			if cmd_type == ':' and cmd_line:match '^find' or cmd_line:match '^Grep' then
				return '<CR>'
			else
				return '<C-y>'
			end
		end, { expr = true })
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

vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = group,
	pattern = { 'text', 'gitcommit' },
	callback = function(args)
		if args.match == 'gitcommit' then
			vim.opt_local.textwidth = 50
		end
		vim.opt_local.formatoptions:append 'tq'
		vim.opt_local.wrap = true
		vim.opt_local.spell = true

		vim.keymap.set('n', 'fne', ']s', { buffer = args.buf })
		vim.keymap.set('n', 'fpe', '[s', { buffer = args.buf })
		vim.keymap.set({ 'n', 'v' }, 'gra', 'z=', { buffer = args.buf })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
