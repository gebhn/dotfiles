local group = vim.api.nvim_create_augroup('minimal-config', { clear = true })

local setup_triggers = function(client)
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
end

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
					vim.diagnostic.setqflist {
						format = function(diag)
							if #diag.message > 70 then
								return diag.message:sub(1, 70 - 3) .. '...'
							end
							return diag.message
						end
					}
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
			setup_triggers(client)
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
					vim.lsp.buf.format {
						bufnr = args.buf,
						id = client.id,
						timeout_ms = 500,
					}
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

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
	pattern = 'make',
	callback = function()
		if not vim.tbl_isempty(vim.fn.getqflist()) then
			vim.cmd.copen()
		end
	end
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
	group = group,
	callback = function()
		local cmd = vim.fn.getcmdline():match('^%S+')

		local is = function(name)
			return vim.tbl_contains(vim.fn.getcompletion(name, 'cmdline'), cmd)
		end

		if is 'help' or is 'Files' or is 'Grep' then
			vim.opt.wildmode = 'noselect,full'
			vim.fn.wildtrigger()
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
