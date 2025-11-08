local group = vim.api.nvim_create_augroup('general-config', { clear = true })

local format = function(d)
	return #d.message > 70 and d.message:sub(1, 67) .. '...' or d.message
end

local fix = function()
	if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
		vim.diagnostic.setqflist({ format = format })
	end
end

local open = function()
	vim.diagnostic.setqflist { format = format }
	return #vim.fn.getqflist() > 0 and vim.cmd.copen()
end

local hover = function()
	vim.diagnostic.open_float { focusable = false, focus = false }
end

local next = function()
	vim.diagnostic.jump { count = 1, float = true }
end

local prev = function()
	vim.diagnostic.jump { count = -1, float = true }
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		vim.diagnostic.config { update_in_insert = true }

		vim.api.nvim_create_autocmd('CursorHold', { callback = hover })
		vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = fix })

		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = args.buf })
		vim.keymap.set('n', 'gne', next, { buffer = args.buf })
		vim.keymap.set('n', 'gpe', prev, { buffer = args.buf })
		vim.keymap.set('n', 'gae', open, { buffer = args.buf })

		if client:supports_method 'textDocument/completion' then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				convert = function(item)
					local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'u'
					return { menu = '', kind = kind:sub(1, 1):lower() }
				end,
			})
		end

		if client:supports_method 'textDocument/formatting' then
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
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	group = group,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
