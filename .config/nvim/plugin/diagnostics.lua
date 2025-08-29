vim.api.nvim_create_user_command('Diagnostics', function(_)
	local diagnostics = vim.diagnostic.get()
	local qflist = {}

	if #diagnostics == 0 then
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd 'cclose'
			end
		end
		return
	end

	for _, diag in ipairs(diagnostics) do
		local filename = vim.api.nvim_buf_get_name(diag.bufnr or 0)
		local lnum = diag.lnum + 1
		local col = diag.col + 1

		table.insert(qflist, {
			filename = filename,
			lnum = lnum,
			col = col,
			text = diag.message,
		})
	end

	vim.fn.setqflist({}, 'r', { items = qflist })
	vim.cmd 'copen'
end, {})
