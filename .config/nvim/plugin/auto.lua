local group = vim.api.nvim_create_augroup('minimal-config', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		vim.diagnostic.config { update_in_insert = true }

		local fix_diagnostics = function()
			local current_win = vim.api.nvim_get_current_win()

			for _, win in ipairs(vim.fn.getwininfo()) do
				if win.quickfix == 1 then
					vim.diagnostic.setqflist()
					vim.api.nvim_set_current_win(current_win)
				end
			end
		end

		local hover_diagnostic = function()
			vim.diagnostic.open_float { focusable = false, focus = false }
		end

		local next_diagnostic = function()
			vim.diagnostic.jump { count = 1, float = true }
		end

		local prev_diagnostic = function()
			vim.diagnostic.jump { count = -1, float = true }
		end

		vim.api.nvim_create_autocmd('CursorHold', { callback = hover_diagnostic })
		vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = fix_diagnostics })

		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = args.buf })
		vim.keymap.set('n', 'gne', next_diagnostic, { buffer = args.buf })
		vim.keymap.set('n', 'gpe', prev_diagnostic, { buffer = args.buf })

		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				convert = function()
					return { menu = '' }
				end,
			})
		end

		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 500 })
				end,
			})
		end
	end
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
	group = group,
	callback = function()
		vim.o.wildmode = 'full'
	end
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
	group = group,
	callback = function()
		local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), ' ')[1]

		local is_help = cmdline_cmd == 'help' or cmdline_cmd == 'h'
		local is_cmd = cmdline_cmd == 'Pick' or cmdline_cmd == 'Grep'

		if is_help or is_cmd then
			vim.o.wildmode = 'noselect,full'
			vim.fn.wildtrigger()
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
