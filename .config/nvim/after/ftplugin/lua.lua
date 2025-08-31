vim.api.nvim_create_autocmd('BufWritePre', {
	group = vim.api.nvim_create_augroup('lua-autocmd', { clear = true }),
	callback = function()
		vim.lsp.buf.format { async = false }
	end
})
