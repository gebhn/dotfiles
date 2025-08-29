local cmd = vim.api.nvim_create_autocmd
local g = vim.api.nvim_create_augroup('config-autocmds', { clear = true })

cmd('TextYankPost', {
	group = g,
	callback = function()
		vim.highlight.on_yank { higroup = 'Folded', timeout = 100 }
	end,
})

cmd('LspAttach', {
	group = g,
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

cmd('CmdlineEnter', {
	group = g,
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

cmd({ 'CmdlineChanged', 'CmdlineLeave' }, {
	group = g,
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
		end
	end,
})

cmd({ 'FileType' }, {
	group = g,
	pattern = { 'gitcommit' },
	callback = function()
		vim.opt_local.textwidth = 50
	end,
})

cmd({ 'FileType' }, {
	group = g,
	pattern = { 'text', 'gitcommit' },
	callback = function(args)
		vim.opt_local.formatoptions:append 'tq'
		vim.opt_local.wrap = true
		vim.opt_local.spell = true

		vim.keymap.set('n', 'fne', ']s', { buffer = args.buf })
		vim.keymap.set('n', 'fpe', '[s', { buffer = args.buf })
		vim.keymap.set({ 'n', 'v' }, 'gra', 'z=', { buffer = args.buf })
	end,
})
