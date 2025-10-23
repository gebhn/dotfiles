vim.o.makeprg = 'make $*'

vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('go-ftplugin', { clear = true }),
	callback = function()
		vim.cmd [[silent! !goimports -w %]]
	end
})
