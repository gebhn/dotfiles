local group = vim.api.nvim_create_augroup('general-config', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
	group = group,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = args.buf })
		vim.keymap.set('n', 'grs', vim.lsp.buf.document_symbol, { buffer = args.buf })

		if client:supports_method 'textDocument/completion' then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				convert = function()
					return { menu = '' }
				end,
			})
		end

		if client:supports_method 'textDocument/formatting' then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format { bufnr = args.buf, id = client.id }
				end,
			})
		end
	end,
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
	group = group,
	callback = function()
		local cmd = vim.fn.getcmdline():match('^%S+')
		if not vim.tbl_contains({ 'w', 'wq', 'x', 'x!', 'q', 'q!' }, cmd) then
			vim.fn.wildtrigger()
		end
	end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
	group = group,
	pattern = { 'grep', 'make' },
	callback = function()
		vim.cmd.copen()
	end
})

vim.api.nvim_create_autocmd('FileType', {
	group = group,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
