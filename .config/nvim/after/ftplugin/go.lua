vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('go-autocmd', { clear = true }),
	callback = function()
		vim.lsp.buf.format { async = false }
		vim.cmd [[silent! !goimports -w %]]
	end
})
